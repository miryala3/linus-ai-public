# LINUS-AI v4.0.2

**Private AI inference engine — runs entirely on your hardware, zero cloud.**

[![Version](https://img.shields.io/badge/version-4.0.2-green)]()
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey)]()
[![Community Free](https://img.shields.io/badge/community-free%20forever-brightgreen)]()

> Part of the **[LINUS-AI Product Suite](https://github.com/miryala3/linus-ai-public)**  
> Purchase: **[linus-ai.com/store](https://linus-ai.com/store/index.html#linus-ai)**

---

## What it does

One binary. No Python, no Docker, no accounts. Download, run, open your browser — private AI in under a minute.

- Chat interface at `http://127.0.0.1:9480/app`
- OpenAI-compatible API (`/v1/chat/completions`, `/v1/models`, `/v1/embeddings`)
- Metal on Apple Silicon, CUDA on NVIDIA, CPU fallback everywhere
- Mesh networking — auto-discover LAN nodes, distribute inference across machines
- Agentic workflows with MCP tool use
- HIPAA compliance engine — PII detection, role profiles, audit logs
- Blockchain audit ledger — Ed25519-signed per-request trail (Team+)
- Community tier **free forever**, no key required

---

## Pricing

| Tier | Price | Model cap | Seats |
|---|---|---|---|
| **Community** | Free | 5B params | 1 |
| **90-Day Access** | $33 one-time or $33/90d | 70B params | 1 |
| **Professional** | $499 one-time | 70B params | 1 |
| **Team** | $1,499 one-time | 70B params | 5 |
| **Enterprise** | $7,999/yr | Unlimited | Unlimited |
| **Enterprise Plus** | $14,999/yr | Unlimited | Unlimited |

---

## Download — v4.0.2

| Platform | File |
|---|---|
| macOS arm64 — Apple Silicon (DMG) | [`linus-ai-v4.0.2-macos.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-macos.dmg) |
| macOS arm64 — headless binary | [`linus-ai-v4.0.2-headless-macos-arm64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-macos-arm64) |
| macOS x86_64 — headless binary | [`linus-ai-v4.0.2-headless-macos-x86_64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-macos-x86_64) |
| Linux x86_64 — GUI (.deb) | [`linus-ai-v4.0.2-linux-x86_64.deb`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-linux-x86_64.deb) |
| Linux x86_64 — headless binary | [`linus-ai-v4.0.2-headless-linux-x86_64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-linux-x86_64) |
| Linux arm64 — headless binary | [`linus-ai-v4.0.2-headless-linux-arm64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-linux-arm64) |
| Windows x86_64 — GUI (MSIX) | [`linus-ai-v4.0.2-windows-x86_64.msix`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-windows-x86_64.msix) |
| Windows x86_64 — headless binary | [`linus-ai-v4.0.2-headless-windows-x86_64.exe`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-windows-x86_64.exe) |
| Checksums | [`SHA256SUMS.txt`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/SHA256SUMS.txt) |

[→ All LINUS-AI releases](https://github.com/miryala3/linus-ai-public/releases?q=tag%3Av)

---

## Install

**macOS headless**
```bash
chmod +x linus-ai-v4.0.2-headless-macos-arm64
xattr -d com.apple.quarantine linus-ai-v4.0.2-headless-macos-arm64
./linus-ai-v4.0.2-headless-macos-arm64
```
> Blocked by Gatekeeper? System Settings → Privacy & Security → Open Anyway

**macOS DMG** — open → drag to Applications → right-click → Open on first launch

**Linux**
```bash
chmod +x linus-ai-v4.0.2-headless-linux-x86_64 && ./linus-ai-v4.0.2-headless-linux-x86_64
# or: sudo dpkg -i linus-ai-v4.0.2-linux-x86_64.deb
```

**Windows** — run MSIX or `.exe`. Click "More info → Run anyway" if SmartScreen appears.

Control panel at **http://127.0.0.1:9480/app** → Models → Browse → Download your first model. Community starts immediately, no key needed.

---

## Activate

```bash
linus-ai --activate LNAI-XXXX-XXXX-XXXX-XXXX
# or: control panel → Settings → License → Enter Key
```

Transfer to new machine: `linus-ai --deactivate` (old) then `--activate` (new).  
Lost key? → [linus-ai.com/reset](https://linus-ai.com/reset.html)

---

## Support

[support@linus-ai.com](mailto:support@linus-ai.com) · [linus-ai.com/support](https://linus-ai.com/support.html)
