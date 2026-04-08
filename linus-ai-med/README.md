# LINUS-AI Medical v4.0.0

**HIPAA-ready AI for healthcare — all patient data stays on your servers. No cloud. No PHI risk.**

[![License](https://img.shields.io/badge/license-Proprietary-red)](LICENSE-COMMERCIAL.md)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey)]()
[![Version](https://img.shields.io/badge/version-4.0.0-green)]()
[![HIPAA](https://img.shields.io/badge/HIPAA-ready-blue)]()

> Part of the **[LINUS-AI Product Suite](https://github.com/miryala3/linus-ai-public#readme)**  
> Downloads and pricing: [github.com/miryala3/linus-ai-public](https://github.com/miryala3/linus-ai-public#readme)

---

## What does it do?

LINUS-AI Medical is a server that runs medical AI models inside your own facility. Physicians, nurses, radiologists, pharmacists, and other clinical staff can query AI through any browser — but the AI itself never connects to the internet. Patient data never leaves your network.

It ships as a single binary. No Python runtime, no cloud subscriptions, no vendor data access.

---

## Download

Go to **[Releases — latest](https://github.com/miryala3/linus-aiMED/releases/latest)** and pick your platform.

| Platform | File |
|---|---|
| Mac (Apple Silicon) | [`linus-ai-med-4.0.0-aarch64-apple-darwin.tar.gz`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.0/linus-ai-med-4.0.0-aarch64-apple-darwin.tar.gz) |
| Linux 64-bit | [`linus-ai-med-4.0.0-x86_64-unknown-linux-gnu.tar.gz`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.0/linus-ai-med-4.0.0-x86_64-unknown-linux-gnu.tar.gz) |
| Linux ARM64 | [`linus-ai-med-4.0.0-aarch64-unknown-linux-gnu.tar.gz`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.0/linus-ai-med-4.0.0-aarch64-unknown-linux-gnu.tar.gz) |
| Checksums | [`SHA256SUMS.txt`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.0/SHA256SUMS.txt) |

See [HIPAA.md](HIPAA.md) for compliance documentation.

---

## Pricing

| Plan | Users | Price | Link |
|---|---|---|---|
| **Clinic** | Up to 25 | $1,499 one-time | [Pay $1,499](https://www.paypal.com/ncp/payment/AK3Q7XPYMMY3S) |
| **Hospital** | Up to 500 | $9,999 one-time | [Pay $9,999](https://www.paypal.com/ncp/payment/DAJ5PCGUVGHNW) |
| **Health System** | Unlimited | Contact sales | [sales@linus-ai.com](mailto:sales@linus-ai.com) |

Pay via PayPal → email **support@linus-ai.com** with your receipt → receive license key within 1 business day.

---

## Free evaluation

First launch gives you a **30-day full-access evaluation** — no key needed.  
After 30 days, clinical AI endpoints require a license key. The admin dashboard stays accessible.

```bash
curl -X POST http://localhost:9500/admin/api/activate \
  -H "Authorization: Bearer <admin-token>" \
  -d '{"key": "YOUR-LICENSE-KEY"}'
```

---

## Getting started

### Mac

```bash
tar xzf linus-ai-med-4.0.0-aarch64-apple-darwin.tar.gz
xattr -d com.apple.quarantine linus-ai-med
codesign --force --deep --sign - linus-ai-med
bash quickstart.sh
```

If Mac blocks it: **System Settings → Privacy & Security → Open Anyway**

### Linux

```bash
tar xzf linus-ai-med-4.0.0-x86_64-unknown-linux-gnu.tar.gz
bash quickstart.sh
```

Or manually:
```bash
cp config/server.toml.example config/server.toml
# Edit config/server.toml — set admin password, port, and HIPAA settings
./linus-ai-med --config config/server.toml --port 9500
```

Admin dashboard: **http://localhost:9500/admin**  
Clinical API: **http://localhost:9500/api/v1**

> **Never expose port 9500 to the internet.** Use a reverse proxy with TLS (nginx/Caddy) for remote staff access.

---

## What staff can do (User features)

| Capability | Clinic | Hospital | Health System |
|---|---|---|---|
| Ask clinical AI questions in a browser | ✓ | ✓ | ✓ |
| Role-restricted access (each role sees only what they should) | ✓ | ✓ | ✓ |
| Summarise patient notes | ✓ | ✓ | ✓ |
| Drug interaction and dosing questions | ✓ | ✓ | ✓ |
| Prior authorisation workflow support | ✓ | ✓ | ✓ |
| Radiology-specific AI prompts | ✓ | ✓ | ✓ |
| Streaming AI responses (no waiting for full response) | ✓ | ✓ | ✓ |
| Up to 70B model support (hardware permitting) | ✓ | ✓ | ✓ |

## What IT / compliance teams can do (Admin features)

| Capability | Clinic | Hospital | Health System |
|---|---|---|---|
| Automatic detection of PHI in every prompt (names, SSN, DOB, MRN, phone, email) | ✓ | ✓ | ✓ |
| Block or warn when PHI is detected — configurable per role | ✓ | ✓ | ✓ |
| Append-only audit log of every AI request (user, role, timestamp, PHI flag) | ✓ | ✓ | ✓ |
| Daily log rotation for easy archival and review | ✓ | ✓ | ✓ |
| Exportable compliance PDF report | ✓ | ✓ | ✓ |
| JWT-based session tokens scoped to clinical role | ✓ | ✓ | ✓ |
| Zero telemetry — no data ever sent outside your network | ✓ | ✓ | ✓ |
| TLS enforcement for any non-local connection | ✓ | ✓ | ✓ |
| Multi-site / multi-facility deployment | — | — | ✓ |
| Active Directory / LDAP login | — | — | ✓ |
| Cryptographic blockchain audit ledger | — | — | ✓ |

---

## Clinical roles

| Role | What they can do |
|---|---|
| `physician` | Full AI access, all model outputs |
| `nurse` | Inference, care plan templates |
| `radiologist` | Radiology-specific prompts |
| `lab_tech` | Lab result interpretation |
| `pharmacist` | Drug interactions and dosing |
| `surgical_coordinator` | Scheduling, pre-op notes |
| `insurance_analyst` | Prior auth, ICD coding |
| `prior_auth_specialist` | Prior authorisation workflows |
| `medical_office_staff` | Scheduling, non-clinical queries |
| `admin` | Full system access (non-clinical) |

Roles are configured in `config/roles.toml`. Each role controls which model it uses, what system prompt it gets, how PHI is handled, and token limits.

---

## Supported medical AI models

| Model | Size | Best for |
|---|---|---|
| **Med42-70B** | ~40 GB | General clinical reasoning |
| **Med42-8B** | ~4.5 GB | Lighter clinical use |
| **Meditron-70B** | ~40 GB | Clinical guidelines, evidence-based medicine |
| **Meditron-7B** | ~4 GB | Lightweight clinical queries |
| **BioMistral-7B** | ~4 GB | Biomedical, pharmacy |
| **ClinicalCamel-70B** | ~40 GB | Clinical dialogue |
| **ClinicalCamel-13B** | ~7 GB | Clinical dialogue (mid-size) |

Add any GGUF-format model to `models/catalog.toml`.

---

## HIPAA compliance summary

| Protection | How it works |
|---|---|
| PHI Detection | Scans every prompt for 12+ types of identifying information |
| PHI Blocking | Configurable: block the request or warn and log |
| Audit Log | Append-only JSONL — cannot be edited or deleted |
| Daily Rotation | Logs split by day for easy compliance review |
| Role Isolation | JWT tokens prevent cross-role access |
| No Cloud | AI runs entirely on your hardware — no data leaves |
| No Telemetry | Zero analytics, zero call-home |
| TLS | Blocks non-local connections without encryption |

See [HIPAA.md](HIPAA.md) for the full compliance guide and Business Associate Agreement template.

---

## API reference

### Authentication
```bash
POST /api/v1/session
{"username": "dr.smith", "password": "...", "role": "physician"}
→ {"token": "eyJ..."}
```

### Clinical AI
```bash
POST /api/v1/infer
Authorization: Bearer <token>
{"prompt": "Summarise this patient note: ...", "max_tokens": 512}

GET /api/v1/stream?prompt=...
Authorization: Bearer <token>
```

### Management
```bash
GET /api/v1/models     # models available to this role
GET /api/v1/roles      # available clinical roles
GET /health            # server status and trial state
GET /admin             # admin dashboard (browser)
```

---

## Server requirements

| | Minimum | Recommended |
|---|---|---|
| **OS** | macOS 12 / Ubuntu 20.04 | Ubuntu 22.04 LTS |
| **CPU** | 8-core | 32-core server CPU |
| **RAM** | 16 GB | 128 GB (for 70B models) |
| **Storage** | 50 GB SSD | 500 GB NVMe |
| **GPU (optional)** | CUDA 11.8+ | A100 80 GB / H100 |
| **Network** | 1 Gbps LAN | 10 Gbps for multi-node |

---

## Configuration

`config/server.toml` — key settings:
```toml
[admin]
username      = "admin"
password_hash = "$2b$12$..."   # generate with: htpasswd -bnBC 12 "" PASSWORD | tr -d ':\n'

[hipaa]
rotate_daily   = true
phi_detection  = true
phi_block_mode = true   # set false to warn only instead of blocking

llama_port   = 8080
max_sessions = 50
max_tokens   = 2048
```

`config/roles.toml` — example role:
```toml
[[role]]
name          = "physician"
model         = "Med42-70B"
max_tokens    = 2048
phi_policy    = "block"
system_prompt = "You are a clinical AI assistant. Do not provide diagnoses. Always recommend consulting a physician."
```

---

## License

Proprietary. See [LICENSE-COMMERCIAL.md](LICENSE-COMMERCIAL.md).  
Contact [sales@linus-ai.com](mailto:sales@linus-ai.com) for Health System and enterprise pricing.
