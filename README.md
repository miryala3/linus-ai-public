# LINUS-AI Product Suite

**Private AI, business tools, and clinical AI — all running on your hardware. No cloud. No subscriptions required.**

[![License](https://img.shields.io/badge/license-Proprietary-red)]()
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey)]()

---

## Products

| Product | Description | Platform | Latest | Price from |
|---|---|---|---|---|
| **[LINUS-AI](#linus-ai-v400)** | Private distributed AI platform | macOS · Linux · Windows | v4.0.0 | Free |
| **[LINUS BizCore](#linus-bizcore-v400)** | Local-first business OS | macOS · Linux | v4.0.0 | $199 |
| **[BizCore Extension](#linus-bizcore-extension-v400)** | Browser AI for business apps | Chrome · Edge · Firefox | v4.0.0 | Free w/ BizCore |
| **[LINUS-AI Medical](#linus-ai-medical-server-v400)** | HIPAA-compliant AI server | macOS · Linux | v4.0.0 | $1,499 |
| **[aiMED Extension](#aimed-extension-v400)** | Clinical AI for healthcare practices | Chrome · Edge · Firefox | v4.0.0 | $299/yr |

**Purchase flow (all products):**  
Pay via PayPal → email **support@linus-ai.com** with your order confirmation → receive license key within 1 business day → enter key in product.

---

## LINUS-AI v4.0.0

Private AI that runs entirely on your hardware — no cloud, no telemetry, no Python required.

- Single Rust binary with bundled inference engine (Metal on Apple Silicon, CUDA on NVIDIA, CPU fallback)
- Web control panel at `http://127.0.0.1:9480/app`
- Mesh networking — auto-discover LAN nodes, distribute inference across machines
- Full OpenAI-compatible API (`/v1/chat/completions`, `/v1/models`, `/v1/embeddings`)
- Agentic workflows — multi-step ReAct loop with MCP tool use
- HIPAA/compliance engine — PII detection, role profiles, HMAC-chained audit logs
- Blockchain audit ledger — tamper-evident, Ed25519-signed per-request trail (Team+)
- 30-day free trial — full Professional features on first launch

### Pricing

| Tier | Price | Model cap | Profiles |
|---|---|---|---|
| **Community** | Free forever | 5B params | 6 |
| **Trial** | Free (30 days) | 70B params | 14 |
| **Professional** | $499 one-time | 70B params | 14 |
| **Team** (5 seats) | $1,499 one-time | 70B params | 14 |
| **Enterprise** (unlimited seats) | $7,999/yr | Unlimited | Unlimited |

| Buy | Link |
|---|---|
| Support Community — $39 donation | [Pay $39](https://www.paypal.com/ncp/payment/CBRE6DSZFP3HU) |
| Professional — $499 | [Pay $499](https://www.paypal.com/ncp/payment/NMFSELLNG7X7U) |
| Team — $1,499 | [Pay $1,499](https://www.paypal.com/ncp/payment/RRHAWGNKDQL5A) |
| Enterprise — $7,999/yr | [Pay $7,999](https://www.paypal.com/ncp/payment/Z5J9RLR3YT6RA) |

### Download

| Platform | File | Size |
|---|---|---|
| macOS arm64 (Apple Silicon) | [`linus-ai-4.0.0-macos-arm64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.0/linus-ai-4.0.0-macos-arm64) | ~39 MB |
| macOS x86_64 (Intel) | [`linus-ai-4.0.0-macos-x86_64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.0/linus-ai-4.0.0-macos-x86_64) | ~47 MB |
| macOS Universal | [`linus-ai-4.0.0-macos-universal`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.0/linus-ai-4.0.0-macos-universal) | ~86 MB |
| Linux x86_64 | [`linus-ai-4.0.0-linux-x86_64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.0/linus-ai-4.0.0-linux-x86_64) | ~48 MB |
| Linux arm64 | [`linus-ai-4.0.0-linux-arm64`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.0/linus-ai-4.0.0-linux-arm64) | ~37 MB |
| Windows x86_64 | [`linus-ai-4.0.0-windows-x86_64.exe`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.0/linus-ai-4.0.0-windows-x86_64.exe) | ~46 MB |

Verify with [`SHA256SUMS.txt`](https://github.com/miryala3/linus-ai-public/releases/download/v4.0.0/SHA256SUMS.txt).

### Install

**macOS**
```bash
chmod +x linus-ai-4.0.0-macos-arm64
xattr -d com.apple.quarantine linus-ai-4.0.0-macos-arm64
codesign --force --deep --sign - linus-ai-4.0.0-macos-arm64
./linus-ai-4.0.0-macos-arm64
```
> If still blocked: **System Settings → Privacy & Security → Open Anyway**

**Linux**
```bash
sudo apt-get install -y libwebkit2gtk-4.1-0 libgtk-3-0 libayatana-appindicator3-1 librsvg2-2
chmod +x linus-ai-4.0.0-linux-x86_64
./linus-ai-4.0.0-linux-x86_64
```

**Windows** — Download and run the `.exe`. Click "More info → Run anyway" if SmartScreen appears.

### First launch

Control panel opens at **http://127.0.0.1:9480/app**  
Go to **Models → Browse → Download** to get your first model.  
Community tier is free and starts immediately — no key needed.

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
- 14-day free trial — full Business-tier features on first launch

### Pricing

| Tier | Price | Modules | AI Assistant | Users |
|---|---|---|---|---|
| **Starter** | $199 one-time | Core 5 modules | Read-only | 1 |
| **Business** | $299 one-time | All 8 modules | Full | 3 |
| **Unlimited** | $599 one-time | All 8 modules | Full | Unlimited |

| Buy | Link |
|---|---|
| Starter — $199 | [Pay $199](https://www.paypal.com/ncp/payment/RY263RA748ZWY) |
| Business — $299 | [Pay $299](https://www.paypal.com/ncp/payment/VNFMWHE2UQ9AE) |
| Unlimited — $599 | [Pay $599](https://www.paypal.com/ncp/payment/57ZWKLYLZ6B3W) |

### Download

| Platform | File |
|---|---|
| macOS arm64 (Apple Silicon) | [`LINUS-BizCore_4.0.0_aarch64.dmg`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-v4.0.0/LINUS-BizCore_4.0.0_aarch64.dmg) |
| Linux x86_64 (deb) | [`LINUS-BizCore_4.0.0_amd64.deb`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-v4.0.0/LINUS-BizCore_4.0.0_amd64.deb) |
| Linux x86_64 (AppImage) | [`LINUS-BizCore_4.0.0_amd64.AppImage`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-v4.0.0/LINUS-BizCore_4.0.0_amd64.AppImage) |

### Install

**macOS**
```bash
xattr -d com.apple.quarantine LINUS-BizCore_4.0.0_aarch64.dmg
```
Then double-click the DMG, drag BizCore to Applications, right-click → Open on first launch.

**Linux (deb)**
```bash
sudo apt-get install -y libwebkit2gtk-4.1-0 libgtk-3-0 libayatana-appindicator3-1 librsvg2-2
sudo dpkg -i LINUS-BizCore_4.0.0_amd64.deb
```

**Linux (AppImage)**
```bash
chmod +x LINUS-BizCore_4.0.0_amd64.AppImage
./LINUS-BizCore_4.0.0_amd64.AppImage
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

Requires LINUS-AI (port 9480) or BizCore running on your machine or LAN. One License included free with any BizCore license.

### Pricing

| Option | Price | Link |
|---|---|---|
| Included with any BizCore license | Free | See BizCore above |
| Extension only | $99 one-time | [Pay $99](https://www.paypal.com/ncp/payment/FLRGDB82RZ86E) |

### Download

| Browser | File |
|---|---|
| Chrome | [`bizcore-chrome-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-chrome-v4.0.0.zip) |
| Edge | [`bizcore-edge-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-edge-v4.0.0.zip) |
| Brave | [`bizcore-brave-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-brave-v4.0.0.zip) |
| Opera | [`bizcore-opera-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-opera-v4.0.0.zip) |
| Firefox | [`bizcore-firefox-v4.0.0.xpi`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-firefox-v4.0.0.xpi) |

### Install

**Chrome / Edge / Brave / Opera:**
1. Unzip the `.zip` file
2. Open `chrome://extensions` (or `edge://extensions`, `brave://extensions`, `opera://extensions`)
3. Enable **Developer mode** → **Load unpacked** → select the unzipped folder

**Firefox:**
1. Open `about:addons` → gear icon → **Install Add-on From File**
2. Select the `.xpi` file

---

## LINUS-AI Medical Server v4.0.0

HIPAA-compliant private AI server for hospitals, clinics, and healthcare networks. All inference on-premise — PHI never leaves your infrastructure.

- Role-scoped clinical AI — physician, nurse, radiologist, pharmacist, and more
- PHI detection and audit logging — append-only JSONL, daily rotation
- Supports Med42, Meditron, BioMistral, ClinicalCamel (GGUF format)
- Single binary — no Python, no pip, no cloud dependencies
- 30-day free evaluation — full access before purchase

### Pricing

| Tier | Concurrent users | Price |
|---|---|---|
| **Clinic** | 25 | $1,499 one-time |
| **Hospital** | 500 | $9,999 one-time |
| **Health System** | Unlimited | Contact sales |

| Buy | Link |
|---|---|
| Clinic — $1,499 | [Pay $1,499](https://www.paypal.com/ncp/payment/AK3Q7XPYMMY3S) |
| Hospital — $9,999 | [Pay $9,999](https://www.paypal.com/ncp/payment/DAJ5PCGUVGHNW) |
| Health System — $9,999 | [Pay $99,999](https://www.paypal.com/ncp/payment/T6TA8NZTNLZ7S) |

### Download

| Platform | File |
|---|---|
| macOS arm64 (Apple Silicon) | [`linus-ai-med-4.0.0-aarch64-apple-darwin.tar.gz`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.0/linus-ai-med-4.0.0-aarch64-apple-darwin.tar.gz) |
| Linux x86_64 | [`linus-ai-med-4.0.0-x86_64-unknown-linux-gnu.tar.gz`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.0/linus-ai-med-4.0.0-x86_64-unknown-linux-gnu.tar.gz) |
| Linux arm64 | [`linus-ai-med-4.0.0-aarch64-unknown-linux-gnu.tar.gz`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.0/linus-ai-med-4.0.0-aarch64-unknown-linux-gnu.tar.gz) |

### Install

**macOS**
```bash
tar xzf linus-ai-med-4.0.0-aarch64-apple-darwin.tar.gz
xattr -d com.apple.quarantine linus-ai-med
codesign --force --deep --sign - linus-ai-med
bash quickstart.sh
```

**Linux**
```bash
tar xzf linus-ai-med-4.0.0-x86_64-unknown-linux-gnu.tar.gz
bash quickstart.sh
```

Admin interface: `http://localhost:9500/admin`

> Never expose port 9500 to the internet — use a reverse proxy with TLS for remote access.

---

## aiMED Extension v4.0.0

Clinical AI assistant for healthcare practices — 8 workflow tabs running against your local LINUS-AI Medical server. PHI never leaves your network.

- **Chart Summary** — live EMR → clinical brief with HEDIS gaps and HCC flags
- **Pre-Charter** — PDF/text → 1-page visit brief with trajectory assessment
- **Inbox Zero** — portal message → triage and draft reply (URGENT / SAME-DAY / ROUTINE)
- **Billing Optimizer** — SOAP note → ICD-10 + CPT + HCC with full MDM scoring
- **Patient Educator** — diagnosis → patient handout in 20 languages
- **Quick Tools** — drug interaction, differential diagnosis, prior auth, referral letters
- **Insurance Verify** — payer portal capture and analysis (30+ payers)
- **SuggestCare** — evidence-based care gaps with ASCVD, CHA₂DS₂-VASc, CKD-EPI risk scores
- 14-day free trial — no key required to start

### Pricing

| Tier | Devices | Price |
|---|---|---|
| **Solo Practice** | 2 | $299/yr |
| **Small Practice** | 10 | $799/yr |
| **Group Practice** | Unlimited | $1,999/yr |

| Buy | Link |
|---|---|
| Solo Practice — $299/yr | [Pay $299](https://www.paypal.com/ncp/payment/59YHJD9W2RYYE) |
| Small Practice — $799/yr | [Pay $799](https://www.paypal.com/ncp/payment/BZPJUT2U5HSMG) |
| Group Practice — $1,999/yr | [Pay $1,999](https://www.paypal.com/ncp/payment/NHK2TN4D9YV9S) |

### Download

| Browser | File |
|---|---|
| Chrome | [`aiMED-chrome-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.0/aiMED-chrome-v4.0.0.zip) |
| Edge | [`aiMED-edge-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.0/aiMED-edge-v4.0.0.zip) |
| Brave | [`aiMED-brave-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.0/aiMED-brave-v4.0.0.zip) |
| Opera | [`aiMED-opera-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.0/aiMED-opera-v4.0.0.zip) |
| Firefox | [`aiMED-firefox-v4.0.0.xpi`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.0/aiMED-firefox-v4.0.0.xpi) |

### Install

**Chrome / Edge / Brave / Opera:**
1. Unzip the `.zip` file
2. Open `chrome://extensions` → Enable **Developer mode** → **Load unpacked** → select folder

**Firefox:**
1. Open `about:addons` → gear icon → **Install Add-on From File** → select `.xpi`

After install: open extension → enter your license key in **Settings → Account**.

---

## All Purchase Links

| Product | Tier | Price | Link |
|---|---|---|---|
| LINUS-AI | Community — donate | $39 | [Pay $39](https://www.paypal.com/ncp/payment/CBRE6DSZFP3HU) |
| LINUS-AI | Professional | $499 one-time | [Pay $499](https://www.paypal.com/ncp/payment/NMFSELLNG7X7U) |
| LINUS-AI | Team (5 seats) | $1,499 one-time | [Pay $1,499](https://www.paypal.com/ncp/payment/RRHAWGNKDQL5A) |
| LINUS-AI | Enterprise (unlimited) | $7,999/yr | [Pay $7,999](https://www.paypal.com/ncp/payment/Z5J9RLR3YT6RA) |
| BizCore Desktop | Starter | $199 one-time | [Pay $199](https://www.paypal.com/ncp/payment/RY263RA748ZWY) |
| BizCore Desktop | Business | $299 one-time | [Pay $299](https://www.paypal.com/ncp/payment/VNFMWHE2UQ9AE) |
| BizCore Desktop | Unlimited | $599 one-time | [Pay $599](https://www.paypal.com/ncp/payment/57ZWKLYLZ6B3W) |
| BizCore Extension | Extension-only | $99 one-time | [Pay $99](https://www.paypal.com/ncp/payment/FLRGDB82RZ86E) |
| LINUS-AI Medical | Clinic (25 users) | $1,499 one-time | [Pay $1,499](https://www.paypal.com/ncp/payment/AK3Q7XPYMMY3S) |
| LINUS-AI Medical | Hospital (500 users) | $9,999 one-time | [Pay $9,999](https://www.paypal.com/ncp/payment/DAJ5PCGUVGHNW) |
| LINUS-AI Medical | Health System (Unlimited users) | $99,999 one-time | [Pay $99,999](https://www.paypal.com/ncp/payment/T6TA8NZTNLZ7S) |
| aiMED Extension | Solo Practice | $299/yr | [Pay $299](https://www.paypal.com/ncp/payment/59YHJD9W2RYYE) |
| aiMED Extension | Small Practice | $799/yr | [Pay $799](https://www.paypal.com/ncp/payment/BZPJUT2U5HSMG) |
| aiMED Extension | Group Practice | $1,999/yr | [Pay $1,999](https://www.paypal.com/ncp/payment/NHK2TN4D9YV9S) |
| aiMED Extension | Health System | $9,999/yr | [Pay $9,999](https://www.paypal.com/ncp/payment/CL6363REEN72E) |
| Local AI Software | Local AI software | Contact sales | [sales@linus-ai.com](mailto:sales@linus-ai.com) |

---

## Support

| Contact | Purpose |
|---|---|
| [support@linus-ai.com](mailto:support@linus-ai.com) | License delivery, general support (all products) |
| [sales@linus-ai.com](mailto:sales@linus-ai.com) | Enterprise, Health System, Medical Enterprise pricing |

**License delivery:** within 1 business day after payment confirmation email to support@linus-ai.com.

After receiving your key — activate in the product:
- **LINUS-AI:** Control panel → Settings → Licence → paste key → Activate
- **BizCore:** App menu → License → Enter Key
- **BizCore Extension:** Extension options → License Key
- **LINUS-AI Medical:** `POST http://localhost:9500/admin/api/activate` with your key
- **aiMED Extension:** Extension → Settings → Account → Enter License Key
