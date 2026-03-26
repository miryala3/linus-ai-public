# LINUS-AI — Download Hub

Pre-built binaries for all LINUS-AI products. All products run entirely on your hardware — no cloud, no telemetry.

---

## Products

| Product | Latest Release | Description |
|---|---|---|
| **[LINUS-AI](https://github.com/miryala3/linus-ai-public/releases/tag/v2.6.0)** | v2.6.0 | Private distributed AI platform |
| **[LINUS BizCore](https://github.com/miryala3/linus-ai-public/releases/tag/bizcore-v2.6.0)** | v2.6.0 | Local-first business OS |

---

## LINUS-AI v2.6.0

Private AI that runs on your hardware. Single binary, no Python, no cloud.

### Downloads

| Platform | File | Notes |
|---|---|---|
| macOS (Universal DMG) | `linus-ai-2.6.0-macos.dmg` | arm64 + x86_64, drag to Applications |
| macOS arm64 binary | `linus-ai-2.6.0-macos-arm64` | Apple Silicon |
| macOS x86_64 binary | `linus-ai-2.6.0-macos-x86_64` | Intel Mac |
| macOS Universal binary | `linus-ai-2.6.0-macos-universal` | Both architectures |
| Linux x86_64 GUI | `linus-ai-2.6.0-linux-x86_64` | Requires WebKit2GTK |
| Linux x86_64 .deb | `linus-ai_2.6.0_amd64.deb` | Debian/Ubuntu package |
| Linux x86_64 headless | `linus-ai-2.6.0-headless-linux-x86_64` | Server/CLI mode |
| Linux arm64 headless | `linus-ai-2.6.0-headless-linux-arm64` | Raspberry Pi 5, ARM servers |
| macOS arm64 headless | `linus-ai-2.6.0-headless-macos-arm64` | |
| macOS x86_64 headless | `linus-ai-2.6.0-headless-macos-x86_64` | |
| Windows x86_64 (MSIX) | `linus-ai-2.6.0-windows-x86_64.msix` | Microsoft Store format |
| Windows x86_64 binary | `linus-ai-2.6.0-windows-x86_64.exe` | Portable |
| Windows x86_64 headless | `linus-ai-2.6.0-headless-windows-x86_64.exe` | Server/CLI mode |

```bash
# macOS / Linux:
chmod +x linus-ai-2.6.0-linux-x86_64 && ./linus-ai-2.6.0-linux-x86_64

# Linux GUI runtime deps:
sudo apt-get install -y libwebkit2gtk-4.1-0 libgtk-3-0 \
  libayatana-appindicator3-1 librsvg2-2 libxdo3
```

### Tiers

| Tier | Price | Model Cap | Key Features |
|---|---|---|---|
| Community | Free | 5B params | Inference + GUI |
| Trial | Free 30 days | 70B params | Full Professional |
| Professional | $149 one-time | 70B params | Vault, agentic, mesh, API |
| Team | $299 one-time | 70B params | + Federated learning, audit |
| Enterprise | $4,999/yr | Unlimited | + Air-gap, SSO, fine-tuning |

Purchase: [linus-ai.com/pricing](https://linus-ai.com/pricing)

---

## LINUS BizCore v2.6.0

Complete business OS — invoicing, CRM, HR, accounting, AI assistant. One-time purchase.

### Downloads

| Platform | File |
|---|---|
| macOS arm64 (Apple Silicon) | `bizcore-LINUS-BizCore_2.6.0_aarch64.dmg` |
| Linux x86_64 | `bizcore-LINUS-BizCore_2.6.0_amd64.deb` / `.AppImage` |
| Windows x86_64 | `bizcore-LINUS-BizCore_2.6.0_x64-setup.exe` |

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

All releases include `SHA256SUMS.txt`:

```bash
sha256sum -c SHA256SUMS.txt
```

---

## Support

| Tier | Support |
|---|---|
| Community | [GitHub Issues](https://github.com/miryala3/linus-ai-public/issues) |
| Professional / Team | Email support: support@linus-ai.com |
| Enterprise | Email support + SLA: support@linus-ai.com |

---

## Source

Source code for LINUS-AI is available under the [LINUS Source License v2.0](https://linus-ai.com/license).
Contact [sales@linus-ai.com](mailto:sales@linus-ai.com) for commercial licensing.
