# LINUS-BizCore Extension

**AI business assistant in your browser — private, local, zero cloud.**

Version `4.0.0` · Chrome · Edge · Brave · Opera · Firefox

> Part of the **[LINUS-AI Product Suite](https://github.com/miryala3/linus-ai-public#readme)**  
> All downloads and purchase links: [github.com/miryala3/linus-ai-public](https://github.com/miryala3/linus-ai-public#readme)

A browser extension companion for [LINUS-BizCore](../linus-bizcore). Brings LINUS-AI business intelligence directly into QuickBooks, Xero, Stripe, HubSpot, Salesforce, Gmail, and Outlook — powered by your local LINUS-AI server on port 9480.

---

## Features

| Tab | What it does |
|---|---|
| **💬 Chat** | General business AI chat — strategy, analysis, writing |
| **📄 Invoice** | Draft invoices, review billing, write follow-up emails |
| **🤝 CRM** | Customer insights, follow-up drafts, pipeline analysis |
| **✅ Tasks** | Prioritize, break down projects, standup updates |
| **📊 Accounting** | Expense categorization, P&L review, tax deduction checklist |
| **🔍 Page Summary** | Summarize any page — action items, key figures, email draft |

All tabs include an **Analyze Page** button that pulls the current page's content as context for the AI.

---

## Installation

### From Releases (recommended)

Download from **[GitHub Releases — latest](https://github.com/miryala3/linus-bizcore-ext/releases/latest)**:

| Browser | File |
|---|---|
| Chrome | `bizcore-chrome-v4.0.0.zip` |
| Edge | `bizcore-edge-v4.0.0.zip` |
| Brave | `bizcore-brave-v4.0.0.zip` |
| Opera | `bizcore-opera-v4.0.0.zip` |
| Firefox | `bizcore-firefox-v4.0.0.xpi` |

**Chrome / Edge / Brave / Opera:**
1. Unzip the `.zip` file
2. Open `chrome://extensions` (or `edge://extensions`, etc.)
3. Enable **Developer mode** → **Load unpacked** → select the unzipped folder

**Firefox:**
1. Open `about:addons`
2. Click the gear icon → **Install Add-on From File**
3. Select the `.xpi` file

### Verify integrity

```bash
sha256sum -c SHA256SUMS.txt
```

---

## Setup

1. **Start LINUS-AI server** on your machine or LAN (port 9480):
   ```bash
   ./linus-ai-linux-x86_64      # Linux
   # or open LINUS-AI.app       # macOS
   ```

2. **Open extension settings** — click the extension icon → ⚙ Settings

3. **Choose backend:**
   - **LINUS-AI (LAN)** — connects to `http://localhost:9480` (or any LAN node)
   - **Linus AI** — connects to `http://localhost:9480`

4. **Test connection** — click "Test connection" to verify

5. **Scan LAN** — automatically discovers LINUS-AI nodes on your local network

---

## How It Works

```
Browser Extension
  │
  ├── Side Panel (React)
  │     ├── Chat · Invoice · CRM · Tasks · Accounting · Page tabs
  │     └── Reads page content from active tab via content scripts
  │
  ├── Content Scripts
  │     ├── biz-reader.js  — QuickBooks, Xero, Stripe, HubSpot, Salesforce
  │     └── dom-extractor.js  — Gmail, Outlook, general pages
  │
  └── LINUS-AI Server (your machine/LAN)
        POST /infer/stream  → SSE token stream
        GET  /health        → connectivity check
        GET  /models        → available models
```

The extension never contacts external servers. All AI inference runs on your local LINUS-AI server.

---

## Supported Platforms

| App | Content extraction | Context-aware AI |
|---|---|---|
| QuickBooks | ✓ | ✓ |
| Xero | ✓ | ✓ |
| FreshBooks | ✓ | ✓ |
| Stripe Dashboard | ✓ | ✓ |
| HubSpot | ✓ | ✓ |
| Salesforce | ✓ | ✓ |
| Gmail | ✓ (text) | ✓ |
| Outlook | ✓ (text) | ✓ |
| Any webpage | ✓ (Page tab) | ✓ |

---

## Build from Source

**Prerequisites:** Node.js 20+

```bash
npm install

# Development build
npm run build

# Package all 5 browsers
npm run build:ext
# Output: packages/bizcore-{chrome,edge,brave,opera,firefox}-v4.0.0.{zip,xpi}
```

### CI/CD

Tagged pushes (`v*.*.*`) trigger a GitHub Actions release that packages all browsers and publishes them. Build time: ~30 seconds on `ubuntu-22.04`.

---

## Privacy

- Zero telemetry
- No external API calls (all inference is local)
- No account required
- Page content stays on your machine — sent only to your local LINUS-AI server

---

## Purchase

Included free with any **LINUS BizCore** desktop license. If you only want the extension:

| Option | Price | Link |
|---|---|---|
| Extension only | $99 one-time | [Pay $99](https://www.paypal.com/ncp/payment/FLRGDB82RZ86E) |
| BizCore + Extension bundle | $299 one-time | [Pay $299](https://www.paypal.com/ncp/payment/VNFMWHE2UQ9AE) |

After payment, email **support@linus-ai.com** with your order confirmation — your license key will be delivered within 1 business day.

---

## License

Proprietary — © 2026 LINUS-AI. All rights reserved.
Part of the LINUS-AI product suite. See [linus-ai.com](https://linus-ai.com) for licensing.


## Cross-Platform Build System

This module uses the standardized Linus AI `build.sh` pipeline for seamless compilation across environments.

```bash
# Build for your specific target architecture
./build.sh macos-arm64
./build.sh windows-x86_64
./build.sh linux-x86_64
./build.sh web
```

**Features:**
- Automatically maps `macos-arm64` to `aarch64-apple-darwin` for Rust targets.
- Falls back to `npm ci` or `npm install` if `node_modules` is missing.
- Utilizes local `npx tauri build` to prevent global CLI version mismatches.
