# HIPAA Compliance Documentation — linus-aiMED

## Overview

linus-aiMED is designed to operate as a HIPAA-compliant AI server within a healthcare organization's controlled environment. This document describes the technical and administrative safeguards implemented.

**Important:** linus-aiMED is a technical tool. HIPAA compliance requires both technical safeguards (this software) AND administrative safeguards (policies, training, BAAs) implemented by your organization.

---

## HIPAA Security Rule Safeguards

### §164.312(a) — Access Control

| Requirement | Implementation |
|---|---|
| Unique user identification | Each aiMED-v3 client receives a unique API key and user ID |
| Emergency access | Admin role with full capability override |
| Automatic logoff | JWT token expiration (configurable, default 8 hours) |
| Encryption / decryption | JWT tokens signed with HS256; secrets stored with file permissions 600 |

### §164.312(b) — Audit Controls

Every access event is recorded in an append-only JSONL audit log:
- Timestamp (UTC)
- Event type (session, inference, admin action, PHI detection, denial)
- User ID (hashed API key prefix)
- Role
- Session ID
- SHA-256 of prompt (never the prompt text)
- SHA-256 of response (never the response text)
- PHI pattern names detected (never the matched values)
- Cryptographic chain hash (SHA-256 of previous entry)

**Log rotation:** Daily (configurable). Retention period: configurable (recommended 6 years for covered entities).

### §164.312(c) — Integrity

- Audit log entries are cryptographically chained (each entry's hash includes the previous entry's hash)
- Tamper detection: any modification to the log chain breaks the hash sequence
- Model integrity: downloaded GGUF files should be verified against published SHA-256 checksums

### §164.312(d) — Person or Entity Authentication

- Admin authentication: username + bcrypt-hashed password (cost factor 12)
- Client authentication: cryptographically random 256-bit API keys (hex-encoded, 64 chars)
- API key storage: only SHA-256 hash stored; raw key shown once at creation

### §164.312(e) — Transmission Security

- Server binds to `127.0.0.1` by default (localhost only)
- Remote binding requires TLS (`require_tls_remote = true` in config)
- aiMED-v3 client connections should use TLS when traversing any network
- CORS headers restrict browser access

---

## PHI Detection and Protection

linus-aiMED scans all inference prompts for the following PHI patterns:

| Pattern | Regex target |
|---|---|
| SSN | `\d{3}-\d{2}-\d{4}` |
| Medical Record Number | `MRN[:\s#]*\d{4,10}` |
| Date of Birth | `DOB/Date of Birth + date` |
| Phone number | US phone formats |
| Email address | RFC 5321 pattern |
| Insurance policy/member ID | `Policy/Member/Group ID + alphanumeric` |
| NPI number | 10-digit NPI |
| DEA number | `DEA + standard format` |

When PHI is detected:
- **Default (phi_warn_only = false):** Request is blocked; PHI patterns logged; client receives 422 with de-identification instructions
- **Testing mode (phi_warn_only = true):** Request proceeds; PHI patterns logged with warning

**PHI is never written to the audit log.** Only the SHA-256 hash of the prompt and the pattern names are recorded.

---

## Business Associate Agreements

linus-aiMED is an on-premises tool. However, if you use any external services in conjunction with this system (cloud hosting, monitoring, etc.), a Business Associate Agreement (BAA) with those vendors is required.

**No BAA is required with LINUS-AI-PRO** for the linus-aiMED software itself, as no PHI is transmitted to LINUS-AI-PRO systems — all inference is local.

---

## Deployment Requirements

### Minimum Requirements for HIPAA Use

1. **Physical security:** Server hardware must be in a physically secured location
2. **Network isolation:** Bind to localhost or a private network segment only
3. **Disk encryption:** Enable full-disk encryption (FileVault on macOS, BitLocker on Windows, LUKS on Linux)
4. **Backup encryption:** Any backup of the data directory must be encrypted
5. **Access logging:** Ensure OS-level access logs supplement the application audit log
6. **Incident response plan:** Your organization must have a documented breach response plan

### Recommended Additional Controls

- VPN or SSH tunneling for remote aiMED-v3 client connections
- Regular audit log review (weekly minimum)
- Quarterly access review of API keys
- Annual penetration testing of the deployment environment

---

## Workforce Training

This software does not replace workforce HIPAA training. All users with access to linus-aiMED should complete:

- HIPAA Privacy Rule training
- HIPAA Security Rule training
- Organization-specific policies for AI tool use with PHI

---

## Incident Response

If a potential PHI breach is detected (e.g., PHI found in audit logs despite detection controls):

1. Immediately notify your Privacy Officer: see `config/server.toml` → `privacy_officer`
2. Preserve the audit log files (do not delete or modify)
3. Identify the user_id and session_id from audit entries
4. Follow your organization's Breach Notification Policy (§164.400–414)
5. File this issue at: https://github.com/LINUS-AI-PRO/linus-aiMED/issues (do not include PHI)

---

## Disclaimer

linus-aiMED is a software tool. It is the responsibility of the covered entity deploying this software to ensure full HIPAA compliance through appropriate administrative, physical, and additional technical safeguards. LINUS-AI-PRO is not a covered entity or business associate in standard deployments of this on-premises software.
