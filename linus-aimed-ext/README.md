# aiMED Extension v4.0.0

**Clinical AI for healthcare practices — 8 workflow tools, all running on your local server. No PHI leaves your network.**

[![Version](https://img.shields.io/badge/version-4.0.0-blue)](CHANGELOG)
[![Browsers](https://img.shields.io/badge/browsers-Chrome%20%7C%20Edge%20%7C%20Brave%20%7C%20Opera%20%7C%20Firefox-orange)](README.md)
[![HIPAA](https://img.shields.io/badge/HIPAA-compatible-blue)](README.md)

> Part of the **[LINUS-AI Product Suite](https://github.com/miryala3/linus-ai-public#readme)**  
> Downloads and pricing: [github.com/miryala3/linus-ai-public](https://github.com/miryala3/linus-ai-public#readme)

---

## What does it do?

The aiMED Extension adds eight clinical AI tools directly to your browser. While you're working in your EMR, viewing a lab result, or handling patient messages, the AI is right there — reading the current page with your permission and providing clinical assistance without sending anything to a cloud AI service.

All AI processing runs on LINUS-AI Medical Server installed in your facility. No PHI ever leaves your network.

> **aiMED license holders get LINUS-AI Professional included free.**  
> Email support@linus-ai.com with your aiMED order to claim a LNAI-PRO key.

---

## Download

Go to **[Releases — latest](https://github.com/miryala3/linus-aiMED-ext/releases/latest)** and pick your browser.

| Browser | File |
|---|---|
| Chrome | [`aiMED-chrome-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.0/aiMED-chrome-v4.0.0.zip) |
| Edge | [`aiMED-edge-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.0/aiMED-edge-v4.0.0.zip) |
| Brave | [`aiMED-brave-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.0/aiMED-brave-v4.0.0.zip) |
| Opera | [`aiMED-opera-v4.0.0.zip`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.0/aiMED-opera-v4.0.0.zip) |
| Firefox | [`aiMED-firefox-v4.0.0.xpi`](https://github.com/miryala3/linus-ai-public/releases/download/aimed-ext-v4.0.0/aiMED-firefox-v4.0.0.xpi) |

### Install on Chrome / Edge / Brave / Opera

1. Unzip the `.zip` file
2. Open `chrome://extensions` (or `edge://extensions`, etc.)
3. Enable **Developer mode** → **Load unpacked** → select the unzipped folder

### Install on Firefox

1. Open `about:addons` → gear icon → **Install Add-on From File** → select `.xpi`

---

## Pricing

| Plan | Devices | Price | Link |
|---|---|---|---|
| **Solo Practice** | 2 | $299/yr | [Pay $299](https://www.paypal.com/ncp/payment/59YHJD9W2RYYE) |
| **Small Practice** | 10 | $799/yr | [Pay $799](https://www.paypal.com/ncp/payment/BZPJUT2U5HSMG) |
| **Group Practice** | Unlimited | $1,999/yr | [Pay $1,999](https://www.paypal.com/ncp/payment/NHK2TN4D9YV9S) |
| **Health System** | Unlimited | $9,999/yr | [Pay $9,999](https://www.paypal.com/ncp/payment/CL6363REEN72E) |

Pay via PayPal → email **support@linus-ai.com** with your receipt → receive license key within 1 business day.

**14-day free trial — no key needed to start.**

> **aiMED subscribers also receive LINUS-AI Professional free.** Email us with your aiMED order to claim it.

---

## Setup

### 1. Install LINUS-AI Medical Server

Download from [linus-ai-med](../linus-ai-med/) and run it in your facility. It runs on port 9500 by default.

Alternatively, connect to a standard LINUS-AI server (port 9480) for non-HIPAA workflows.

### 2. Download medical AI models

```bash
# Recommended primary model (4.9 GB, strong clinical reasoning)
linus_ai --model-dir ~/models models   # then download Med42-8B or Med42-70B via the UI
```

### 3. Connect the extension

1. Click the extension icon → **⚙ Settings → LLM Connection**
2. Set endpoint: `http://localhost:9480` (or your server's IP)
3. Select a model and click **Test Connection**

### 4. Enter your license key

Settings → **Account & License** → paste your `LNAM-*` key → Activate

---

## The 8 clinical workflow tools (User features)

| Tool | What it does |
|---|---|
| **Chart Summary** | Reads the current EMR page and produces a clinical brief with HEDIS gap flags and HCC codes highlighted |
| **Pre-Charter** | Paste or upload a patient PDF/note and get a one-page visit summary with an improvement/stable/declining trajectory assessment |
| **Inbox Zero** | Paste a patient portal message and get a triage label (🚨 URGENT / ⚠️ SAME-DAY / 📋 ROUTINE) plus a drafted reply with safety-net language |
| **Billing Optimizer** | Paste a SOAP note and get ICD-10 codes, CPT codes, HCC flags, and MDM scoring with audit-defensible reasoning |
| **Patient Educator** | Enter a diagnosis and get a patient-ready handout in any of 20 languages, with teach-back questions and "call if..." thresholds |
| **Quick Tools** | Drug interaction checker, differential diagnosis, prior authorisation drafts, specialist referral letters |
| **Insurance Verify** | Captures the current insurance/payer portal page and analyses it — works with 30+ payers |
| **SuggestCare** | Identifies evidence-based care gaps with ASCVD, CHA₂DS₂-VASc, and CKD-EPI risk scores for the current patient context |

---

## EMR and payer compatibility

The extension reads content from these platforms automatically when they are open:

| System | Type |
|---|---|
| Epic | EMR |
| Athenahealth | EMR |
| Cerner (Oracle Health) | EMR |
| Allscripts | EMR |
| eClinicalWorks | EMR |
| Practice Fusion | EMR |
| NextGen | EMR |
| Kareo | EMR |
| AdvancedMD | EMR |
| 30+ insurance payer portals | Insurance |

---

## Privacy and compliance

- All AI runs on your LINUS-AI Medical Server — no PHI sent to cloud AI
- No internet connection required for AI workflows after model download
- Session history is cleared when the browser restarts
- License validation sends only a hashed device identifier — no PHI, no personal data
- Compatible with HIPAA local-processing workflows

> **Disclaimer:** aiMED provides clinical decision support only. All AI outputs must be reviewed by a licensed clinician before any clinical or billing use.

---

## Account management

| Action | Where |
|---|---|
| Sign in with license key | Settings → Account & License |
| See which devices are using your license | Settings → Account → Active Devices |
| Remove an old device to free a seat | Settings → Account → Remove Device |
| Check trial status | Settings → Account |

---

## Troubleshooting

| Problem | Solution |
|---|---|
| "LLM Offline" shown | Start LINUS-AI and check `http://localhost:9480` loads |
| Key not accepted | Check your key starts with `LNAM-` and matches the format exactly |
| Machine limit reached | Remove an old device in Settings → Account |
| Extension not reading the page | Refresh the page, then re-open the extension panel |
| LAN server not found by Scan | Make sure LINUS-AI is running with `--host 0.0.0.0` on the remote machine |

---

## Version history

### v4.0.0
- Replaced Supabase account-based auth with offline `LNAM-*` license keys (consistent with all other LINUS-AI products)
- Added LINUS-AI Professional bundle — aiMED license holders now receive LINUS-AI Pro free
- React 18 + Vite 5 frontend with Tailwind CSS dark medical theme
- Rust WASM module for device fingerprinting and license validation
- 14-day offline trial with countdown banner

### v3.0.0 — 2026-02-28
- Initial public release with Supabase account-based auth
- 8 clinical workflow tabs
- Stripe subscription billing

---

## License

Proprietary — © 2026 LINUS-AI. All rights reserved.  
See [linus-ai.com](https://linus-ai.com) for licensing.
