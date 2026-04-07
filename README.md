# LINUS-AI — Download Hub

Pre-built binaries for all LINUS-AI products. Everything runs entirely on your hardware — no cloud, no telemetry, no subscription required.

---

## Products

| Product | Latest Release | Description |
|---|---|---|
| **[LINUS-AI](https://github.com/miryala3/linus-ai-public/releases/tag/v3.0.0)** | v3.0.0 | Private distributed AI platform |
| **[LINUS BizCore](https://github.com/miryala3/linus-ai-public/releases/tag/bizcore-v3.0.0)** | v3.0.0 | Local-first business OS |

---

## LINUS-AI v3.0.0

Private AI that runs on your hardware. Single binary, no Python, no cloud.

### Downloads

| Platform | File | Notes |
|---|---|---|
| macOS arm64 | `linus-ai-3.0.0-macos-arm64` | Apple Silicon (M1/M2/M3/M4) |
| macOS x86_64 | `linus-ai-3.0.0-macos-x86_64` | Intel Mac |
| macOS Universal | `linus-ai-3.0.0-macos-universal` | arm64 + x86_64 in one binary |
| Linux x86_64 | `linus-ai-3.0.0-linux-x86_64` | GUI mode, requires WebKit2GTK |
| Linux arm64 | `linus-ai-3.0.0-linux-arm64` | Raspberry Pi 5, ARM servers |
| Windows x86_64 | `linus-ai-3.0.0-windows-x86_64.exe` | Portable, no install needed |

---

## How to Launch

### macOS

```bash
# 1. Download the binary for your chip (arm64 = Apple Silicon, x86_64 = Intel)
curl -LO https://github.com/miryala3/linus-ai-public/releases/download/v3.0.0/linus-ai-3.0.0-macos-arm64

# 2. Make it executable
chmod +x linus-ai-3.0.0-macos-arm64

# 3. Remove macOS quarantine and ad-hoc sign
xattr -d com.apple.quarantine linus-ai-3.0.0-macos-arm64
codesign --force --deep --sign - linus-ai-3.0.0-macos-arm64

# 4. Run
./linus-ai-3.0.0-macos-arm64
```

> **Gatekeeper note:** If macOS still blocks the binary, go to  
> **System Settings → Privacy & Security → scroll down → "Open Anyway"**

The GUI opens at **http://127.0.0.1:9480** in your default browser.  
The control panel is at **http://127.0.0.1:9480/app** (settings, licence, models).

---

### Linux

```bash
# 1. Install runtime dependencies (Debian/Ubuntu)
sudo apt-get install -y libwebkit2gtk-4.1-0 libgtk-3-0 \
  libayatana-appindicator3-1 librsvg2-2 libxdo3

# 2. Download
curl -LO https://github.com/miryala3/linus-ai-public/releases/download/v3.0.0/linus-ai-3.0.0-linux-x86_64

# 3. Make executable and run
chmod +x linus-ai-3.0.0-linux-x86_64
./linus-ai-3.0.0-linux-x86_64
```

> **Fedora/RHEL:** Install `webkit2gtk4.1` and `gtk3` via dnf instead.

---

### Windows

```powershell
# Download linus-ai-3.0.0-windows-x86_64.exe from the Releases page, then:
.\linus-ai-3.0.0-windows-x86_64.exe
```

> **SmartScreen note:** Click "More info" → "Run anyway" if Windows Defender SmartScreen appears.  
> The binary is not code-signed yet — this is expected for v3.0.0.

---

## First Launch

1. The binary starts a local server on **port 9480** and **port 9481** (API).
2. Your browser opens automatically to **http://127.0.0.1:9480**.
3. On first run, LINUS-AI operates in **Community** mode (free, 5B model cap).
4. To unlock higher tiers, go to **Settings → Licence → Activate** and paste your key.

### Activate a Licence Key

```
Control Panel → http://127.0.0.1:9480/app
  └── Settings → Licence → Paste key → Activate
```

Activation is **fully offline** — no internet required after the one-time check.  
Keys are tied to one machine. To move: **Settings → Licence → Deactivate**, then activate on the new machine.

### Download a Model

```
Control Panel → Models → Browse → Download
```

Recommended starting models:
- **Llama 3.2 3B** — fastest, works on 8 GB RAM
- **Mistral 7B Q4** — balanced quality/speed on 16 GB RAM
- **Llama 3.1 70B Q4** — full Pro/Team tier capability on 64 GB+ RAM

---

## Tiers & Pricing

| Tier | Price | Model Cap | Key Features |
|---|---|---|---|
| Community | Free | 5B params | Inference + GUI |
| Professional | $249 one-time | 70B params | Vault, agentic mode, mesh, REST API |
| Team | $799 one-time | 70B params | + Federated learning, blockchain audit, 5 seats |
| Enterprise | $3,500–$6,000/yr | Unlimited | + Air-gap, SSO/LDAP, fine-tuning, priority support |

Hardware caps apply within each tier: 8 GB RAM ≈ 8B Q4, 16 GB ≈ 14B, 32 GB ≈ 34B, 64 GB+ ≈ up to your tier ceiling.

Purchase: [linus-ai.com/pricing](https://linus-ai.com/pricing)  
PayPal accepted at checkout.

---

## LINUS BizCore v3.0.0

Complete business OS — invoicing, CRM, HR, accounting, AI assistant. One-time purchase.

### Downloads

| Platform | File |
|---|---|
| macOS arm64 (Apple Silicon) | `bizcore-LINUS-BizCore_3.0.0_aarch64.dmg` |
| Linux x86_64 | `bizcore-LINUS-BizCore_3.0.0_amd64.deb` / `.AppImage` |
| Windows x86_64 | `bizcore-LINUS-BizCore_3.0.0_x64-setup.exe` |

```bash
# Linux runtime deps:
sudo apt-get install -y libwebkit2gtk-4.1-0 libgtk-3-0 \
  libayatana-appindicator3-1 librsvg2-2
```

### Tiers

| Tier | Price | Modules |
|---|---|---|
| Starter | $79 one-time | Core 5 modules |
| Business | $199 one-time | All 8 modules |
| Unlimited | $499 one-time | All modules, unlimited users |

14-day free trial on first launch. Purchase: [linus-ai.com/products/bizcore](https://linus-ai.com/products/bizcore)

---

## Verify Downloads

All releases include `SHA256SUMS.txt`. Verify before running:

```bash
# Linux / macOS
sha256sum -c SHA256SUMS.txt

# macOS (shasum)
shasum -a 256 -c SHA256SUMS.txt
```

---

## Firewall / Port Reference

| Port | Purpose |
|---|---|
| 9480 | GUI + web interface |
| 9481 | REST API (local only by default) |
| 9482 | Mesh networking (Pro/Team/Enterprise) |

All ports bind to `127.0.0.1` by default. No inbound internet exposure.

---

## Support

| Tier | Support |
|---|---|
| Community | [GitHub Issues](https://github.com/miryala3/linus-ai-public/issues) |
| Professional / Team | support@linus-ai.com |
| Enterprise | support@linus-ai.com + SLA |

---

## Source & Licensing

Source code is available under the [LINUS Source License v2.0](https://linus-ai.com/license).  
For commercial licensing: [sales@linus-ai.com](mailto:sales@linus-ai.com)
