# LINUS-AI v4.0.0

**Private distributed AI — runs entirely on your hardware. No cloud. No subscriptions required.**

[![License](https://img.shields.io/badge/license-LINUS%20Source%20v2.0-blue)](LICENSE.md)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey)]()
[![Version](https://img.shields.io/badge/version-4.0.0-green)]()

> Part of the **[LINUS-AI Product Suite](https://github.com/miryala3/linus-ai-public#readme)**  
> All downloads and purchase links: [github.com/miryala3/linus-ai-public](https://github.com/miryala3/linus-ai-public#readme)

---

## What is LINUS-AI?

LINUS-AI is a single-binary AI platform that runs large language models entirely on your hardware. It ships a full web-based control panel, a headless API server, mesh networking for multi-node inference, agentic tool-use via MCP, blockchain audit logging, and role-based profiles — all compiled into one Rust binary with zero Python, pip, or cloud dependencies.

---

## Download

All binaries are on [GitHub Releases](https://github.com/miryala3/linus-ai-public/releases/tag/v4.0.0).  
Verify with `SHA256SUMS.txt` included in every release.

| Platform | Binary | Size (approx) |
|---|---|---|
| macOS arm64 (Apple Silicon) | `linus-ai-4.0.0-macos-arm64` | ~39 MB |
| macOS x86_64 (Intel) | `linus-ai-4.0.0-macos-x86_64` | ~47 MB |
| macOS Universal | `linus-ai-4.0.0-macos-universal` | ~86 MB |
| Linux x86_64 | `linus-ai-4.0.0-linux-x86_64` | ~48 MB |
| Linux arm64 | `linus-ai-4.0.0-linux-arm64` | ~37 MB |
| Windows x86_64 | `linus-ai-4.0.0-windows-x86_64.exe` | ~46 MB |

> Binaries are large because they bundle the full `mistralrs` inference engine with Metal/CUDA/CPU backends — no external runtime needed.

---

## Quick Start

### macOS

```bash
curl -LO https://github.com/miryala3/linus-ai-public/releases/download/v4.0.0/linus-ai-4.0.0-macos-arm64
chmod +x linus-ai-4.0.0-macos-arm64
xattr -d com.apple.quarantine linus-ai-4.0.0-macos-arm64
codesign --force --deep --sign - linus-ai-4.0.0-macos-arm64
./linus-ai-4.0.0-macos-arm64
```

> If macOS still blocks the binary: **System Settings → Privacy & Security → Open Anyway**

### Linux

```bash
# Install runtime dependencies (GUI mode)
sudo apt-get install -y libwebkit2gtk-4.1-0 libgtk-3-0 \
  libayatana-appindicator3-1 librsvg2-2 libxdo3

curl -LO https://github.com/miryala3/linus-ai-public/releases/download/v4.0.0/linus-ai-4.0.0-linux-x86_64
chmod +x linus-ai-4.0.0-linux-x86_64
./linus-ai-4.0.0-linux-x86_64
```

### Windows

Download `linus-ai-4.0.0-windows-x86_64.exe` from Releases, then run it.  
Click "More info → Run anyway" if Windows SmartScreen appears (binary is unsigned in v4.0.0).

### First launch

- Control panel opens at **http://127.0.0.1:9480/app**
- Download a model: **Models → Browse → Download**
- Community tier is free and starts immediately — no key needed

---

## Command-Line Reference

```
linus_ai [OPTIONS] [SUBCOMMAND]
```

Running without a subcommand starts the full server.

### Server flags

| Flag | Default | Description |
|---|---|---|
| `--mode` | `full` | `full` (all subsystems) · `mesh` (network + inference only) · `edge` (routes to peers, minimal local model) |
| `--port` | `9480` | HTTP API and control panel port |
| `--host` | `0.0.0.0` | Bind address. Use `127.0.0.1` for localhost-only |
| `--model-dir` | `~/.linus_ai/models` | Directory to scan for GGUF files |
| `--data-dir` | `~/.linus_ai` | Config, logs, license cache |
| `--log-level` | `info` | `trace` · `debug` · `info` · `warn` · `error` |
| `--log-file` | — | Path to write log file |
| `--log-max-mb` | `50` | Rotate log file when it exceeds this size |
| `--ctx-size` | `4096` | KV-cache context window in tokens |
| `--mesh-secret` | (default) | Shared secret for mesh peer authentication |
| `--node-name` | hostname | Name shown to mesh peers |
| `--scope` | `private` | `private` (LAN only) · `public` (allow remote) |
| `--tailscale` | false | Join Tailscale mesh overlay |
| `--enable-shell` | false | Enable `/shell/exec` endpoints (trusted environments only) |
| `--doc-server` | — | Pre-load RAG documents from `<url>/api/documents` at startup |
| `--ldap-url` | — | LDAP server URL (e.g. `ldap://dc.corp.example.com:389`) |
| `--ldap-bind-dn` | — | LDAP service account DN |
| `--ldap-bind-password` | — | LDAP service account password (prefer env var) |
| `--ldap-base-dn` | — | LDAP search base DN |
| `--ldap-only` | false | Reject local logins, accept LDAP only |

### Subcommands

| Subcommand | Description |
|---|---|
| `linus_ai info` | Print hardware info (CPU, RAM, GPU, detected model cap) and exit |
| `linus_ai models` | List models found in model directories and exit |
| `linus_ai compile <file.py>` | Compile a Python script to a native binary via py2c |
| `linus_ai run <file.py>` | Run a Python script via py2c interpreter |
| `linus_ai emit <file.py>` | Emit C source from a Python script |
| `linus_ai targets` | List available cross-compilation targets |

### Examples

```bash
# Start server, listen on localhost only, use custom model dir
./linus_ai --host 127.0.0.1 --model-dir ~/models

# Mesh worker mode (no GUI window, joins LAN mesh)
./linus_ai --mode mesh --mesh-secret "my-team-secret"

# Edge node — tiny model locally, routes large requests to mesh peers
./linus_ai --mode edge --mesh-secret "my-team-secret"

# Production server with LDAP, log to file
./linus_ai \
  --host 0.0.0.0 --port 9480 \
  --ldap-url ldap://dc.corp.example.com:389 \
  --ldap-bind-dn "CN=svc,DC=corp,DC=example,DC=com" \
  --ldap-bind-password "$LDAP_PASS" \
  --log-file /var/log/linus_ai.log --log-max-mb 100

# Print hardware profile and exit
./linus_ai info

# List models found in ~/models
./linus_ai --model-dir ~/models models
```

---

## Activate a Licence

**GUI:** Control panel → Settings → Licence → paste key → Activate

**API:**
```bash
curl -X POST http://127.0.0.1:9480/activate \
  -H 'Content-Type: application/json' \
  -d '{"key": "LNAI-PRO-XXXX-XXXX-XXXX"}'
```

Activation requires one internet connection to `license.linus-ai.com` to verify the key and issue a signed token. After that, the binary validates fully offline via Ed25519 signature — no phone-home, no heartbeat.

To move to a new machine: **Settings → Licence → Deactivate** first, then activate on the new machine.

---

## Pricing

| Tier | Price | Model Cap | Profiles |
|---|---|---|---|
| **Community** | Free forever | 5B params | 6 |
| **Trial** | Free (30 days) | 70B params | 14 |
| **Professional** | $499 one-time | 70B params | 14 |
| **Team** | $1,499 one-time (5 seats) | 70B params | 14 |
| **Enterprise** | $7,999/yr (unlimited seats) | Unlimited | Unlimited |
| **Medical Solo** | $1,499 one-time | 70B params | 14 |
| **Medical Enterprise** | $12,000–$20,000/yr | Unlimited | Unlimited |

Hardware caps apply within each tier: 8 GB RAM → ~8B Q4 effective, 16 GB → ~14B, 32 GB → ~34B, 64 GB+ → up to your tier ceiling.

**Buy now via PayPal (one-time, no account required):**

| Tier | Link |
|---|---|
| Professional — $499 | [Pay $499](https://www.paypal.com/ncp/payment/LNAI-PRO) |
| Team — $1,499 | [Pay $1,499](https://www.paypal.com/ncp/payment/LNAI-TEAM) |
| Enterprise — $7,999/yr | [Pay $7,999](https://www.paypal.com/ncp/payment/LNAI-ENT) |

After payment, email **support@linus-ai.com** with your order confirmation — your license key will be delivered within 1 business day.

---

## Features by Tier

### Community (Free)
- Local LLM inference — models up to 5B parameters
- Web control panel at http://127.0.0.1:9480/app
- Chat, model manager, settings
- Up to 6 role profiles
- 30-day trial automatically activates full Professional features on first launch

### Professional ($499 one-time)
Everything in Community, plus:
- Models up to 70B parameters (hardware-permitting)
- 14 role profiles with custom system prompts
- **Mesh networking** — mDNS peer discovery, thermal-aware load balancing across LAN nodes
- **Tensor parallelism** — split a single model across multiple machines (RPC + AllReduce modes)
- **Pipeline parallelism** — distribute model layers sequentially across nodes
- **Agentic workflows** — multi-step ReAct loop with MCP server integration and tool use
- **Full OpenAI-compatible API** — `/v1/chat/completions`, `/v1/completions`, `/v1/models`, `/v1/embeddings`, `/v1/tokenize`
- **Compliance engine** — 14 industry profiles (HIPAA, legal, finance, security, HR and more); PII scanner (12 types); injection detection (8 rule families); HMAC-chained audit logs
- **RAG document access control** — 5-level document classification (PUBLIC → TOP_SECRET); ACL at user/role/department/division/company scope
- **py2c compiler** — compile Python 3.10+ scripts to native binaries across 11 targets (macOS, Linux, Windows, Android, iOS, WASM)
- License transfer between machines

### Team ($1,499 one-time — 5 seats)
Everything in Professional, plus:
- **Blockchain audit ledger** — tamper-evident, Ed25519-signed per-request audit trail with Merkle proofs
- **Federated learning** — distributed gradient coordination across mesh nodes
- 5-seat licence (all seats share one key)

### Enterprise ($7,999/yr — unlimited seats)
Everything in Team, plus:
- Unlimited model sizes (hardware-limited only)
- Unlimited role profiles
- **LDAP / Active Directory** — group-to-role mapping, LDAP-only auth enforcement, per-node LDAP config
- Unlimited seats
- Priority email support + SLA

> **Coming in v3.1–v3.3:** Vault encrypted secret store, fine-tuning (LoRA), air-gap deployment.  
> Enterprise licence holders get these automatically when released.

### Medical Solo ($1,499 one-time)
- Local HIPAA-scoped inference — all data stays on-device
- Models up to 70B parameters
- Clinical role registry (14 profiles)
- HIPAA audit trail — append-only JSONL, OS-sealed monthly files
- Compliance PDF export
- PII scanner with medical record type detection
- Single-facility deployment

### Medical Enterprise ($12,000–$20,000/yr)
Everything in Medical Solo, plus:
- Multi-site deployment
- LDAP / SSO
- Blockchain audit ledger
- Unlimited models and profiles
- Priority support + HIPAA BAA available

---

## Technical Details

### Inference Engine

Default build uses `mistralrs` (bundled, pure Rust):
- **Metal** acceleration on macOS (Apple Silicon + Intel)
- **CUDA** on Linux/Windows with NVIDIA GPU
- **CPU fallback** on all platforms
- Supports GGUF model format

External backends (auto-detected if running):
- `ollama` on port 11434
- `llama-server` on default port

### Mesh Networking

Nodes on the same LAN auto-discover each other via mDNS. Hub node distributes inference across workers based on composite score (RAM, load, thermal state). Thermal governor automatically reroutes requests to cooler nodes when temperature thresholds are hit.

### API (Professional+)

```
POST /v1/chat/completions     — OpenAI-compatible chat
POST /v1/completions          — text completion
GET  /v1/models               — list models
POST /v1/embeddings           — text embeddings
POST /v1/tokenize             — tokenize text
POST /infer                   — native inference (JSON)
POST /infer/stream            — streaming inference (SSE)
POST /agent/stream            — agentic reasoning loop (SSE)
GET  /models                  — list/search local models
POST /models/select           — switch active model
POST /models/pull             — download model by name
GET  /mesh/peers              — list discovered mesh peers
POST /mesh/assign-roles       — assign hub/worker roles
POST /tensor/plan             — configure tensor parallelism
GET  /status                  — server status, license, hardware
POST /activate                — activate licence key
POST /deactivate              — free machine seat
```

### Ports

| Port | Purpose |
|---|---|
| 9480 | Control panel + HTTP API |
| 9481 | REST API (alternative, same server) |
| 9482 | Mesh peer communication |

All bind to `0.0.0.0` by default. Set `--host 127.0.0.1` for localhost-only.

---

## Platform Support

| Platform | GUI | Server | Mesh |
|---|---|---|---|
| macOS arm64 (Apple Silicon) | ✓ | ✓ | ✓ |
| macOS x86_64 (Intel) | ✓ | ✓ | ✓ |
| Linux x86_64 | ✓ (WebKit2GTK) | ✓ | ✓ |
| Linux arm64 | — | ✓ | ✓ |
| Windows x86_64 | ✓ | ✓ | ✓ |

---

## Build from Source

All Rust source is under `linus-ai-rs/`. Run `cargo` commands from there.

```bash
cd linus-ai-rs

# Headless server binary (fastest build)
cargo build --release --bin linus_ai

# With bundled mistralrs inference engine (required for standalone use)
cargo build --release --features mistralrs-bundled --bin linus_ai

# GUI binary (macOS/Windows/Linux with WebKit2GTK)
cargo build --release --package linus-ai-gui

# Build all targets via build script
cd ..
./build.sh macos-arm64
./build.sh linux-x86_64
./build.sh windows-x86_64
./build.sh list     # show build status
```

See [BUILD.md](BUILD.md) for full cross-compilation matrix and CI reference.

---

## License

[LINUS Source License v2.0](LICENSE.md). Community use is free. Professional and above require a purchased key.  
Third-party licenses: [THIRD-PARTY-LICENSES.md](THIRD-PARTY-LICENSES.md).
