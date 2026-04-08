# LINUS-AI — Build Guide

All builds go through a single script:

```bash
./build.sh [target] [engine-flag]
```

Run `./build.sh list` at any time to see which targets have been built and their binary sizes.

---

## Table of Contents

1. [Quick start](#1-quick-start)
2. [Inference engines](#2-inference-engines)
3. [Target × host compatibility matrix](#3-target--host-compatibility-matrix)
4. [Prerequisites by target](#4-prerequisites-by-target)
5. [Building every target — platform by platform](#5-building-every-target--platform-by-platform)
6. [Output locations](#6-output-locations)
7. [Clean](#7-clean)
8. [Workspace structure](#8-workspace-structure)
9. [CI/CD reference](#9-cicd-reference)
10. [Runtime requirements (end users)](#10-runtime-requirements-end-users)

---

## 1. Quick start

### Build & run (single node)

```bash
# Build for the current machine — automatically selects Metal on macOS
./build.sh

# Explicit native build
./build.sh native

# Show all targets and current build status
./build.sh list
```

Output lands in `dist/<target>/linus_ai` (or `dist/<target>-candle/linus_ai` for the candle engine — see §2).

```bash
# Run the server (default port 9480)
./dist/macos-arm64/linus_ai

# Open the control panel in your browser
open http://localhost:9480/app
# macOS/Windows: the system tray launcher opens it automatically
```

### GUI — Inference Mode switcher (Setup tab)

The **Setup → Inference Mode** card controls how every chat request is routed. The selection is saved across sessions.

| Mode | What it does | When to use |
|------|-------------|-------------|
| **Local** | Single-node via bundled llama.cpp / candle | Default; model fits on this machine |
| **Pipeline** | Layers distributed across N nodes sequentially | Model too large for any single node |
| **Tensor RPC** | Weight matrices split via `llama-rpc-server` | Lowest latency; fast LAN; homogeneous nodes |
| **Tensor Native** | AllReduce over HTTP (no external tools) | Phase 2 — planned |

### Activate Tensor Parallelism (RPC mode) — 2 nodes

**Prerequisites:** `brew install llama.cpp` (≥ b2373) on all nodes.

```bash
# Node B — worker (rank 1): start RPC server via GUI
# Setup tab → Tensor Parallelism → ▶ Start RPC Worker
# or via curl:
curl -X POST http://node-b:9480/tensor/rpc/start

# Node A — coordinator (rank 0): apply the plan via GUI
# Setup tab → select "Tensor RPC" → fill peer rows → Apply Plan
# or via curl:
curl -X POST http://node-a:9480/tensor/plan -H 'Content-Type: application/json' -d '{
  "plan_id": "plan-1", "world_size": 2, "local_rank": 0, "backend": "Rpc",
  "rpc_port": 9099, "coord_server_port": 9480,
  "model_path": "/path/to/model.gguf",
  "peers": [
    {"rank":0,"node_id":"a","address":"node-a:9480","rpc_address":"node-a:9099","ram_mb":32768,"gpu_backend":null},
    {"rank":1,"node_id":"b","address":"node-b:9480","rpc_address":"node-b:9099","ram_mb":16384,"gpu_backend":null}
  ]
}'

# Send inference (coordinator only)
curl -X POST http://node-a:9480/tensor/infer -d '{"prompt":"Hello","max_tokens":128}'
```

Weight splitting is automatic: each node's share is proportional to its `ram_mb`.

### Activate Pipeline Parallelism — 2 nodes

```bash
# Each node: apply its own slice via GUI
# Setup tab → select "Pipeline" → set node index + layer slice → Apply Plan
# or via curl on each node separately:

# Node A (index 0, layers 0-15):
curl -X POST http://node-a:9480/pipeline/plan -H 'Content-Type: application/json' -d '{
  "plan": [{"address":"node-a","port":9480},{"address":"node-b","port":9480}],
  "my_slice": [0, 16], "index": 0, "model_path": "/path/to/model.gguf"
}'

# Node B (index 1, layers 16-32):
curl -X POST http://node-b:9480/pipeline/plan -H 'Content-Type: application/json' -d '{
  "plan": [{"address":"node-a","port":9480},{"address":"node-b","port":9480}],
  "my_slice": [16, 32], "index": 1, "model_path": "/path/to/model.gguf"
}'

# Run inference through head node (index 0):
curl -X POST http://node-a:9480/pipeline/infer -d '{"prompt":"Hello","max_tokens":128}'
```

### Architecture reference

See [`FLOWCHART.html`](FLOWCHART.html) for interactive flow diagrams:

| Tab | Contents |
|-----|----------|
| **Runtime Flow** | End-to-end request lifecycle; mode switcher → API → backend |
| **Tensor Parallel** | RPC and native AllReduce flows; TNSR wire format; plan fields |
| **Pipeline Parallel** | Layer distribution; tensor wire format; KV cache decode loop |
| **Build Pipeline** | Engine selection; host × target matrix; crate graph |

---

## 2. Inference engines

Two engines are available. Choose one per build with a flag:

| Flag | Engine | Binary size | Speed | Cross-compile safe? |
|---|---|---|---|---|
| `--llama-cpp2` | Statically linked llama.cpp (C++) | Larger (~+20 MB) | Fastest | **macOS only** — cannot cross to Linux/Windows |
| `--candle-only` | Pure-Rust HuggingFace candle | Smaller | ~20-30% slower | **Yes — any host to any target** |

`--llama-cpp2` is the default. GPU acceleration is added automatically:
- macOS → Metal (`llama-metal` / `candle-metal`)
- Linux with `nvcc` on `$PATH` → CUDA (`llama-cuda` / `candle-cuda`)

When to use `--candle-only`:
- Cross-compiling Linux or Windows targets from a Mac
- CI environments without cmake / C++ toolchains
- Faster iteration builds (no C++ compilation step)

```bash
./build.sh macos-arm64                  # default: llama-cpp2 + Metal
./build.sh macos-arm64 --candle-only    # same target, candle engine
./build.sh linux-x86_64 --candle-only   # cross from macOS — only option
./build.sh all --candle-only            # every target from one machine
```

---

## 3. Target × host compatibility matrix

**Legend**
`llama` = `--llama-cpp2` (default) works
`candle` = `--candle-only` works
`✗` = not supported from this host

| Target | macOS ARM64 | macOS x86_64 | Linux x86_64 | Linux ARM64 | Windows |
|---|:---:|:---:|:---:|:---:|:---:|
| `macos-arm64` | **llama / candle** | llama / candle | candle | candle | candle |
| `macos-x86_64` | llama / candle | **llama / candle** | candle | candle | candle |
| `macos-universal` | llama / candle | llama / candle | candle | candle | ✗ |
| `linux-x86_64` | candle | candle | **llama / candle** | candle | candle |
| `linux-arm64` | candle | candle | llama / candle | **llama / candle** | candle |
| `windows-x86_64` | candle | candle | candle | candle | **llama / candle** |
| `android-arm64` | llama / candle | llama / candle | llama / candle | llama / candle | ✗ |
| `ios-arm64` | llama / candle | llama / candle | ✗ | ✗ | ✗ |
| `ios-sim` | llama / candle | llama / candle | ✗ | ✗ | ✗ |

**Bold** = native build (fastest, full engine support).
The `llama-cpp2` column is blocked for macOS→Linux/Windows due to cmake cross-compilation
limitations; the build script will error and tell you to use `--candle-only` or build natively.

---

## 4. Prerequisites by target

Install once per machine. Only the tools needed for the targets you intend to build are required.

### Rust toolchain (all targets)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
```

The build script adds the required `rustup target` automatically on first use.

### macOS targets (`macos-arm64`, `macos-x86_64`, `macos-universal`)

```bash
xcode-select --install          # Xcode CLI tools (clang, lipo)
```

No extra steps. Metal GPU support is included automatically.

### Linux targets (`linux-x86_64`, `linux-arm64`) — cross-compiling from macOS

```bash
brew install FiloSottile/musl-cross/musl-cross   # musl cross-compilers
```

Must use `--candle-only` when building from macOS (see §3).

### Linux targets — building natively on Linux

```bash
# musl libc dev headers for static linking
sudo apt install musl-tools          # Debian/Ubuntu
sudo dnf install musl-gcc            # Fedora
```

### Windows target (`windows-x86_64`) — cross-compiling from macOS/Linux

```bash
brew install mingw-w64              # macOS
sudo apt install gcc-mingw-w64      # Linux
```

Must use `--candle-only` when cross-compiling from macOS (see §3).

### Android target (`android-arm64`)

```bash
# Install NDK via Android Studio, or via sdkmanager:
sdkmanager "ndk;26.3.11579264"

# Set environment variable (add to ~/.zshrc or ~/.bashrc):
export ANDROID_NDK_HOME=~/Library/Android/sdk/ndk/26.3.11579264
```

The build script auto-locates the NDK under `~/Library/Android/sdk/ndk/` if `ANDROID_NDK_HOME` is not set.

### iOS targets (`ios-arm64`, `ios-sim`)

```bash
# Install Xcode from the App Store, then:
xcode-select --install
```

macOS host only. No Linux/Windows path exists for iOS cross-compilation.

### candle-only — additional tokenizer requirement (runtime, not build)

The candle backend requires a `tokenizer.json` file alongside each `.gguf` model at runtime:

```
~/models/
  mistral-7b-q4.gguf
  tokenizer.json          ← download from the same HuggingFace repo
```

The llama-cpp2 backend reads the tokenizer embedded in the GGUF file and has no such requirement.

---

## 5. Building every target — platform by platform

### Building from macOS (Apple Silicon — recommended release machine)

```bash
# Native — best performance
./build.sh macos-arm64                  # → dist/macos-arm64/linus_ai

# Intel Mac support
./build.sh macos-x86_64                 # → dist/macos-x86_64/linus_ai

# Fat binary (ships to all Macs)
./build.sh macos-universal              # → dist/macos-universal/linus_ai

# Linux and Windows — must use candle (llama-cpp2 cross-compilation not supported)
./build.sh linux-x86_64 --candle-only   # → dist/linux-x86_64-candle/linus_ai
./build.sh linux-arm64  --candle-only   # → dist/linux-arm64-candle/linus_ai
./build.sh windows-x86_64 --candle-only # → dist/windows-x86_64-candle/linus_ai.exe

# Mobile
./build.sh android-arm64               # → dist/android-arm64/linus_ai
./build.sh ios-arm64                   # → dist/ios-arm64/linus_ai
./build.sh ios-sim                     # → dist/ios-sim/linus_ai

# iOS note
# The repo defaults IPHONEOS_DEPLOYMENT_TARGET=16.0 for iOS builds.
# If you build the iOS target manually, keep the same minimum:
# export IPHONEOS_DEPLOYMENT_TARGET=16.0
# cargo build --release --target aarch64-apple-ios
# This avoids the arm64 linker failure: ___chkstk_darwin

# Everything at once (uses candle for Linux/Windows, llama-cpp2 for Apple targets)
./build.sh all --candle-only
```

### Building from Linux x86_64

```bash
# Native — full engine support
./build.sh linux-x86_64                 # → dist/linux-x86_64/linus_ai
./build.sh linux-arm64 --candle-only    # cross ARM64 (candle only)

# macOS, Windows (candle cross-compile — no Xcode dependency)
./build.sh macos-arm64  --candle-only
./build.sh macos-x86_64 --candle-only
./build.sh windows-x86_64 --candle-only

# Android (NDK required)
./build.sh android-arm64

# iOS — not supported from Linux
```

### Building from Windows

```bash
# Native
./build.sh native                       # → dist/windows-x86_64/linus_ai.exe

# Cross to other targets with candle
./build.sh linux-x86_64 --candle-only
./build.sh macos-arm64  --candle-only

# iOS/Android — not supported from Windows
```

---

## 6. Output locations

| Engine | Directory pattern | Example |
|---|---|---|
| `--llama-cpp2` (default) | `dist/<target>/` | `dist/macos-arm64/linus_ai` |
| `--candle-only` | `dist/<target>-candle/` | `dist/linux-x86_64-candle/linus_ai` |

Windows binaries have a `.exe` suffix: `dist/windows-x86_64/linus_ai.exe`.

```bash
./build.sh list    # prints a table of all targets with sizes and engine columns
```

---

## 7. Clean

```bash
./build.sh clean                  # remove all dist/ directories and cargo target caches
./build.sh clean macos-arm64      # remove only dist/macos-arm64/ (both engine variants)
./build.sh clean linux-x86_64     # removes dist/linux-x86_64/ and dist/linux-x86_64-candle/
```

---

## 8. Workspace structure

```
linus-ai-rs/
  Cargo.toml                        ← workspace root (lto = "thin")
  linus-ai-bin/
    src/main.rs                     ← binary entry point
  crates/
    linus-ai-core/                  ← EventBus, Config, crypto (ChaCha20, PBKDF2)
    linus-ai-net/                   ← MeshNetwork (mDNS + TCP + Tailscale)
    linus-ai-inference/             ← ModelManager + InferenceEngine
      src/
        engine.rs                   ← dispatch: bundled / candle / subprocess
        bundled.rs                  ← llama-cpp2 backend  [feature: llama-bundled]
        candle_backend.rs           ← candle backend      [feature: candle-only]
        backend.rs                  ← subprocess fallback [no-features build]
        model.rs                    ← GGUF model manager
    linus-ai-http/                  ← axum HTTP API + SSE streaming
    linus-ai-vault/                 ← Encrypted SQLite (ChaCha20-HMAC)
    linus-ai-guardian/              ← 2FA, TOTP, auth, sessions
    linus-ai-thermal/               ← 5-stage thermal governor
    linus-ai-task/                  ← Distributed job scheduler
    linus-ai-blockchain/            ← SHA-256 hash-chain ledger
    linus-ai-launcher/              ← System-tray app (macOS/Windows)
```

### Cargo feature flags (set automatically by build.sh)

| Feature | What it does |
|---|---|
| `llama-bundled` | Statically links llama.cpp — **default** |
| `llama-metal` | Adds Metal GPU to llama-cpp2 — auto-added on macOS |
| `llama-cuda` | Adds CUDA GPU to llama-cpp2 — auto-added when `nvcc` found |
| `candle-only` | Pure-Rust candle engine, disables llama-cpp2 |
| `candle-metal` | Adds Metal GPU to candle — auto-added on macOS |
| `candle-cuda` | Adds CUDA GPU to candle — auto-added when `nvcc` found |
| *(none)* | Subprocess fallback (external llama-server / ollama) |

---

## 9. CI/CD reference

### Active workflow — `release.yml`

Triggers on `v*.*.*` tags. Desktop targets only:

| Runner | Target | Bundle |
|---|---|---|
| `macos-14` | `macos-arm64` | `.app` |
| `macos-14` | `macos-x86_64` | `.app` |
| `macos-14` (lipo) | `macos-universal` | `.dmg` |
| `ubuntu-22.04` | `linux-x86_64` | GUI + headless |
| `ubuntu-22.04` | `linux-arm64` | headless only |
| `windows-2022` | `windows-x86_64` | GUI + MSIX |

### Staged workflow — `release-tauri.yml`

Manual trigger only (`workflow_dispatch`). Will replace packaging steps in `release.yml` once validated. Builds via `cargo tauri build` for DMG, NSIS, AppImage, and DEB. See §11 for local Tauri build instructions.

> iOS and Android targets were removed in the 2.2.2 release cycle. The `linus-ai-gui` crate still compiles as a library with `--no-default-features` if mobile support is re-added later.

---

## 10. Runtime requirements (end users)

### macOS / Windows

No extra libraries needed. The binary is self-contained.

### Linux — GUI binary (`linus-ai-linux-x86_64`)

The GUI binary links dynamically against several system libraries. Install them before running:

```bash
# Ubuntu 22.04 / Debian 12+
sudo apt-get install -y \
  libwebkit2gtk-4.1-0 \
  libgtk-3-0 \
  libayatana-appindicator3-1 \
  librsvg2-2 \
  libxdo3

# Fedora / RHEL 9+
sudo dnf install -y webkit2gtk4.1 gtk3 libayatana-appindicator xdotool

# Arch Linux
sudo pacman -S webkit2gtk-4.1 gtk3 libayatana-appindicator xdotool
```

> **Quick fix for the `libxdo.so.3: cannot open shared object file` error:**
> ```bash
> sudo apt-get install libxdo3       # Debian/Ubuntu
> sudo dnf install xdotool           # Fedora/RHEL
> sudo pacman -S xdotool             # Arch
> ```

### Linux — headless binary (`linus-ai-headless-linux-x86_64`)

The headless (no GUI) binary has no extra system library requirements beyond glibc 2.31+ (Ubuntu 20.04+).

### Summary table

| | macOS | Linux GUI | Linux headless | Windows |
|---|---|---|---|---|
| Python | none | none | none | none |
| System libraries | libSystem (built-in) | see apt/dnf list above | glibc 2.31+ | MSVCRT (built-in) |
| GPU (optional) | Metal — macOS 13+ | CUDA 12 drivers | CUDA 12 drivers | CUDA 12 drivers |
| Models | `~/models/*.gguf` | `~/models/*.gguf` | `~/models/*.gguf` | `%USERPROFILE%\models\*.gguf` |
| tokenizer.json | candle builds only | candle builds only | candle builds only | candle builds only |

The llama-cpp2 binary is self-contained and reads the tokenizer from the GGUF file.
The candle binary additionally requires a `tokenizer.json` next to the model file.

---

## 11. Tauri 2.0 packaging (hybrid)

LINUS-AI uses a **hybrid GUI architecture**:

| Crate | Runtime | How to build | Use case |
|---|---|---|---|
| `linus-ai-gui` | tao + wry (direct) | `cargo build --release --bin linus-ai` | Development, quick iteration |
| `linus-ai-gui-tauri` | Tauri 2.0 wrapping tao/wry | `cargo tauri build` | Release packaging (DMG, NSIS, AppImage) |

Both crates start the same axum HTTP engine on port 9480 and load `http://127.0.0.1:9480/app` in a webview. No Tauri IPC is used.

### Prerequisites

```bash
# Install Tauri CLI (once)
cargo install tauri-cli --version "^2" --locked

# Generate placeholder icons (once, or after `--force` to regenerate)
python3 linus-ai-rs/crates/linus-ai-gui-tauri/icons/generate.py

# Replace placeholders with real icons (optional but recommended for releases)
npx tauri icon source-1024.png --output linus-ai-rs/crates/linus-ai-gui-tauri/icons/
```

### Local build

```bash
cd linus-ai-rs

# macOS
cargo tauri build --config crates/linus-ai-gui-tauri/tauri.conf.json --bundles app,dmg

# Linux
cargo tauri build --config crates/linus-ai-gui-tauri/tauri.conf.json --bundles deb,appimage

# Windows (PowerShell)
cargo tauri build --config crates/linus-ai-gui-tauri/tauri.conf.json --bundles nsis,msi
```

Output is written to `target/<target>/release/bundle/`.

### Activating the Tauri CI workflow

The `release-tauri.yml` workflow is staged (`workflow_dispatch` only). To activate for tag-based releases:

1. Validate with a manual run via GitHub UI → Actions → "Release (Tauri)" → Run workflow.
2. Add the required secrets (Apple cert, Windows cert, `TAURI_SIGNING_PRIVATE_KEY`) — see comments at the top of the workflow file.
3. Add a `push: tags: ['v[0-9]+.[0-9]+.[0-9]+']` trigger and remove the staged-only comment.
