# LINUS-AI Product Suite

**Private AI, business tools, and clinical AI — all running on your hardware. No cloud. No subscriptions required.**

[![License](https://img.shields.io/badge/license-Proprietary-red)]()
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey)]()

---

## Products

| Product | Description | Platform | Price from |
|---|---|---|---|
| **[LINUS-AI](#linus-ai-v402)** | Private distributed AI inference engine | macOS · Linux · Windows | Free |
| **[LINUS BizCore](#linus-bizcore-v400)** | Local-first business OS | macOS · Linux | $199 |
| **[BizCore Extension](#linus-bizcore-extension-v400)** | Browser AI for business apps | Chrome · Edge · Firefox · Brave | Free w/ BizCore |
| **[aiMED Medical](#linus-ai-medical-server-v402)** | HIPAA-compliant clinical AI server | macOS · Linux | $1,499 |
| **[aiMED Extension](#aimed-extension-v402)** | Clinical AI for healthcare practices | Chrome · Edge · Firefox · Brave | $10/90d |
| **[LINUS ConnectX](#linus-connectx)** | Private P2P career network | macOS · Linux · Windows | $149 |
| **[LINUS Pulse](#linus-pulse)** | Personal AI suite | macOS · Linux · Windows | $49 |
| **[LINUS Forge](#linus-forge)** | P2P product studio | macOS · Linux · Windows | $199 |
| **[LINUS Trips](#linus-trips)** | AI travel workspace | macOS · Linux · Windows | $99 |
| **[LINUS Reserve](#linus-reserve)** | AI hospitality management | macOS · Linux · Windows | $199 |
| **[LINUS Day](#linus-day)** | AI daily planner | macOS · Linux · Windows | $99 |
| **[P2P Network](#p2p-network)** | Private mesh infrastructure | macOS · Linux · Windows | $299 |

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

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#linus-ai)** — instant license delivery via PayPal checkout

### Download

| Platform | File |
|---|---|
| Linux x86_64 | [`linus-ai-v4.0.2-headless-linux-x86_64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-linux-x86_64) |
| Linux arm64 (Raspberry Pi / server) | [`linus-ai-v4.0.2-headless-linux-arm64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-linux-arm64) |
| macOS arm64 (Apple Silicon) | [`linus-ai-v4.0.2-headless-macos-arm64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-macos-arm64) |
| macOS x86_64 (Intel) | [`linus-ai-v4.0.2-headless-macos-x86_64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-macos-x86_64) |
| Windows x86_64 | [`linus-ai-v4.0.2-headless-windows-x86_64.exe`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-windows-x86_64.exe) |
| macOS DMG (GUI) | [`linus-ai-v4.0.2-macos.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-macos.dmg) |
| Windows MSIX (GUI) | [`linus-ai-v4.0.2-windows-x86_64.msix`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-windows-x86_64.msix) |
| Linux .deb (GUI) | [`linus-ai-v4.0.2-linux-x86_64.deb`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-linux-x86_64.deb) |
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

### First launch

Control panel opens at **http://127.0.0.1:9480/app**  
Go to **Models → Browse → Download** to get your first model.  
Community tier is free and starts immediately — no key needed.

### Activate a paid license

```bash
linus-ai --activate LNAI-XXXX-XXXX-XXXX-XXXX
```

---

## LINUS BizCore v4.0.0

Local-first business OS for small businesses — one app for everything, no SaaS fees.

- **Dashboard** — activity feed, KPIs, cash flow snapshot
- **Invoicing** — create, send, and track invoices and payments
- **Contacts / CRM** — customers, vendors, interaction history
- **Tasks** — project tasks, deadlines, assignments
- **Calendar** — scheduling, reminders, team events
- **Documents** — file storage, templates, e-sign
- **HR & Payroll** — employees, time tracking, payslips
- **Accounting** — chart of accounts, P&L, balance sheet
- **AI Assistant** — chat with your business data (connects to LINUS-AI on port 9480)
- BizCore Extension included free with every license

### Pricing

| Tier | Price | Modules | Users |
|---|---|---|---|
| **90-Day Access** | $17 one-time or $17/90d | Starter modules | 1 |
| **Starter** | $199 one-time | 6 core modules | 1 |
| **Business** | $299 one-time | All 13 modules | 5 |
| **Unlimited** | $599 one-time | All 16 modules | Unlimited |

Optional annual updates: $49/yr (Starter) · $79/yr (Business) · $99/yr (Unlimited)

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#bizcore)** — instant license delivery via PayPal checkout

### Download

| Platform | File |
|---|---|
| macOS arm64 (Apple Silicon) | [`bizcore-LINUS-BizCore_4.0.0_aarch64.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-v4.0.0/bizcore-LINUS-BizCore_4.0.0_aarch64.dmg) |
| Linux x86_64 (deb) | [`bizcore-LINUS-BizCore_4.0.0_amd64.deb`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-v4.0.0/bizcore-LINUS-BizCore_4.0.0_amd64.deb) |
| Linux x86_64 (AppImage) | [`bizcore-LINUS-BizCore_4.0.0_amd64.AppImage`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-v4.0.0/bizcore-LINUS-BizCore_4.0.0_amd64.AppImage) |

### Install

**macOS**
```bash
xattr -d com.apple.quarantine bizcore-LINUS-BizCore_4.0.0_aarch64.dmg
```
Then double-click the DMG, drag BizCore to Applications, right-click → Open on first launch.

**Linux (deb)**
```bash
sudo apt-get install -y libwebkit2gtk-4.1-0 libgtk-3-0 libayatana-appindicator3-1 librsvg2-2
sudo dpkg -i bizcore-LINUS-BizCore_4.0.0_amd64.deb
```

**Linux (AppImage)**
```bash
chmod +x bizcore-LINUS-BizCore_4.0.0_amd64.AppImage
./bizcore-LINUS-BizCore_4.0.0_amd64.AppImage
```

---

## LINUS BizCore Extension v4.0.0

AI business assistant in your browser — works inside QuickBooks, Xero, Stripe, HubSpot, Salesforce, Gmail, and Outlook.

- **Chat** — general business AI: strategy, analysis, writing
- **Invoice** — draft invoices, review billing, write follow-up emails
- **CRM** — customer insights, follow-up drafts, pipeline analysis
- **Tasks** — prioritize, break down projects, standup updates
- **Accounting** — expense categorization, P&L review, tax checklist
- **Page Summary** — summarize any page into action items and key figures

Requires LINUS-AI (port 9480) or BizCore running on your machine or LAN. **Included free with any BizCore license.**

### Pricing

| Option | Price |
|---|---|
| Included with any BizCore license | Free |
| Extension only | $99 one-time |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#bizcore)** — instant license delivery via PayPal checkout

### Download

| Browser | File |
|---|---|
| Chrome | [`bizcore-ext-bizcore-chrome-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-ext-bizcore-chrome-v4.0.0.zip) |
| Edge | [`bizcore-ext-bizcore-edge-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-ext-bizcore-edge-v4.0.0.zip) |
| Brave | [`bizcore-ext-bizcore-brave-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-ext-bizcore-brave-v4.0.0.zip) |
| Opera | [`bizcore-ext-bizcore-opera-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-ext-bizcore-opera-v4.0.0.zip) |
| Firefox | [`bizcore-ext-bizcore-firefox-v4.0.0.xpi`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-ext-bizcore-firefox-v4.0.0.xpi) |

### Install

**Chrome / Edge / Brave / Opera:**
1. Unzip the `.zip` file
2. Open `chrome://extensions` (or `edge://extensions`, `brave://extensions`, `opera://extensions`)
3. Enable **Developer mode** → **Load unpacked** → select the unzipped folder

**Firefox:**
1. Open `about:addons` → gear icon → **Install Add-on From File**
2. Select the `.xpi` file

---

## LINUS-AI Medical Server v4.0.2

HIPAA-compliant private AI server for hospitals, clinics, and healthcare networks. All inference on-premise — PHI never leaves your infrastructure.

- Role-scoped clinical AI — physician, nurse, radiologist, pharmacist, and more
- PHI detection and audit logging — append-only JSONL, daily rotation
- Supports Med42, Meditron, BioMistral, ClinicalCamel (GGUF format)
- Single binary — no Python, no pip, no cloud dependencies
- Every paid license includes 3 keys: aiMED Medical Server · aiMED Extension · LINUS-AI Inference Engine

### Pricing

| Tier | Concurrent users | Price |
|---|---|---|
| **Clinic** | 25 | $1,499 one-time |
| **Hospital** | 500 | $9,999 one-time |
| **Health System** | Unlimited | $99,999 one-time |

Lifetime update add-ons available: +$299 (Clinic) · +$999 (Hospital) · +$9,999 (Health System)

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#aimed)** — instant license delivery via PayPal checkout

### Download

| Platform | File |
|---|---|
| macOS arm64 (Apple Silicon) | [`med-linus-ai-med-4.0.2-aarch64-apple-darwin.tar.gz`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.2/med-linus-ai-med-4.0.2-aarch64-apple-darwin.tar.gz) |
| Linux x86_64 | [`med-linus-ai-med-4.0.2-x86_64-unknown-linux-gnu.tar.gz`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.2/med-linus-ai-med-4.0.2-x86_64-unknown-linux-gnu.tar.gz) |
| Linux arm64 | [`med-linus-ai-med-4.0.2-aarch64-unknown-linux-gnu.tar.gz`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.2/med-linus-ai-med-4.0.2-aarch64-unknown-linux-gnu.tar.gz) |

### Install

**macOS**
```bash
tar xzf linus-ai-med-4.0.2-aarch64-apple-darwin.tar.gz
xattr -d com.apple.quarantine linus-ai-med
codesign --force --deep --sign - linus-ai-med
bash quickstart.sh
```

**Linux**
```bash
tar xzf linus-ai-med-4.0.2-x86_64-unknown-linux-gnu.tar.gz
bash quickstart.sh
```

Admin interface: `http://localhost:9500/admin`

> Never expose port 9500 to the internet — use a reverse proxy with TLS for remote access.

---

## aiMED Extension v4.0.2

Clinical AI assistant for healthcare practices — 8 workflow tabs running against your local aiMED Medical server. PHI never leaves your network.

- **Chart Summary** — live EMR → clinical brief with HEDIS gaps and HCC flags
- **Pre-Charter** — PDF/text → 1-page visit brief with trajectory assessment
- **Inbox Zero** — portal message → triage and draft reply (URGENT / SAME-DAY / ROUTINE)
- **Billing Optimizer** — SOAP note → ICD-10 + CPT + HCC with full MDM scoring
- **Patient Educator** — diagnosis → patient handout in 20 languages
- **Quick Tools** — drug interaction, differential diagnosis, prior auth, referral letters
- **Insurance Verify** — payer portal capture and analysis (30+ payers)
- **SuggestCare** — evidence-based care gaps with ASCVD, CHA₂DS₂-VASc, CKD-EPI risk scores

Requires aiMED Medical Server as backend (port 9500). Uses a separate `LNAM-*` license key.

### Pricing

| Tier | Devices | Price |
|---|---|---|
| **90-Day Access** | 2 | $10 one-time or $10/90d |
| **Extension Only** | 2 | $99 one-time |
| **Solo Practice** | 2 | $299/yr |
| **Small Practice** | 10 | $799/yr |
| **Group Practice** | Unlimited | $1,999/yr |
| **Health System** | Unlimited | $9,999/yr |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#aimed-ext)** — instant license delivery via PayPal checkout

### Download

| Browser | File |
|---|---|
| Chrome | [`aimed-ext-aiMED-chrome-v4.0.2.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.2/aimed-ext-aiMED-chrome-v4.0.2.zip) |
| Edge | [`aimed-ext-aiMED-edge-v4.0.2.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.2/aimed-ext-aiMED-edge-v4.0.2.zip) |
| Brave | [`aimed-ext-aiMED-brave-v4.0.2.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.2/aimed-ext-aiMED-brave-v4.0.2.zip) |
| Opera | [`aimed-ext-aiMED-opera-v4.0.2.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.2/aimed-ext-aiMED-opera-v4.0.2.zip) |
| Firefox | [`aimed-ext-aiMED-firefox-v4.0.2.xpi`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.2/aimed-ext-aiMED-firefox-v4.0.2.xpi) |

### Install

**Chrome / Edge / Brave / Opera:**
1. Unzip the `.zip` file
2. Open `chrome://extensions` → Enable **Developer mode** → **Load unpacked** → select folder

**Firefox:**
1. Open `about:addons` → gear icon → **Install Add-on From File** → select `.xpi`

After install: open extension → enter your `LNAM-*` license key in **Settings → Account**.

---

## LINUS ConnectX

Private P2P career network — no LinkedIn data mining, no algorithmic suppression, no central servers.

- Encrypted peer-to-peer connections between professionals
- Direct messaging, project boards, portfolio hosting
- Runs on your hardware, your data stays yours
- No ads, no feed algorithms, unlimited connections

### Pricing

| Tier | Price |
|---|---|
| **90-Day Access** | $30 one-time or $30/90d |
| **ConnectX Pro** | $149 one-time |
| **Enterprise** | $499/yr |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#connectx)** — instant license delivery via PayPal checkout  
**→ [Download via linus-ai.com/download](https://linus-ai.com/download.html)** — OTP-gated with your license key

---

## LINUS Pulse

Personal AI suite — journal, goals, finances, AI summariser. All offline on your own hardware.

- Journal with AI reflection prompts
- Daily planner and habit tracker
- Local finance tracker and expense insights
- AI summariser and clipboard manager
- 1-device Solo or 5-device Family license

### Pricing

| Tier | Price |
|---|---|
| **90-Day Access** | $10 one-time or $10/90d |
| **Solo** (1 device) | $49 one-time |
| **Family** (5 devices) | $99 one-time |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#pulse)** — instant license delivery via PayPal checkout  
**→ [Download via linus-ai.com/download](https://linus-ai.com/download.html)** — OTP-gated with your license key

---

## LINUS Forge

P2P product studio — build and distribute decentralised apps on the LINUS-AI mesh. No app store gatekeepers.

- Full SDK with visual app builder
- Peer-to-peer distribution (no centralised hosting)
- Offline-first storage
- Built-in LINUS-AI integration hooks

### Pricing

| Tier | Price |
|---|---|
| **90-Day Access** | $40 one-time or $40/90d |
| **Forge Studio** | $199 one-time |
| **Enterprise** | $799/yr |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#forge)** — instant license delivery via PayPal checkout  
**→ [Download via linus-ai.com/download](https://linus-ai.com/download.html)** — OTP-gated with your license key

---

## LINUS Trips

AI travel workspace — plan, source, and manage travel with local AI. Offline-first, no cloud required.

- Itinerary builder with AI suggestions
- Hotel and flight search
- Expense tracking and trip calendar
- Buy once, own forever

### Pricing

| Tier | Price |
|---|---|
| **90-Day Access** | $20 one-time or $20/90d |
| **Trips Pro** | $99 one-time |
| **Enterprise** | $499/yr |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#trips)** — instant license delivery via PayPal checkout  
**→ [Download via linus-ai.com/download](https://linus-ai.com/download.html)** — OTP-gated with your license key

---

## LINUS Reserve

AI hospitality management — reservations, yield optimiser, no-show prediction, POS integration. No per-cover fees.

- Reservation management with yield optimisation
- AI-powered no-show prediction
- POS integration and chat monitor
- AI booking agent for guest interactions
- No per-cover or per-booking fees — flat license

### Pricing

| Tier | Price |
|---|---|
| **90-Day Access** | $40 one-time or $40/90d |
| **Reserve Pro** (single venue) | $199 one-time |
| **Enterprise** (multi-property) | $799/yr |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#reserve)** — instant license delivery via PayPal checkout  
**→ [Download via linus-ai.com/download](https://linus-ai.com/download.html)** — OTP-gated with your license key

---

## LINUS Day

AI daily planner — learns your rhythms, helps you plan, focus, and reflect. Offline. Private.

- Task management with AI scheduling
- Daily briefing and focus coach
- Habit tracker and end-of-day reflection
- Buy once, own forever

### Pricing

| Tier | Price |
|---|---|
| **90-Day Access** | $17 one-time or $17/90d |
| **Day Perpetual** | $99 one-time |

Optional annual updates: +$49/yr

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#day)** — instant license delivery via PayPal checkout  
**→ [Download via linus-ai.com/download](https://linus-ai.com/download.html)** — OTP-gated with your license key

---

## P2P Network

Private mesh infrastructure — encrypted peer-to-peer routing for teams. No central servers, no cloud relay.

- Up to 10 nodes (Pro) or unlimited (Enterprise)
- mDNS auto-discovery, private DNS, NAT traversal
- Encrypted mesh routing between nodes
- Self-hosted, no external dependencies

### Pricing

| Tier | Price |
|---|---|
| **Pro** (10 nodes) | $299 one-time |
| **Enterprise** (unlimited nodes) | $999/yr |

**→ [Buy at linus-ai.com/store](https://linus-ai.com/store/index.html#p2pnet)** — instant license delivery via PayPal checkout  
**→ [Download via linus-ai.com/download](https://linus-ai.com/download.html)** — OTP-gated with your license key

---

## Bundles

| Bundle | Includes | Price | Savings |
|---|---|---|---|
| **aiMED Clinical Bundle** | aiMED Medical (Clinic) + aiMED Extension (Solo 1yr) | $1,439 | Save $359 |
| **LINUS-AI + BizCore Bundle** | LINUS-AI Pro (perpetual) + BizCore Business (perpetual) | $639 | Save $159 |

**→ [Buy bundles at linus-ai.com/store](https://linus-ai.com/store/index.html#bundles)** — instant license delivery via PayPal checkout

---

## License Activation

All products use the same activation flow. After purchase you receive a license key by email (format: `PPPP-TTTT-XXXX-XXXX-XXXX`).

| Product | Activate |
|---|---|
| **LINUS-AI** | `linus-ai --activate LNAI-XXXX-XXXX-XXXX-XXXX` or control panel → Settings → Licence |
| **BizCore** | App menu → License → Enter Key |
| **BizCore Extension** | Extension options → License Key |
| **aiMED Medical** | `POST http://localhost:9500/admin/api/activate` with your `LNMD-*` key |
| **aiMED Extension** | Extension → Settings → Account → Enter License Key (`LNAM-*`) |
| **ConnectX / Pulse / Forge** | App → Settings → Activate License (`LNCX-*` / `LNPA-*` / `LNFG-*`) |
| **Trips / Reserve / Day** | App → Settings → License (`LNTR-*` / `LNRV-*` / `LNDY-*`) |
| **P2P Network** | App → Settings → License (`LNPN-*`) |

**Lost your key?** → [linus-ai.com/reset](https://linus-ai.com/reset.html) — enter your email to resend all keys instantly.

**Transfer to a new machine?**
```bash
linus-ai --deactivate    # on the old machine
linus-ai --activate LNAI-XXXX-XXXX-XXXX-XXXX    # on the new machine
```

---

## Support

| Contact | Purpose |
|---|---|
| [support@linus-ai.com](mailto:support@linus-ai.com) | License delivery, general support (all products) |
| [sales@linus-ai.com](mailto:sales@linus-ai.com) | Enterprise, Health System, custom pricing |
| [linus-ai.com/support](https://linus-ai.com/support.html) | Troubleshooting knowledge base (54 articles) |
| [linus-ai.com/enterprise](https://linus-ai.com/enterprise.html) | Enterprise inquiry form |

**License delivery** is automatic — your key arrives by email within minutes of PayPal payment confirmation. If you don't receive it within 15 minutes, check spam or email [support@linus-ai.com](mailto:support@linus-ai.com).
