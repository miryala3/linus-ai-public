# LINUS-AI Product Suite

**Private AI, business tools, and clinical AI — all running on your hardware. No cloud. No subscriptions required.**

[![License](https://img.shields.io/badge/license-Proprietary-red)]()
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey)]()

---

## Products

| Product | Latest | Platform | Price from |
|---|---|---|---|
| **[LINUS-AI](#linus-ai-v402)** | v4.0.2 | macOS · Linux · Windows | Free |
| **[LINUS BizCore](#linus-bizcore-v400)** | v4.0.0 | macOS · Linux | $199 |
| **[BizCore Extension](#linus-bizcore-extension-v400)** | v4.0.0 | Chrome · Edge · Firefox · Brave | Free w/ BizCore |
| **[aiMED Medical](#linus-ai-medical-server-v402)** | v4.0.2 | macOS · Linux | $1,499 |
| **[aiMED Extension](#aimed-extension-v402)** | v4.0.2 | Chrome · Edge · Firefox · Brave | $10/90d |
| **[LINUS ConnectX](#linus-connectx-v011)** | v0.1.1 | macOS · Linux · Windows | $149 |
| **[LINUS Pulse](#linus-pulse-v011)** | v0.1.1 | macOS · Linux · Windows | $49 |
| **[LINUS Forge](#linus-forge-v011)** | v0.1.1 | macOS · Linux · Windows | $199 |
| **[LINUS Trips](#linus-trips-v012)** | v0.1.2 | Linux · Windows | $99 |
| **[LINUS Reserve](#linus-reserve-v201)** | v2.0.1 | macOS · Linux · Windows | $199 |
| **[LINUS Day](#linus-day-v223)** | v2.2.3 | macOS · Linux · Windows | $99 |
| **[P2P Network](#p2p-network-v012)** | v0.1.2 | macOS · Linux · Windows | $299 |

**Purchase flow (all products):**  
**→ [linus-ai.com/store](https://linus-ai.com/store/index.html)** — PayPal checkout on the website creates your order and delivers your license key by email automatically, within minutes of payment. No manual steps required.

---

## LINUS-AI v4.0.2

Private AI that runs entirely on your hardware — no cloud, no telemetry, no Python required.

- Single Rust binary with bundled inference engine (Metal on Apple Silicon, CUDA on NVIDIA, CPU fallback)
- Web control panel at `http://127.0.0.1:9480/app`
- Mesh networking — auto-discover LAN nodes, distribute inference across machines
- Full OpenAI-compatible API (`/v1/chat/completions`, `/v1/models`, `/v1/embeddings`)
- Agentic workflows — multi-step ReAct loop with MCP tool use
- HIPAA/compliance engine — PII detection, role profiles, HMAC-chained audit logs
- Blockchain audit ledger — tamper-evident, Ed25519-signed per-request trail (Team+)

### Pricing

| Tier | Price | Model cap | Profiles |
|---|---|---|---|
| **Community** | Free forever | 5B params | 6 |
| **90-Day Access** | $33 one-time or $33/90d | 70B params | 14 |
| **Professional** | $499 one-time | 70B params | 14 |
| **Team** (5 seats) | $1,499 one-time | 70B params | 14 |
| **Enterprise** (unlimited seats) | $7,999/yr | Unlimited | Unlimited |
| **Enterprise Plus** (unlimited seats) | $14,999/yr | Unlimited | Unlimited |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#linus-ai)**

### Download

| Platform | File |
|---|---|
| macOS arm64 — Apple Silicon (headless) | [`linus-ai-v4.0.2-headless-macos-arm64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-macos-arm64) |
| macOS x86_64 — Intel (headless) | [`linus-ai-v4.0.2-headless-macos-x86_64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-macos-x86_64) |
| macOS GUI (DMG) | [`linus-ai-v4.0.2-macos.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-macos.dmg) |
| Linux x86_64 (headless) | [`linus-ai-v4.0.2-headless-linux-x86_64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-linux-x86_64) |
| Linux arm64 (headless) | [`linus-ai-v4.0.2-headless-linux-arm64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-linux-arm64) |
| Linux .deb (GUI) | [`linus-ai-v4.0.2-linux-x86_64.deb`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-linux-x86_64.deb) |
| Windows x86_64 (headless) | [`linus-ai-v4.0.2-headless-windows-x86_64.exe`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-windows-x86_64.exe) |
| Windows MSIX (GUI) | [`linus-ai-v4.0.2-windows-x86_64.msix`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-windows-x86_64.msix) |
| Checksums | [`SHA256SUMS.txt`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/SHA256SUMS.txt) |

### Install

**macOS**
```bash
chmod +x linus-ai-v4.0.2-headless-macos-arm64
xattr -d com.apple.quarantine linus-ai-v4.0.2-headless-macos-arm64
./linus-ai-v4.0.2-headless-macos-arm64
```
> If macOS blocks it: **System Settings → Privacy & Security → Open Anyway**

**Linux**
```bash
chmod +x linus-ai-v4.0.2-headless-linux-x86_64
./linus-ai-v4.0.2-headless-linux-x86_64
```

**Windows** — Download and run the `.exe`. Click "More info → Run anyway" if SmartScreen appears.

Control panel opens at **http://127.0.0.1:9480/app** — go to **Models → Browse → Download** to get your first model. Community tier starts immediately, no key needed.

### Activate a paid license

```bash
linus-ai --activate LNAI-XXXX-XXXX-XXXX-XXXX
```

---

## LINUS BizCore v4.0.0

Local-first business OS — one app for everything, no SaaS fees.

- Dashboard, Invoicing, Contacts/CRM, Tasks, Calendar, Documents, HR & Payroll, Accounting
- AI Assistant — chat with your business data (connects to LINUS-AI on port 9480)
- BizCore Extension included free with every license

### Pricing

| Tier | Price | Modules | Users |
|---|---|---|---|
| **90-Day Access** | $17 one-time or $17/90d | Starter modules | 1 |
| **Starter** | $199 one-time | 6 core modules | 1 |
| **Business** | $299 one-time | All 13 modules | 5 |
| **Unlimited** | $599 one-time | All 16 modules | Unlimited |

Optional annual updates: $49/yr (Starter) · $79/yr (Business) · $99/yr (Unlimited)

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#bizcore)**

### Download

| Platform | File |
|---|---|
| macOS arm64 — Apple Silicon (DMG) | [`bizcore-LINUS-BizCore_4.0.0_aarch64.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-v4.0.0/bizcore-LINUS-BizCore_4.0.0_aarch64.dmg) |
| Linux x86_64 (.deb) | [`bizcore-LINUS-BizCore_4.0.0_amd64.deb`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-v4.0.0/bizcore-LINUS-BizCore_4.0.0_amd64.deb) |
| Linux x86_64 (AppImage) | [`bizcore-LINUS-BizCore_4.0.0_amd64.AppImage`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-v4.0.0/bizcore-LINUS-BizCore_4.0.0_amd64.AppImage) |

### Install

**macOS**
```bash
xattr -d com.apple.quarantine bizcore-LINUS-BizCore_4.0.0_aarch64.dmg
# double-click the DMG → drag to Applications → right-click → Open on first launch
```

**Linux (deb)**
```bash
sudo apt-get install -y libwebkit2gtk-4.1-0 libgtk-3-0 libayatana-appindicator3-1 librsvg2-2
sudo dpkg -i bizcore-LINUS-BizCore_4.0.0_amd64.deb
```

**Linux (AppImage)**
```bash
chmod +x bizcore-LINUS-BizCore_4.0.0_amd64.AppImage && ./bizcore-LINUS-BizCore_4.0.0_amd64.AppImage
```

---

## LINUS BizCore Extension v4.0.0

AI business assistant for Chrome, Edge, Firefox, Brave, Opera. Works inside QuickBooks, Xero, Stripe, HubSpot, Salesforce, Gmail, Outlook. **Included free with any BizCore license.**

### Pricing

| Option | Price |
|---|---|
| Included with any BizCore license | Free |
| Extension only | $99 one-time |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#bizcore)**

### Download

| Browser | File |
|---|---|
| Chrome | [`bizcore-ext-bizcore-chrome-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-ext-bizcore-chrome-v4.0.0.zip) |
| Edge | [`bizcore-ext-bizcore-edge-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-ext-bizcore-edge-v4.0.0.zip) |
| Brave | [`bizcore-ext-bizcore-brave-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-ext-bizcore-brave-v4.0.0.zip) |
| Opera | [`bizcore-ext-bizcore-opera-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-ext-bizcore-opera-v4.0.0.zip) |
| Firefox | [`bizcore-ext-bizcore-firefox-v4.0.0.xpi`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-ext-bizcore-firefox-v4.0.0.xpi) |

**Chrome / Edge / Brave / Opera:** Unzip → `chrome://extensions` → Developer mode → Load unpacked  
**Firefox:** `about:addons` → gear → Install Add-on From File → select `.xpi`

---

## LINUS-AI Medical Server v4.0.2

HIPAA-compliant private AI server. All inference on-premise — PHI never leaves your infrastructure. Every paid license includes 3 keys: aiMED Medical Server · aiMED Extension · LINUS-AI.

- Role-scoped clinical AI (physician, nurse, radiologist, pharmacist, and more)
- PHI detection + append-only audit log (JSONL, daily rotation)
- Supports Med42, Meditron, BioMistral, ClinicalCamel (GGUF)
- Single binary, no Python, no cloud

### Pricing

| Tier | Concurrent users | Price |
|---|---|---|
| **Clinic** | 25 | $1,499 one-time |
| **Hospital** | 500 | $9,999 one-time |
| **Health System** | Unlimited | $99,999 one-time |

Lifetime update add-ons: +$299 (Clinic) · +$999 (Hospital) · +$9,999 (Health System)

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#aimed)**

### Download

| Platform | File |
|---|---|
| macOS arm64 — Apple Silicon | [`med-linus-ai-med-4.0.2-aarch64-apple-darwin.tar.gz`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.2/med-linus-ai-med-4.0.2-aarch64-apple-darwin.tar.gz) |
| Linux x86_64 | [`med-linus-ai-med-4.0.2-x86_64-unknown-linux-gnu.tar.gz`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.2/med-linus-ai-med-4.0.2-x86_64-unknown-linux-gnu.tar.gz) |
| Linux arm64 | [`med-linus-ai-med-4.0.2-aarch64-unknown-linux-gnu.tar.gz`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.2/med-linus-ai-med-4.0.2-aarch64-unknown-linux-gnu.tar.gz) |

### Install

```bash
# macOS
tar xzf linus-ai-med-4.0.2-aarch64-apple-darwin.tar.gz
xattr -d com.apple.quarantine linus-ai-med && codesign --force --deep --sign - linus-ai-med
bash quickstart.sh

# Linux
tar xzf linus-ai-med-4.0.2-x86_64-unknown-linux-gnu.tar.gz && bash quickstart.sh
```

Admin interface: `http://localhost:9500/admin` — never expose port 9500 to the internet without TLS.

---

## aiMED Extension v4.0.2

Clinical AI for healthcare practices — 8 workflow tabs (Chart Summary, Pre-Charter, Inbox Zero, Billing Optimizer, Patient Educator, Quick Tools, Insurance Verify, SuggestCare). Requires aiMED Medical Server (port 9500). Uses a `LNAM-*` license key.

### Pricing

| Tier | Devices | Price |
|---|---|---|
| **90-Day Access** | 2 | $10 one-time or $10/90d |
| **Extension Only** | 2 | $99 one-time |
| **Solo Practice** | 2 | $299/yr |
| **Small Practice** | 10 | $799/yr |
| **Group Practice** | Unlimited | $1,999/yr |
| **Health System** | Unlimited | $9,999/yr |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#aimed-ext)**

### Download

| Browser | File |
|---|---|
| Chrome | [`aimed-ext-aiMED-chrome-v4.0.2.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.2/aimed-ext-aiMED-chrome-v4.0.2.zip) |
| Edge | [`aimed-ext-aiMED-edge-v4.0.2.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.2/aimed-ext-aiMED-edge-v4.0.2.zip) |
| Brave | [`aimed-ext-aiMED-brave-v4.0.2.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.2/aimed-ext-aiMED-brave-v4.0.2.zip) |
| Opera | [`aimed-ext-aiMED-opera-v4.0.2.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.2/aimed-ext-aiMED-opera-v4.0.2.zip) |
| Firefox | [`aimed-ext-aiMED-firefox-v4.0.2.xpi`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.2/aimed-ext-aiMED-firefox-v4.0.2.xpi) |

**Chrome / Edge / Brave / Opera:** Unzip → `chrome://extensions` → Developer mode → Load unpacked  
**Firefox:** `about:addons` → gear → Install Add-on From File → `.xpi`  
After install: extension → Settings → Account → enter `LNAM-*` key.

---

## LINUS ConnectX v0.1.1

Private P2P career network. No LinkedIn data mining, no algorithmic suppression, no central servers. Encrypted peer-to-peer connections, direct messaging, project boards, portfolio hosting.

### Pricing

| Tier | Price |
|---|---|
| **90-Day Access** | $30 one-time or $30/90d |
| **ConnectX Pro** | $149 one-time |
| **Enterprise** | $499/yr |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#connectx)**

### Download

| Platform | File |
|---|---|
| macOS arm64 — Apple Silicon (DMG) | [`connectx-LINUS.ConnectX_0.1.1_aarch64.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/connectx-v0.1.1/connectx-LINUS.ConnectX_0.1.1_aarch64.dmg) |
| macOS x64 — Intel (DMG) | [`connectx-LINUS.ConnectX_0.1.1_x64.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/connectx-v0.1.1/connectx-LINUS.ConnectX_0.1.1_x64.dmg) |
| Linux x86_64 (.deb) | [`connectx-LINUS.ConnectX_0.1.1_amd64.deb`](https://github.com/miryala3/linus-ai-public/releases/download/connectx-v0.1.1/connectx-LINUS.ConnectX_0.1.1_amd64.deb) |
| Linux x86_64 (AppImage) | [`connectx-LINUS.ConnectX_0.1.1_amd64.AppImage`](https://github.com/miryala3/linus-ai-public/releases/download/connectx-v0.1.1/connectx-LINUS.ConnectX_0.1.1_amd64.AppImage) |
| Windows x64 (Setup) | [`connectx-LINUS.ConnectX_0.1.1_x64-setup.exe`](https://github.com/miryala3/linus-ai-public/releases/download/connectx-v0.1.1/connectx-LINUS.ConnectX_0.1.1_x64-setup.exe) |
| Windows x64 (MSI) | [`connectx-LINUS.ConnectX_0.1.1_x64_en-US.msi`](https://github.com/miryala3/linus-ai-public/releases/download/connectx-v0.1.1/connectx-LINUS.ConnectX_0.1.1_x64_en-US.msi) |
| Checksums | [`SHA256SUMS-connectx.txt`](https://github.com/miryala3/linus-ai-public/releases/download/connectx-v0.1.1/SHA256SUMS-connectx.txt) |

---

## LINUS Pulse v0.1.1

Personal AI suite — journal, goals, finances, AI summariser. All offline on your own hardware. 1-device Solo or 5-device Family license.

### Pricing

| Tier | Price |
|---|---|
| **90-Day Access** | $10 one-time or $10/90d |
| **Solo** (1 device) | $49 one-time |
| **Family** (5 devices) | $99 one-time |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#pulse)**

### Download

| Platform | File |
|---|---|
| macOS arm64 — Apple Silicon (DMG) | [`pulse-LINUS.Pulse_0.1.1_aarch64.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/pulse-v0.1.1/pulse-LINUS.Pulse_0.1.1_aarch64.dmg) |
| macOS x64 — Intel (DMG) | [`pulse-LINUS.Pulse_0.1.1_x64.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/pulse-v0.1.1/pulse-LINUS.Pulse_0.1.1_x64.dmg) |
| Linux x86_64 (.deb) | [`pulse-LINUS.Pulse_0.1.1_amd64.deb`](https://github.com/miryala3/linus-ai-public/releases/download/pulse-v0.1.1/pulse-LINUS.Pulse_0.1.1_amd64.deb) |
| Linux x86_64 (AppImage) | [`pulse-LINUS.Pulse_0.1.1_amd64.AppImage`](https://github.com/miryala3/linus-ai-public/releases/download/pulse-v0.1.1/pulse-LINUS.Pulse_0.1.1_amd64.AppImage) |
| Windows x64 (Setup) | [`pulse-LINUS.Pulse_0.1.1_x64-setup.exe`](https://github.com/miryala3/linus-ai-public/releases/download/pulse-v0.1.1/pulse-LINUS.Pulse_0.1.1_x64-setup.exe) |
| Windows x64 (MSI) | [`pulse-LINUS.Pulse_0.1.1_x64_en-US.msi`](https://github.com/miryala3/linus-ai-public/releases/download/pulse-v0.1.1/pulse-LINUS.Pulse_0.1.1_x64_en-US.msi) |
| Checksums | [`SHA256SUMS-pulse.txt`](https://github.com/miryala3/linus-ai-public/releases/download/pulse-v0.1.1/SHA256SUMS-pulse.txt) |

---

## LINUS Forge v0.1.1

P2P product studio — build and distribute decentralised apps on the LINUS-AI mesh. SDK, visual builder, peer distribution, offline-first storage, LINUS-AI integration hooks.

### Pricing

| Tier | Price |
|---|---|
| **90-Day Access** | $40 one-time or $40/90d |
| **Forge Studio** | $199 one-time |
| **Enterprise** | $799/yr |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#forge)**

### Download

| Platform | File |
|---|---|
| macOS arm64 — Apple Silicon (DMG) | [`forge-LINUS.Forge_0.1.1_aarch64.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/forge-v0.1.1/forge-LINUS.Forge_0.1.1_aarch64.dmg) |
| macOS x64 — Intel (DMG) | [`forge-LINUS.Forge_0.1.1_x64.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/forge-v0.1.1/forge-LINUS.Forge_0.1.1_x64.dmg) |
| Linux x86_64 (.deb) | [`forge-LINUS.Forge_0.1.1_amd64.deb`](https://github.com/miryala3/linus-ai-public/releases/download/forge-v0.1.1/forge-LINUS.Forge_0.1.1_amd64.deb) |
| Linux x86_64 (AppImage) | [`forge-LINUS.Forge_0.1.1_amd64.AppImage`](https://github.com/miryala3/linus-ai-public/releases/download/forge-v0.1.1/forge-LINUS.Forge_0.1.1_amd64.AppImage) |
| Windows x64 (Setup) | [`forge-LINUS.Forge_0.1.1_x64-setup.exe`](https://github.com/miryala3/linus-ai-public/releases/download/forge-v0.1.1/forge-LINUS.Forge_0.1.1_x64-setup.exe) |
| Windows x64 (MSI) | [`forge-LINUS.Forge_0.1.1_x64_en-US.msi`](https://github.com/miryala3/linus-ai-public/releases/download/forge-v0.1.1/forge-LINUS.Forge_0.1.1_x64_en-US.msi) |
| Checksums | [`SHA256SUMS-forge.txt`](https://github.com/miryala3/linus-ai-public/releases/download/forge-v0.1.1/SHA256SUMS-forge.txt) |

---

## LINUS Trips v0.1.2

AI travel workspace — itinerary builder, hotel & flight search, expense tracking. Offline-first, no cloud required. Buy once, own forever.

### Pricing

| Tier | Price |
|---|---|
| **90-Day Access** | $20 one-time or $20/90d |
| **Trips Pro** | $99 one-time |
| **Enterprise** | $499/yr |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#trips)**

### Download

| Platform | File |
|---|---|
| Linux x86_64 (.deb) | [`trips-LINUS-AI.Trips_0.1.2_amd64.deb`](https://github.com/miryala3/linus-ai-public/releases/download/trips-v0.1.2/trips-LINUS-AI.Trips_0.1.2_amd64.deb) |
| Linux x86_64 (AppImage) | [`trips-LINUS-AI.Trips_0.1.2_amd64.AppImage`](https://github.com/miryala3/linus-ai-public/releases/download/trips-v0.1.2/trips-LINUS-AI.Trips_0.1.2_amd64.AppImage) |
| Windows x64 (Setup) | [`trips-LINUS-AI.Trips_0.1.2_x64-setup.exe`](https://github.com/miryala3/linus-ai-public/releases/download/trips-v0.1.2/trips-LINUS-AI.Trips_0.1.2_x64-setup.exe) |
| Windows x64 (MSI) | [`trips-LINUS-AI.Trips_0.1.2_x64_en-US.msi`](https://github.com/miryala3/linus-ai-public/releases/download/trips-v0.1.2/trips-LINUS-AI.Trips_0.1.2_x64_en-US.msi) |
| Checksums | [`SHA256SUMS-trips.txt`](https://github.com/miryala3/linus-ai-public/releases/download/trips-v0.1.2/SHA256SUMS-trips.txt) |

---

## LINUS Reserve v2.0.1

AI hospitality management — reservations, yield optimiser, no-show prediction, POS integration, AI booking agent. No per-cover fees. Flat license.

### Pricing

| Tier | Price |
|---|---|
| **90-Day Access** | $40 one-time or $40/90d |
| **Reserve Pro** (single venue) | $199 one-time |
| **Enterprise** (multi-property) | $799/yr |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#reserve)**

### Download

| Platform | File |
|---|---|
| macOS (universal DMG) | [`reserve-Linus.Reservations_2.0.0_universal.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/reserve-v2.0.1/reserve-Linus.Reservations_2.0.0_universal.dmg) |
| Linux x86_64 (.deb) | [`reserve-Linus.Reservations_2.0.0_amd64.deb`](https://github.com/miryala3/linus-ai-public/releases/download/reserve-v2.0.1/reserve-Linus.Reservations_2.0.0_amd64.deb) |
| Linux arm64 (.deb) | [`reserve-Linus.Reservations_2.0.0_arm64.deb`](https://github.com/miryala3/linus-ai-public/releases/download/reserve-v2.0.1/reserve-Linus.Reservations_2.0.0_arm64.deb) |
| Linux x86_64 (AppImage) | [`reserve-Linus.Reservations_2.0.0_amd64.AppImage`](https://github.com/miryala3/linus-ai-public/releases/download/reserve-v2.0.1/reserve-Linus.Reservations_2.0.0_amd64.AppImage) |
| Windows x64 (Setup) | [`reserve-Linus.Reservations_2.0.0_x64-setup.exe`](https://github.com/miryala3/linus-ai-public/releases/download/reserve-v2.0.1/reserve-Linus.Reservations_2.0.0_x64-setup.exe) |
| Windows x64 (MSI) | [`reserve-Linus.Reservations_2.0.0_x64_en-US.msi`](https://github.com/miryala3/linus-ai-public/releases/download/reserve-v2.0.1/reserve-Linus.Reservations_2.0.0_x64_en-US.msi) |
| Checksums | [`SHA256SUMS-reserve.txt`](https://github.com/miryala3/linus-ai-public/releases/download/reserve-v2.0.1/SHA256SUMS-reserve.txt) |

---

## LINUS Day v2.2.3

AI daily planner — learns your rhythms, helps you plan, focus, and reflect. Task management, AI scheduling, daily briefing, focus coach, habit tracker, end-of-day reflection. Offline. Private.

### Pricing

| Tier | Price |
|---|---|
| **90-Day Access** | $17 one-time or $17/90d |
| **Day Perpetual** | $99 one-time (+$49/yr updates optional) |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#day)**

### Download

| Platform | File |
|---|---|
| macOS arm64 — Apple Silicon (DMG) | [`linus-day-LINUS-Day_2.2.3_aarch64.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/linus-day-v2.2.3/linus-day-LINUS-Day_2.2.3_aarch64.dmg) |
| macOS x64 — Intel (DMG) | [`linus-day-LINUS-Day_2.2.3_x64.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/linus-day-v2.2.3/linus-day-LINUS-Day_2.2.3_x64.dmg) |
| Linux x86_64 (.deb) | [`linus-day-LINUS-Day_2.2.3_amd64.deb`](https://github.com/miryala3/linus-ai-public/releases/download/linus-day-v2.2.3/linus-day-LINUS-Day_2.2.3_amd64.deb) |
| Linux x86_64 (AppImage) | [`linus-day-LINUS-Day_2.2.3_amd64.AppImage`](https://github.com/miryala3/linus-ai-public/releases/download/linus-day-v2.2.3/linus-day-LINUS-Day_2.2.3_amd64.AppImage) |
| Windows x64 (Setup) | [`linus-day-LINUS-Day_2.2.3_x64-setup.exe`](https://github.com/miryala3/linus-ai-public/releases/download/linus-day-v2.2.3/linus-day-LINUS-Day_2.2.3_x64-setup.exe) |
| Windows x64 (MSI) | [`linus-day-LINUS-Day_2.2.3_x64_en-US.msi`](https://github.com/miryala3/linus-ai-public/releases/download/linus-day-v2.2.3/linus-day-LINUS-Day_2.2.3_x64_en-US.msi) |
| Checksums | [`SHA256SUMS-linus-day.txt`](https://github.com/miryala3/linus-ai-public/releases/download/linus-day-v2.2.3/SHA256SUMS-linus-day.txt) |

---

## P2P Network v0.1.2

Private mesh infrastructure — encrypted peer-to-peer routing for teams. No central servers, no cloud relay. mDNS auto-discovery, private DNS, NAT traversal.

### Pricing

| Tier | Price |
|---|---|
| **Pro** (10 nodes) | $299 one-time |
| **Enterprise** (unlimited nodes) | $999/yr |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#p2pnet)**

### Download

| Platform | File |
|---|---|
| macOS arm64 — Apple Silicon (DMG) | [`p2pnet-P2PNet_0.1.2_aarch64.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/p2pnet-v0.1.2/p2pnet-P2PNet_0.1.2_aarch64.dmg) |
| macOS x64 — Intel (DMG) | [`p2pnet-P2PNet_0.1.2_x64.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/p2pnet-v0.1.2/p2pnet-P2PNet_0.1.2_x64.dmg) |
| Linux x86_64 (.deb) | [`p2pnet-P2PNet_0.1.2_amd64.deb`](https://github.com/miryala3/linus-ai-public/releases/download/p2pnet-v0.1.2/p2pnet-P2PNet_0.1.2_amd64.deb) |
| Linux x86_64 (AppImage) | [`p2pnet-P2PNet_0.1.2_amd64.AppImage`](https://github.com/miryala3/linus-ai-public/releases/download/p2pnet-v0.1.2/p2pnet-P2PNet_0.1.2_amd64.AppImage) |
| Windows x64 (Setup) | [`p2pnet-P2PNet_0.1.2_x64-setup.exe`](https://github.com/miryala3/linus-ai-public/releases/download/p2pnet-v0.1.2/p2pnet-P2PNet_0.1.2_x64-setup.exe) |
| Windows x64 (MSI) | [`p2pnet-P2PNet_0.1.2_x64_en-US.msi`](https://github.com/miryala3/linus-ai-public/releases/download/p2pnet-v0.1.2/p2pnet-P2PNet_0.1.2_x64_en-US.msi) |
| Checksums | [`SHA256SUMS-p2pnet.txt`](https://github.com/miryala3/linus-ai-public/releases/download/p2pnet-v0.1.2/SHA256SUMS-p2pnet.txt) |

---

## Bundles

| Bundle | Includes | Price | Savings |
|---|---|---|---|
| **aiMED Clinical Bundle** | aiMED Medical (Clinic) + aiMED Extension (Solo 1yr) | $1,439 | Save $359 |
| **LINUS-AI + BizCore Bundle** | LINUS-AI Pro (perpetual) + BizCore Business (perpetual) | $639 | Save $159 |

**→ [Buy bundles at linus-ai.com/store](https://linus-ai.com/store/index.html#bundles)**

---

## License Activation

After purchase you receive a license key by email (format: `PPPP-TTTT-XXXX-XXXX-XXXX`).

| Product | Key prefix | How to activate |
|---|---|---|
| LINUS-AI | `LNAI-` | `linus-ai --activate LNAI-XXXX-XXXX-XXXX-XXXX` or control panel → Settings → Licence |
| BizCore | `LNBC-` | App menu → License → Enter Key |
| BizCore Extension | `LNBC-` | Extension options → License Key |
| aiMED Medical | `LNMD-` | `POST http://localhost:9500/admin/api/activate` with key |
| aiMED Extension | `LNAM-` | Extension → Settings → Account → Enter License Key |
| ConnectX | `LNCX-` | App → Settings → Activate License |
| Pulse | `LNPA-` | App → Settings → Activate License |
| Forge | `LNFG-` | App → Settings → Activate License |
| Trips | `LNTR-` | App → Settings → License |
| Reserve | `LNRV-` | App → Settings → License |
| Day | `LNDY-` | App → Settings → License |
| P2P Network | `LNPN-` | App → Settings → License |

**Lost your key?** → [linus-ai.com/reset](https://linus-ai.com/reset.html) — enter your email to resend all keys instantly.

**Transfer to a new machine:**
```bash
linus-ai --deactivate          # on the old machine
linus-ai --activate LNAI-...   # on the new machine
```
For GUI apps: App → Settings → Deactivate, then activate on the new machine.

---

## Support

| Contact | Purpose |
|---|---|
| [support@linus-ai.com](mailto:support@linus-ai.com) | License delivery, general support |
| [sales@linus-ai.com](mailto:sales@linus-ai.com) | Enterprise, Health System, custom pricing |
| [linus-ai.com/support](https://linus-ai.com/support.html) | Troubleshooting knowledge base |
| [linus-ai.com/enterprise](https://linus-ai.com/enterprise.html) | Enterprise inquiry form |

License keys arrive by email within minutes of PayPal payment. If you don't receive yours within 15 minutes, check spam or email [support@linus-ai.com](mailto:support@linus-ai.com).
