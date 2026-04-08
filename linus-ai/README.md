# LINUS-AI v4.0.0

**Your own private AI — runs on your computer, not in someone else's cloud.**

[![License](https://img.shields.io/badge/license-LINUS%20Source%20v2.0-blue)](LICENSE.md)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey)]()
[![Version](https://img.shields.io/badge/version-4.0.0-green)]()

> Part of the **[LINUS-AI Product Suite](https://github.com/miryala3/linus-ai-public#readme)**  
> Downloads and pricing: [github.com/miryala3/linus-ai-public](https://github.com/miryala3/linus-ai-public#readme)

---

## What does it do?

LINUS-AI runs AI models directly on your Mac, Linux machine, or Windows PC. You get a full chat interface, an AI assistant you can talk to, and powerful tools for developers and businesses — with no monthly fees, no data sent to cloud servers, and no internet required after the initial download.

It's one file you download and run. Nothing to install, no Python, no accounts required to start.

> **aiMED Extension license holders receive LINUS-AI Professional free.**  
> Email support@linus-ai.com with your aiMED order confirmation to claim your LNAI-PRO key.

---

## Download

Go to **[Releases — v4.0.0](https://github.com/miryala3/linus-ai-public/releases/tag/v4.0.0)** and pick your platform.

| Platform | File |
|---|---|
| Mac (Apple Silicon — M1/M2/M3/M4) | [`linus-ai-4.0.0-headless-macos-arm64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.0/linus-ai-4.0.0-headless-macos-arm64) |
| Mac (Intel) | [`linus-ai-4.0.0-headless-macos-x86_64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.0/linus-ai-4.0.0-headless-macos-x86_64) |
| Linux 64-bit | [`linus-ai-4.0.0-headless-linux-x86_64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.0/linus-ai-4.0.0-headless-linux-x86_64) |
| Linux ARM (Raspberry Pi / server) | [`linus-ai-4.0.0-headless-linux-arm64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.0/linus-ai-4.0.0-headless-linux-arm64) |
| Windows 64-bit | [`linus-ai-4.0.0-headless-windows-x86_64.exe`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.0/linus-ai-4.0.0-headless-windows-x86_64.exe) |
| Checksums | [`SHA256SUMS.txt`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.0/SHA256SUMS.txt) |

---

## Getting started

### Mac

```bash
chmod +x linus-ai-4.0.0-headless-macos-arm64
xattr -d com.apple.quarantine linus-ai-4.0.0-headless-macos-arm64
./linus-ai-4.0.0-headless-macos-arm64
```

If macOS still blocks it: **System Settings → Privacy & Security → Open Anyway**

### Linux

```bash
chmod +x linus-ai-4.0.0-headless-linux-x86_64
./linus-ai-4.0.0-headless-linux-x86_64
```

### Windows

Download and run the `.exe`. Click "More info → Run anyway" if a SmartScreen warning appears.

### First use

1. Open your browser to **http://127.0.0.1:9480/app**
2. Go to **Models → Browse → Download** to get your first AI model
3. Start chatting — no key needed to begin (30-day free trial starts automatically)

---

## Pricing

| Plan | Price | What you get |
|---|---|---|
| **Community** | Free forever | Chat with models up to 5B size, 6 saved personas |
| **Trial** | Free for 30 days | Everything in Professional, automatically |
| **Professional** | $499 one-time | Full features, models up to 70B, 14 personas, mesh networking, API access |
| **Team** | $1,499 one-time (5 people) | Everything in Professional + shared audit trail, federated learning |
| **Enterprise** | $7,999/year (unlimited people) | Everything + unlimited models, Active Directory login, air-gap deployment |

**Pay now (one-time, no account needed):**

| Plan | Link |
|---|---|
| Professional — $499 | [Pay $499](https://www.paypal.com/ncp/payment/NMFSELLNG7X7U) |
| Team — $1,499 | [Pay $1,499](https://www.paypal.com/ncp/payment/RRHAWGNKDQL5A) |
| Enterprise — $7,999/yr | [Pay $7,999](https://www.paypal.com/ncp/payment/Z5J9RLR3YT6RA) |

Pay via PayPal → email **support@linus-ai.com** with your receipt → receive your license key within 1 business day.

> **aiMED Extension subscribers** get LINUS-AI Professional included — email us with your aiMED order to claim it.

---

## What's in each plan

### For everyday users

| What you can do | Community | Professional | Team | Enterprise |
|---|---|---|---|---|
| Chat with AI on your own computer | ✓ | ✓ | ✓ | ✓ |
| Web interface at http://127.0.0.1:9480/app | ✓ | ✓ | ✓ | ✓ |
| Download and switch AI models | ✓ | ✓ | ✓ | ✓ |
| Saved personas / roles | 6 | 14 | 14 | Unlimited |
| Use larger, more capable models (70B+) | — | ✓ | ✓ | ✓ |
| Unlimited model size (hardware-permitting) | — | — | — | ✓ |
| Custom instructions per persona | — | ✓ | ✓ | ✓ |
| Chat history saved across sessions | — | ✓ | ✓ | ✓ |
| Upload documents to ask questions about (PDF, Word, Excel, CSV) | — | ✓ | ✓ | ✓ |
| Export conversations | — | ✓ | ✓ | ✓ |
| Encrypted vault for storing secrets | — | ✓ | ✓ | ✓ |
| Move license to a new computer | — | ✓ | ✓ | ✓ |

### For developers

| What you can do | Community | Professional | Team | Enterprise |
|---|---|---|---|---|
| OpenAI-compatible API (drop-in replacement for apps using ChatGPT) | — | ✓ | ✓ | ✓ |
| Streaming AI responses via API | ✓ | ✓ | ✓ | ✓ |
| AI agent that reasons through multi-step tasks automatically | — | ✓ | ✓ | ✓ |
| Connect AI tools via MCP (Model Context Protocol) | — | ✓ | ✓ | ✓ |
| Build and run automated AI workflows (with webhook triggers) | — | ✓ | ✓ | ✓ |
| Split one large model across multiple computers (tensor parallelism) | — | ✓ | ✓ | ✓ |
| Chain model layers across computers for bigger models (pipeline parallelism) | — | ✓ | ✓ | ✓ |
| Auto-discover and connect AI nodes on your local network (mesh) | — | ✓ | ✓ | ✓ |
| Schedule and distribute AI jobs across nodes | — | ✓ | ✓ | ✓ |
| Distributed model training across mesh nodes | — | — | ✓ | ✓ |
| Metrics and diagnostics endpoints | — | ✓ | ✓ | ✓ |
| Remote shell access via API (opt-in) | — | ✓ | ✓ | ✓ |
| Pull models directly from HuggingFace | — | ✓ | ✓ | ✓ |
| Compile Python scripts to native executables (11 platforms) | — | ✓ | ✓ | ✓ |

### For IT admins

| What you can do | Community | Professional | Team | Enterprise |
|---|---|---|---|---|
| User accounts with login and roles | — | ✓ | ✓ | ✓ |
| Compliance profiles (HIPAA, legal, finance, HR, security, and more) | — | ✓ | ✓ | ✓ |
| Automatic detection and filtering of personal information in prompts | — | ✓ | ✓ | ✓ |
| Tamper-evident audit logs of every AI request | — | ✓ | ✓ | ✓ |
| Document access control (classify docs and restrict by user/role/department) | — | ✓ | ✓ | ✓ |
| Cryptographically signed blockchain audit ledger (tamper-proof trail with Merkle proofs) | — | — | ✓ | ✓ |
| Automatic heat management — reroutes AI work to cooler machines automatically | — | ✓ | ✓ | ✓ |
| Active Directory / LDAP login integration | — | — | — | ✓ |
| Force AD-only login (disable local accounts) | — | — | — | ✓ |
| Air-gap / offline-only deployment | — | — | — | ✓ |
| Remote binary self-update | — | ✓ | ✓ | ✓ |
| Network topology dashboard | — | ✓ | ✓ | ✓ |
| Export full configuration (TOML) | — | ✓ | ✓ | ✓ |

---

## Activate your license

**In the app:** Control panel → Settings → Licence → paste your key → Activate

**Via command line:**
```bash
curl -X POST http://127.0.0.1:9480/license/activate \
  -H 'Content-Type: application/json' \
  -d '{"key": "LNAI-PRO-XXXX-XXXX-XXXX"}'
```

License validation happens entirely on your machine — no internet connection required after activation.

To move to a new computer: Settings → Licence → Deactivate first, then activate on the new machine.

---

## Server startup options

| Option | Default | Description |
|---|---|---|
| `--mode` | `full` | How the server runs: `full` (everything), `mesh` (network + AI only), `edge` (routes requests to other nodes), `standalone` (single machine, no networking) |
| `--port` | `9480` | Which port the web interface and API listen on |
| `--host` | `0.0.0.0` | Which network to listen on. Use `127.0.0.1` for this machine only |
| `--model-dir` | `~/.linus_ai/models` | Where your AI model files are stored |
| `--data-dir` | `~/.linus_ai` | Where settings, logs, and license data live |
| `--log-level` | `info` | How much logging detail: `trace` / `debug` / `info` / `warn` / `error` |
| `--ctx-size` | `4096` | Conversation memory window (tokens) |
| `--mesh-secret` | (default) | Password for connecting machines in a mesh network |
| `--scope` | `private` | Who can connect: `private` (local network only) / `open` (allow remote) |
| `--enable-shell` | false | Allow remote shell commands via API (only for trusted environments) |
| `--ldap-url` | — | Your Active Directory or LDAP server address |
| `--ldap-only` | false | Require AD login, disable local accounts |

### Subcommands

```bash
linus_ai info              # show your hardware specs and what model size you can run
linus_ai models            # list AI models on disk
linus_ai compile file.py   # compile a Python script into a standalone native app
linus_ai run file.py       # run a Python script through the built-in interpreter
linus_ai targets           # list platforms you can compile Python apps for
```

---

## Works with

- **Ollama** (auto-detected on port 11434)
- **llama-server** (llama.cpp, auto-detected)
- Any app that uses the **OpenAI API** — point it at `http://127.0.0.1:9480` instead of OpenAI

---

## Platform support

| Platform | Desktop app | Headless server | Mesh networking |
|---|---|---|---|
| Mac (Apple Silicon) | ✓ | ✓ | ✓ |
| Mac (Intel) | ✓ | ✓ | ✓ |
| Linux 64-bit | ✓ | ✓ | ✓ |
| Linux ARM64 | — | ✓ | ✓ |
| Windows 64-bit | ✓ | ✓ | ✓ |

---

## Build from source

```bash
cd linus-ai-rs
cargo build --release --bin linus_ai           # headless server
cargo build --release --package linus-ai-gui   # desktop window
```

See [BUILD.md](BUILD.md) for the full cross-platform build guide.

---

## License

[LINUS Source License v2.0](LICENSE.md). Community use is free forever. Professional and above require a purchased key.  
Third-party licenses: [THIRD-PARTY-LICENSES.md](THIRD-PARTY-LICENSES.md).
