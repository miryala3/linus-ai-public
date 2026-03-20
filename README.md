# LINUS-AI

**Private AI mesh. Runs on your hardware. No cloud. No data leaves your machine.**

Download a pre-built binary below, drop in a GGUF model, and you're running in under a minute.

---

## Download

| Platform | File | Notes |
|---|---|---|
| macOS (Universal) | `linus-ai-macos-universal` | arm64 + x86_64, macOS 12+ |
| macOS (Apple Silicon) | `linus-ai-macos-arm64` | M1/M2/M3/M4, Metal GPU |
| macOS (Intel) | `linus-ai-macos-x86_64` | Intel Mac |
| macOS DMG | `linus-ai-macos.dmg` | Drag-and-drop installer |
| Linux x86_64 | `linus-ai-linux-x86_64` | Ubuntu 20.04+, Debian, etc. |
| Linux x86_64 headless | `linus-ai-headless-linux-x86_64` | Server / CLI, no GUI |
| Linux arm64 headless | `linus-ai-headless-linux-arm64` | Raspberry Pi 4+, ARM servers |
| Windows x86_64 | `linus-ai-windows-x86_64.exe` | Windows 10+ |
| Windows MSIX | `linus-ai-windows-x86_64.msix` | Microsoft Store sideload |
| iOS XCFramework | `LinusAIEngine.xcframework.zip` | Embed in your Xcode project |

Find all files on the [Releases page](../../releases/latest).

SHA-256 checksums are provided in `SHA256SUMS.txt` alongside every release.

---

## Quickstart

### macOS

```bash
# Download
curl -L https://github.com/LINUS-AI-PRO/linus-ai-public/releases/latest/download/linus-ai-macos-universal \
     -o linus-ai

chmod +x linus-ai

# Add a model — any .gguf file
mkdir -p ~/models
# e.g. llama.cpp model from Hugging Face

# Run
LINUS_AI_MODEL_DIR=~/models ./linus-ai
# Opens http://localhost:9480/app in your browser
```

### Linux

```bash
curl -L https://github.com/LINUS-AI-PRO/linus-ai-public/releases/latest/download/linus-ai-linux-x86_64 \
     -o linus-ai
chmod +x linus-ai
LINUS_AI_MODEL_DIR=~/models ./linus-ai
```

### Windows

Download `linus-ai-windows-x86_64.exe`, then in PowerShell:

```powershell
$env:LINUS_AI_MODEL_DIR = "$env:USERPROFILE\models"
.\linus-ai-windows-x86_64.exe
```

---

## Models

LINUS-AI loads any GGUF model from a directory. Recommended starting points:

| Model | VRAM | Quality |
|---|---|---|
| Llama-3.1-8B-Instruct-Q4_K_M | ~5 GB | Fast, good for most tasks |
| Llama-3.1-70B-Instruct-Q4_K_M | ~40 GB | High quality |
| Phi-3-mini-4k-instruct-Q4 | ~2 GB | Lightweight |
| Mistral-7B-Instruct-v0.3-Q4_K_M | ~4.5 GB | Balanced |

Download models from [Hugging Face](https://huggingface.co/models?library=gguf) (search for GGUF format).

---

## Configuration

All settings are optional — LINUS-AI auto-detects your hardware and models.

```bash
# Key environment variables
LINUS_AI_MODEL_DIR=/path/to/models   # where to look for .gguf files
LINUS_AI_API_PORT=9480               # HTTP port (default 9480)
LINUS_AI_MODE=full                   # full | mesh | edge
LINUS_AI_LOG_LEVEL=info              # trace | debug | info | warn | error
```

A config file (`~/.linus_ai/config.toml`) is created on first run.

---

## Mesh Mode

Multiple LINUS-AI nodes can form a private mesh — sharing inference load across machines on your network:

```bash
# Node 1 (primary)
LINUS_AI_MODE=mesh ./linus-ai

# Node 2 (same network)
LINUS_AI_MODE=mesh LINUS_AI_API_PORT=9481 ./linus-ai
```

Nodes discover each other automatically via mDNS. No external coordination server required.

---

## System Requirements

| | Minimum | Recommended |
|---|---|---|
| RAM | 8 GB | 16 GB+ |
| Storage | 5 GB | 50 GB+ (for models) |
| GPU | — | Apple Metal / NVIDIA CUDA |
| macOS | 12.0 | 13.0+ |
| Linux | Ubuntu 20.04 | Ubuntu 22.04+ |
| Windows | 10 (x64) | 11 |

---

## Support

- Issues: [github.com/LINUS-AI-PRO/linus-ai-public/issues](../../issues)
- Website: [linus-ai.com](https://linus-ai.com)

---

## License

Commercial use requires a license. Personal and academic use is free.
See [linus-ai.com](https://linus-ai.com) for pricing and license terms.

© 2025 LINUS-AI
