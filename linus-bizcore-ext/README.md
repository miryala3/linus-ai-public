# LINUS-BizCore Extension v4.0.0

**AI business assistant in your browser — works inside the tools you already use.**

Version `4.0.0` · Chrome · Edge · Brave · Opera · Firefox

> Part of the **[LINUS-AI Product Suite](https://github.com/miryala3/linus-ai-public#readme)**  
> Downloads and pricing: [github.com/miryala3/linus-ai-public](https://github.com/miryala3/linus-ai-public#readme)

The BizCore Extension brings private AI directly into QuickBooks, Xero, Stripe, HubSpot, Salesforce, Gmail, and Outlook — powered entirely by your local LINUS-AI server (port 9480). Nothing is sent to outside AI services.

---

## What does it do?

Open the extension panel while you're inside any supported business app and the AI automatically reads the page you're on. Ask it questions, get summaries, draft emails, or analyse data — all from within the tools you're already using.

---

## Download

Go to **[Releases — v4.0.0](https://github.com/miryala3/linus-bizcore-ext/releases/latest)** and pick your browser.

| Browser | File |
|---|---|
| Chrome | [`bizcore-chrome-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-chrome-v4.0.0.zip) |
| Edge | [`bizcore-edge-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-edge-v4.0.0.zip) |
| Brave | [`bizcore-brave-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-brave-v4.0.0.zip) |
| Opera | [`bizcore-opera-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-opera-v4.0.0.zip) |
| Firefox | [`bizcore-firefox-v4.0.0.xpi`](https://github.com/miryala3/linus-ai-public/releases/download/bizcore-ext-v4.0.0/bizcore-firefox-v4.0.0.xpi) |

### Install on Chrome / Edge / Brave / Opera

1. Unzip the `.zip` file
2. Open `chrome://extensions` (or `edge://extensions`, etc.)
3. Enable **Developer mode** (top right toggle)
4. Click **Load unpacked** → select the unzipped folder

### Install on Firefox

1. Open `about:addons`
2. Click the gear icon → **Install Add-on From File**
3. Select the `.xpi` file

---

## Pricing

| Option | Price | Link |
|---|---|---|
| **Free with any BizCore desktop license** | Included | See [BizCore](../linus-bizcore/) |
| Extension only (no desktop app needed) | $99 one-time | [Pay $99](https://www.paypal.com/ncp/payment/FLRGDB82RZ86E) |
| BizCore + Extension bundle | $299 one-time | [Pay $299](https://www.paypal.com/ncp/payment/VNFMWHE2UQ9AE) |

Pay via PayPal → email **support@linus-ai.com** with your receipt → receive license key within 1 business day.

---

## Setup

1. **Start LINUS-AI** on your machine or LAN (port 9480)
2. Click the extension icon → **⚙ Settings**
3. Set your server address (default: `http://localhost:9480`)
4. Click **Test Connection** to confirm it's working
5. Optionally: click **Scan Network** to find LINUS-AI running on other machines on your LAN

---

## What you can do (User features)

| Tab | What it does |
|---|---|
| **Chat** | General business AI — strategy, analysis, writing, research |
| **Invoice** | Draft invoices, review billing, write payment follow-up emails |
| **CRM** | Customer insights, follow-up drafts, pipeline review |
| **Tasks** | Prioritise and break down projects, write standup updates |
| **Accounting** | Categorise expenses, review P&L, build a tax deduction checklist |
| **Page Summary** | Summarise any open page into action items, key numbers, or a draft email |

Every tab has an **Analyse Page** button that pulls the content from the page you're currently on and uses it as context for the AI.

## Works with these apps

| App | What it reads | AI assistance |
|---|---|---|
| QuickBooks | Invoices, accounts, transactions | ✓ |
| Xero | Same | ✓ |
| FreshBooks | Same | ✓ |
| Stripe Dashboard | Payments, customers | ✓ |
| HubSpot | Contacts, deals, pipelines | ✓ |
| Salesforce | Accounts, opportunities | ✓ |
| Gmail | Email text | ✓ |
| Outlook | Email text | ✓ |
| Any webpage | Page text | ✓ (via Page Summary tab) |

---

## Privacy

- The extension never contacts external AI servers
- All AI processing happens on your own LINUS-AI server
- Page content is only sent to your local machine — never stored externally
- No account required
- No telemetry

---

## For developers — build from source

```bash
npm install
npm run build              # development build → dist/
npm run build:ext          # package all 5 browsers → packages/
# Output: packages/bizcore-{chrome,edge,brave,opera,firefox}-v4.0.0.{zip,xpi}
```

Tagged pushes (`v*.*.*`) trigger a GitHub Actions release that packages all browsers automatically. Build time: ~30 seconds.

---

## License

Proprietary — © 2026 LINUS-AI. All rights reserved.  
See [linus-ai.com](https://linus-ai.com) for licensing details.
