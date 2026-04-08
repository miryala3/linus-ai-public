# aiMED v3 — Medical AI Assistant

> Private, local AI back-office team for healthcare practices.
> **100% local AI. No PHI leaves your network.**

[![Version](https://img.shields.io/badge/version-4.0.0-blue)](CHANGELOG)
[![Stack](https://img.shields.io/badge/stack-React%20%7C%20Tailwind%20%7C%20Rust%2FWASM-purple)](README.md)
[![Browsers](https://img.shields.io/badge/browsers-Edge%20%7C%20Chrome%20%7C%20Firefox%20%7C%20Brave%20%7C%20Opera-orange)](README.md)

> Part of the **[LINUS-AI Product Suite](https://github.com/miryala3/linus-ai-public#readme)**  
> All downloads and purchase links: [github.com/miryala3/linus-ai-public](https://github.com/miryala3/linus-ai-public#readme)

---

## Tech Stack

| Layer | Technology |
|---|---|
| **Frontend** | React 18 + Tailwind CSS (dark medical theme) |
| **Bundler** | Vite 5 (multi-entry: sidepanel / options / popup) |
| **AI Engine** | Linus AI (local only — no cloud AI) |
| **Logic Protection** | Rust → WebAssembly (`wasm-bindgen`) |
| **Auth / Payments** | Supabase (Auth + PostgreSQL + RLS) + Stripe |
| **Browser Support** | MV3: Edge, Chrome, Brave, Opera | MV2: Firefox |

---

## Clinical Workflows (8 Tabs)

| Tab | Workflow | AI Capability |
|---|---|---|
| 🏥 Chart Summary | Live EMR → clinical brief | HEDIS gaps, HCC flags, MDM awareness |
| 📄 Pre-Charter | PDF/text → 1-page visit brief | Trajectory (IMPROVING/STABLE/DECLINING) |
| 💬 Inbox Zero | Portal message → triage + draft | 🚨URGENT/⚠️SAME-DAY/📋ROUTINE with safety-net phrases |
| 💰 Billing Optimizer | SOAP note → ICD-10 + CPT + HCC | Full MDM scoring, ZPIC/RAC audit defensibility |
| 📖 Patient Educator | Diagnosis → patient handout | 20 languages, teach-back questions, "call if" thresholds |
| 🔧 Quick Tools | Drug Interaction, Diff Dx, Prior Auth, Referral | Specialist-grade clinical reasoning |
| 🏛️ Insurance Verify | Payer portal capture + AI analysis | 30+ payers, live benefit data extraction |
| 💡 SuggestCare | Evidence-based care gaps | ASCVD, CHA₂DS₂-VASc, CKD-EPI risk scores |

---

## Licensing (Account-Based)

No license keys — sign in with your account.

| Tier | Price | Max Devices |
|---|---|---|
| **Solo Practice** | $299/yr | 2 |
| **Small Practice** | $799/yr | 10 |
| **Group Practice** | $1,999/yr | Unlimited |

14-day free trial — no credit card required.

**Buy now (annual subscription via Stripe):**

| Tier | Link |
|---|---|
| Solo Practice — $299/yr | [Subscribe](https://buy.stripe.com/aiMED-solo) |
| Small Practice — $799/yr | [Subscribe](https://buy.stripe.com/aiMED-small) |
| Group Practice — $1,999/yr | [Subscribe](https://buy.stripe.com/aiMED-group) |

**Flow:**
1. Subscribe above (Stripe Checkout)
2. Sign in with the email used at checkout
3. Open extension → Options → Sign In
4. Extension verifies your license automatically

**Copy protection:** Rust WASM handles fingerprinting and JWT claim validation. Machine limits enforced server-side via Supabase Row Level Security. Supabase manages token refresh automatically.

---

## Prerequisites

### 1. Install Linus AI
Download from [linus.com](https://linus.com).

### 2. Download Medical AI Models
```bash
# Primary — Best medical reasoning (4.9 GB, USMLE 82.9%)
linus pull m42labs/med42-v2:8b-q4_K_M

# Secondary — Patient education (4.1 GB)
linus pull biomistral:7b-q4_K_M
```

### 3. Start Linus AI
```bash
LINUS_NUM_PARALLEL=1 LINUS_MAX_LOADED_MODELS=1 linus serve

# Multi-machine LAN setup
LINUS_HOST=0.0.0.0:9480 LINUS_NUM_PARALLEL=1 linus serve
```

---

## Development Setup

### Prerequisites
- Node.js 18+
- Rust + cargo (`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`)
- wasm-pack (`cargo install wasm-pack`)

### Install
```bash
cd aiMED-v3
cp .env.example .env
# Edit .env — add your Supabase URL and anon key
npm install
```

### Build WASM (once, or when wasm/src/lib.rs changes)
```bash
npm run wasm:build
# Output: wasm/pkg/
```

### Development build
```bash
npm run build
# Output: dist/
```

### Full build + browser packages
```bash
bash scripts/build.sh
# Output: dist/ + packages/
```

---

## Load Extension

### Edge / Chrome / Brave / Opera
1. Open `edge://extensions` (or `chrome://extensions`)
2. Enable **Developer mode**
3. Click **Load unpacked** → select `dist/`

### Firefox
1. Open `about:debugging` → This Firefox
2. Click **Load Temporary Add-on**
3. Select `dist/manifest-firefox.json`

---

## Configuration

### Step 1 — Connect Linus AI
1. Open extension → ⚙️ Settings → **LLM Connection**
2. Set endpoint: `http://localhost:9480`
3. Set model: `m42labs/med42-v2:8b-q4_K_M`
4. Click **Test Connection** → ✅ Connected!

### Step 2 — Sign In
1. Settings → **Account & License** (or sign in from the side panel)
2. Enter email + password
3. License tier and device count appear automatically

### Step 3 — Scan Your Network (optional)
Settings → LLM Connection → **🔍 Scan Network**
Discovers Linus AI instances on your LAN and recommends models based on total available RAM.

---

## Supabase Setup (operators only)

See [ADMIN.md](ADMIN.md) for full setup instructions.

Quick overview:
```bash
# Install Supabase CLI
npm install -g supabase

# Login and link project
supabase login
supabase link --project-ref YOUR_PROJECT_ID

# Apply database schema
supabase db push

# Deploy Edge Functions
supabase functions deploy stripe-checkout
supabase functions deploy stripe-webhook

# Set Edge Function secrets
supabase secrets set STRIPE_SECRET_KEY=sk_live_...
supabase secrets set STRIPE_WEBHOOK_SECRET=whsec_...
supabase secrets set STRIPE_PRICE_SOLO=price_...
supabase secrets set STRIPE_PRICE_PRACTICE=price_...
supabase secrets set STRIPE_PRICE_GROUP=price_...
supabase secrets set SUPABASE_SERVICE_ROLE_KEY=eyJ...
supabase secrets set SITE_URL=https://yourdomain.com
```

---

## Project Structure

```
aiMED-v3/
├── src/
│   ├── components/              Shared React UI components
│   │   ├── Button.tsx
│   │   ├── StreamOutput.tsx
│   │   ├── ModelStatus.tsx
│   │   └── LicenseGate.tsx     Auth gate — wraps app
│   ├── hooks/
│   │   ├── useLLM.ts            Linus AI streaming
│   │   ├── useLicense.ts        Supabase license check
│   │   └── useEMRData.ts        EMR capture via service worker
│   ├── utils/
│   │   ├── supabase.ts          Supabase client (chrome.storage adapter)
│   │   ├── license.ts           License gate + WASM bridge
│   │   ├── hardware-detect.ts   LAN Linus AI scanner
│   │   ├── prompts.ts           Clinical AI prompt library
│   │   ├── medical-models.ts    Model catalog
│   │   ├── emr-versions.ts      EMR detection
│   │   └── insurance-portals.ts Payer DB
│   ├── sidepanel/               Main panel (8 workflow tabs)
│   ├── options/                 Settings (Account, LLM, EMR, About)
│   └── popup/                   Quick-launch toolbar popup
├── public/
│   ├── manifest.json            MV3 (Edge/Chrome/Brave/Opera)
│   ├── manifest-firefox.json    MV2 (Firefox)
│   ├── background/              Service workers
│   ├── content/                 EMR + insurance content scripts
│   └── icons/
├── wasm/                        Rust WASM module
│   ├── Cargo.toml
│   └── src/lib.rs               Fingerprinting + JWT validation
├── supabase/
│   ├── migrations/001_initial.sql
│   └── functions/
│       ├── stripe-checkout/     Creates Stripe session
│       └── stripe-webhook/      Handles payment → creates license
├── scripts/
│   ├── build.sh                 Full build (WASM + Vite + packages)
│   └── build-browsers.sh        Browser packaging
├── package.json
├── vite.config.ts
├── tailwind.config.ts
└── ADMIN.md
```

---

## Privacy & HIPAA

- ✅ All AI processing runs locally via Linus AI — no PHI sent to cloud AI
- ✅ No internet required for AI workflows after model download
- ✅ Session history is ephemeral — cleared on browser restart
- ✅ License validation only sends a hashed device fingerprint
- ✅ Supabase handles auth via standard OAuth2 tokens (no custom key management)
- ✅ Compatible with local-processing HIPAA workflows

**Disclaimer:** aiMED provides clinical decision support only. All AI outputs must be reviewed by a licensed clinician before clinical or billing use.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| "LLM Offline" status | Run `linus serve` and check `http://localhost:9480` |
| Sign in fails | Verify Supabase URL and anon key in `.env` |
| No active license | Purchase at your website; check Supabase `licenses` table |
| Machine limit reached | Remove an old device in Settings → Account |
| WASM not loading | Run `npm run wasm:build` first |
| LAN scan finds nothing | Ensure `LINUS_HOST=0.0.0.0:9480` on the remote machine |
| Vite build errors | Run `npm install` to restore dependencies |

---

## Version History

### v4.0.0 — 2026-02-28
- **Stack**: React 18 + Tailwind CSS replacing vanilla HTML/CSS/JS
- **Auth**: Supabase account-based auth replacing RSA key entry
- **Backend**: Supabase Edge Functions + PostgreSQL replacing Node.js + SQLite
- **Protection**: Rust WASM module for fingerprinting + JWT validation
- **Build**: Vite 5 multi-entry bundler with TypeScript
- **Payments**: Stripe Checkout via Supabase Edge Functions

### v2.0.0 — 2026-02-27
- One-time purchase licensing with RSA-JWT copy protection
- Node.js + Stripe + SQLite license server
- LAN hardware scanner, SuggestCare, Insurance workflows
- Cross-browser build (Firefox MV2 support)

### v1.0.0 — Initial Release
- 5 core clinical workflows, Epic/eCW/PCC EMR support
- Local Linus AI streaming, dark medical UI


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
