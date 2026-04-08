# LINUS-AI Medical v4.0.0

**HIPAA-compliant private AI server for healthcare. All inference runs on your hardware — PHI never leaves your infrastructure.**

[![License](https://img.shields.io/badge/license-Proprietary-red)](LICENSE-COMMERCIAL.md)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey)]()
[![Version](https://img.shields.io/badge/version-4.0.0-green)]()
[![HIPAA](https://img.shields.io/badge/HIPAA-ready-blue)]()

> Part of the **[LINUS-AI Product Suite](https://github.com/miryala3/linus-ai-public#readme)**  
> All downloads and purchase links: [github.com/miryala3/linus-ai-public](https://github.com/miryala3/linus-ai-public#readme)

---

## What is LINUS-AI Medical?

LINUS-AI Medical (`linus-ai-med`) is an enterprise-grade medical AI server for hospitals, clinics, and healthcare networks. It runs HIPAA-compliant large language model inference entirely on-premise. No patient data ever leaves your infrastructure.

Key capabilities:
- Role-scoped clinical AI (physician, nurse, radiologist, pharmacist, and more)
- PHI detection and audit logging built in
- Supports leading open-source medical LLMs (Med42, Meditron, BioMistral, ClinicalCamel)
- Single binary — no Python, no pip, no cloud dependencies
- REST API compatible with aiMED-v3 clients

---

## Download

Download from **[GitHub Releases — latest](https://github.com/miryala3/linus-aiMED/releases/latest)**

| Platform | File |
|---|---|
| macOS arm64 (Apple Silicon) | `linus-ai-med-4.0.0-aarch64-apple-darwin.tar.gz` |
| Linux x86_64 | `linus-ai-med-4.0.0-x86_64-unknown-linux-gnu.tar.gz` |
| Linux arm64 | `linus-ai-med-4.0.0-aarch64-unknown-linux-gnu.tar.gz` |

Verify with `SHA256SUMS.txt`. See [HIPAA.md](HIPAA.md) for compliance documentation.

---

## Pricing

LINUS-AI Medical is an **enterprise product**. Pricing is based on deployment size and support tier.

| Tier | Description |
|---|---|
| **Clinic** | Up to 25 concurrent users, standard support |
| **Hospital** | Up to 500 concurrent users, priority support |
| **Health System** | Unlimited users, dedicated SLA, on-site onboarding |

**Buy now via PayPal:**

| Tier | Concurrent Users | Link |
|---|---|---|
| Clinic | 25 | [Pay $1,499](https://www.paypal.com/ncp/payment/LNMD-CLINIC) |
| Hospital | 500 | [Pay $4,999](https://www.paypal.com/ncp/payment/LNMD-HOSP) |
| Health System | Unlimited | [Contact sales](mailto:sales@linus-ai.com) |

After payment, email **support@linus-ai.com** with your order confirmation — your license key will be delivered within 1 business day.

---

## Trial

First launch activates a free **30-day evaluation** with full access.
After 30 days, the server continues to run but all clinical inference endpoints (`/api/v1/*`) return HTTP 402 until a license key is activated. The admin interface (`/admin`) remains accessible.

Activate a license:
```bash
curl -X POST http://localhost:9500/admin/api/activate \
  -H "Authorization: Bearer <admin-token>" \
  -d '{"key": "YOUR-LICENSE-KEY"}'
```

---

## Quick Start

### macOS

```bash
tar xzf linus-ai-med-4.0.0-aarch64-apple-darwin.tar.gz
# Remove quarantine and ad-hoc sign before first run
xattr -d com.apple.quarantine linus-ai-med
codesign --force --deep --sign - linus-ai-med
bash quickstart.sh
```

> If macOS blocks the binary: **System Settings → Privacy & Security → Open Anyway**

### Linux

```bash
tar xzf linus-ai-med-4.0.0-x86_64-unknown-linux-gnu.tar.gz
bash quickstart.sh     # auto-detects hardware, prompts for config, starts server
```

Or manually:
```bash
cp config/server.toml.example config/server.toml
# Edit config/server.toml:
#   - Set admin.password_hash (generate with: htpasswd -bnBC 12 "" PASSWORD | tr -d ':\n')
#   - Set llama_port to match your llama-server instance
#   - Configure hipaa settings

./linus-ai-med --config config/server.toml --port 9500
# Admin:  http://localhost:9500/admin
# API:    http://localhost:9500/api/v1
```

> **Security:** Never expose port 9500 to the internet. Use a reverse proxy with TLS for remote access.

---

## Clinical Roles

| Role | Access Level | Recommended Model |
|---|---|---|
| `physician` | Full inference, all model outputs | Med42-70B, ClinicalCamel-70B |
| `nurse` | Inference, care plan templates | Meditron-70B |
| `radiologist` | Radiology-specific prompts | Med42-70B |
| `lab_tech` | Lab interpretation only | BioMistral-7B |
| `pharmacist` | Drug interaction, dosing | Meditron-7B |
| `surgical_coordinator` | Scheduling, pre-op notes | ClinicalCamel-13B |
| `insurance_analyst` | Prior auth, ICD coding | BioMistral-7B |
| `prior_auth_specialist` | Prior authorization workflows | BioMistral-7B |
| `medical_office_staff` | Scheduling, non-clinical | Any community model |
| `admin` | Full system access (non-clinical) | N/A |

Roles are configured in `config/roles.toml`. Each role specifies allowed models, system prompts, PHI handling policy, and token limits.

---

## Supported Medical LLMs

| Model | Size | Specialty | Format |
|---|---|---|---|
| **Med42-70B** | ~40 GB | General clinical | GGUF |
| **Med42-8B** | ~4.5 GB | General clinical (lightweight) | GGUF |
| **Meditron-70B** | ~40 GB | Clinical guidelines, evidence-based | GGUF |
| **Meditron-7B** | ~4 GB | Lightweight clinical | GGUF |
| **BioMistral-7B** | ~4 GB | Biomedical, pharma | GGUF |
| **ClinicalCamel-70B** | ~40 GB | Clinical dialogue | GGUF |
| **ClinicalCamel-13B** | ~7 GB | Clinical dialogue (mid-tier) | GGUF |

Models are managed via `models/catalog.toml`. Add any GGUF model supported by llama.cpp.

---

## HIPAA Compliance Features

| Feature | Description |
|---|---|
| **PHI Detection** | Regex + NLP patterns detect SSN, DOB, MRN, phone, email in prompts |
| **PHI Blocking** | Configurable: block or warn on PHI detection |
| **Audit Log** | Append-only JSONL log of all inference requests (user, role, timestamp, PHI flag) |
| **Daily Log Rotation** | Audit logs rotated daily for easy archival |
| **Role-Scoped Access** | JWT tokens scoped to clinical role — cross-role access denied |
| **Local-Only Inference** | No PHI ever transmitted to external servers |
| **No Telemetry** | Zero call-home, zero analytics |
| **TLS Enforcement** | `require_tls_remote` blocks non-localhost connections without TLS |

See [HIPAA.md](HIPAA.md) for the full compliance documentation and Business Associate Agreement template.

---

## API Reference

All endpoints require a valid JWT token (except `/health` and `/admin/auth`).

### Authentication
```bash
# Create session (get JWT)
POST /api/v1/session
{"username": "dr.smith", "password": "...", "role": "physician"}
→ {"token": "eyJ..."}
```

### Inference
```bash
# Single inference
POST /api/v1/infer
Authorization: Bearer <token>
{"prompt": "Summarise this patient note: ...", "max_tokens": 512}

# Streaming inference (SSE)
GET /api/v1/stream?prompt=...&max_tokens=512
Authorization: Bearer <token>
```

### Management
```bash
GET /api/v1/models          # list models available to this role
GET /api/v1/roles           # list available roles
GET /health                 # server health + trial status
GET /admin                  # admin dashboard (HTML)
```

---

## Configuration

### config/server.toml
```toml
[admin]
username      = "admin"
password_hash = "$2b$12$..."   # bcrypt hash

[hipaa]
rotate_daily   = true
phi_detection  = true
phi_block_mode = true          # false = warn only

llama_port     = 8080
max_sessions   = 50
max_tokens     = 2048
```

### config/roles.toml
```toml
[[role]]
name        = "physician"
model       = "Med42-70B"
max_tokens  = 2048
phi_policy  = "block"
system_prompt = "You are a clinical AI assistant. Do not provide diagnoses. Always recommend consulting a physician."
```

---

## System Requirements

| | Minimum | Recommended |
|---|---|---|
| **OS** | macOS 12 / Ubuntu 20.04 | Ubuntu 22.04 LTS |
| **CPU** | 8-core | 32-core server CPU |
| **RAM** | 16 GB | 128 GB (for 70B models) |
| **Storage** | 50 GB SSD | 500 GB NVMe |
| **GPU (optional)** | Any CUDA 11.8+ | A100 80GB / H100 |
| **Network** | 1 Gbps LAN | 10 Gbps for multi-node |
| **llama-server** | Required separately | llama.cpp or Ollama |

---

## License

Proprietary. See [LICENSE-COMMERCIAL.md](LICENSE-COMMERCIAL.md).
For pricing and deployment, contact [sales@linus-ai.com](mailto:sales@linus-ai.com).


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
