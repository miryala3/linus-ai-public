# LINUS-AI Medical Server v4.0.2

**HIPAA-compliant private AI for hospitals and clinics. PHI never leaves your network.**

[![Version](https://img.shields.io/badge/version-4.0.2-green)]()
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey)]()
[![HIPAA](https://img.shields.io/badge/HIPAA-compliant-blue)]()

> Part of the **[LINUS-AI Product Suite](https://github.com/miryala3/linus-ai-public)**  
> Purchase: **[linus-ai.com/store](https://linus-ai.com/store/index.html#aimed)**

---

## What it does

On-premise AI inference server built for clinical environments. Deploy on your hospital hardware — no data ever reaches an external server.

- Role-scoped AI: physician, nurse, radiologist, pharmacist, admin, and more
- PHI detection with automatic redaction
- Append-only audit log (JSONL, daily rotation) for compliance
- Supports Med42, Meditron, BioMistral, ClinicalCamel (GGUF format)
- REST API on `:9500` for EHR/EMR integration
- Every paid license includes 3 keys: Medical Server + aiMED Extension + LINUS-AI Professional

---

## Pricing

| Tier | Concurrent users | Price |
|---|---|---|
| **Clinic** | 25 | $1,499 one-time |
| **Hospital** | 500 | $9,999 one-time |
| **Health System** | Unlimited | $99,999 one-time |

Lifetime updates add-on: +$299 (Clinic) · +$999 (Hospital) · +$9,999 (Health System)

---

## Download — v4.0.2

| Platform | File |
|---|---|
| macOS arm64 — Apple Silicon | [`med-linus-ai-med-4.0.2-aarch64-apple-darwin.tar.gz`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.2/med-linus-ai-med-4.0.2-aarch64-apple-darwin.tar.gz) |
| Linux x86_64 | [`med-linus-ai-med-4.0.2-x86_64-unknown-linux-gnu.tar.gz`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.2/med-linus-ai-med-4.0.2-x86_64-unknown-linux-gnu.tar.gz) |
| Linux arm64 | [`med-linus-ai-med-4.0.2-aarch64-unknown-linux-gnu.tar.gz`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.2/med-linus-ai-med-4.0.2-aarch64-unknown-linux-gnu.tar.gz) |
| Checksums | [`SHA256SUMS-med.txt`](https://github.com/miryala3/linus-ai-public/releases/download/med-v4.0.2/SHA256SUMS-med.txt) |

[→ All aiMED Medical releases](https://github.com/miryala3/linus-ai-public/releases?q=tag%3Amed-v)

---

## Install

**macOS**
```bash
tar xzf med-linus-ai-med-4.0.2-aarch64-apple-darwin.tar.gz
xattr -d com.apple.quarantine linus-ai-med
bash quickstart.sh
```

**Linux**
```bash
tar xzf med-linus-ai-med-4.0.2-x86_64-unknown-linux-gnu.tar.gz
bash quickstart.sh
```

Admin interface: **http://localhost:9500/admin**  
⚠ Never expose port 9500 to the internet without TLS termination.

---

## Activate

```bash
# POST to activate endpoint after launch:
curl -X POST http://localhost:9500/admin/api/activate \
  -H "Content-Type: application/json" \
  -d '{"license_key":"LNMD-XXXX-XXXX-XXXX-XXXX"}'
```

Lost key? → [linus-ai.com/reset](https://linus-ai.com/reset.html)

---

## Support

[support@linus-ai.com](mailto:support@linus-ai.com) · [sales@linus-ai.com](mailto:sales@linus-ai.com) (enterprise/health system)  
[linus-ai.com/support](https://linus-ai.com/support.html)
