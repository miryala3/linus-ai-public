# LINUS BizCore v4.0.0

**Local-first business OS — invoicing, CRM, accounting, HR, and AI assistant. No SaaS fees.**

[![License](https://img.shields.io/badge/license-Proprietary-red)](LICENSE-COMMERCIAL.md)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey)]()
[![Version](https://img.shields.io/badge/version-4.0.0-green)]()

> Part of the **[LINUS-AI Product Suite](https://github.com/miryala3/linus-ai-public#readme)**  
> All downloads and purchase links: [github.com/miryala3/linus-ai-public](https://github.com/miryala3/linus-ai-public#readme)

---

## What is LINUS BizCore?

LINUS BizCore is a complete desktop business suite for small businesses. Invoicing, contacts, tasks, calendar, documents, HR & payroll, and accounting — all in one app, running entirely on your machine. The built-in AI assistant connects to LINUS-AI (port 9480) or Ollama (port 11434) on your LAN for zero-cloud AI.

One-time purchase. No subscriptions. Your data stays local.

---

## Download

Download from **[GitHub Releases — latest](https://github.com/miryala3/linus-bizcore/releases/latest)**

| Platform | File |
|---|---|
| macOS arm64 (Apple Silicon) | `LINUS-BizCore_4.0.0_aarch64.dmg` |
| Linux x86_64 | `LINUS-BizCore_4.0.0_amd64.deb` / `LINUS-BizCore_4.0.0_amd64.AppImage` |
| Windows x86_64 | `LINUS-BizCore_4.0.0_x64-setup.exe` / `LINUS-BizCore_4.0.0_x64_en-US.msi` |

### macOS — first launch

The DMG is unsigned. Before opening:
```bash
xattr -d com.apple.quarantine LINUS-BizCore_4.0.0_aarch64.dmg
```
Then double-click the DMG, drag BizCore to Applications, and right-click → Open on first launch.

### Linux runtime dependencies
```bash
sudo apt-get install -y libwebkit2gtk-4.1-0 libgtk-3-0 \
  libayatana-appindicator3-1 librsvg2-2
```

---

## Pricing

| Tier | Price | Modules | AI Assistant | Users |
|---|---|---|---|---|
| **Starter** | $199 one-time | Core 5 modules | ✓ (read-only) | 1 |
| **Business** | $299 one-time | All 8 modules | ✓ full | 3 |
| **Unlimited** | $599 one-time | All modules | ✓ full | Unlimited |

**Buy now via PayPal:**

| Tier | Link |
|---|---|
| Starter — $199 | [Pay $199](https://www.paypal.com/ncp/payment/RY263RA748ZWY) |
| Business — $299 | [Pay $299](https://www.paypal.com/ncp/payment/VNFMWHE2UQ9AE) |
| Unlimited — $599 | [Pay $599](https://www.paypal.com/ncp/payment/57ZWKLYLZ6B3W) |

After payment, email **support@linus-ai.com** with your order confirmation — your license key will be delivered within 1 business day.

---

## Trial

First launch activates a free **14-day trial** with full Business-tier access.
After 14 days, a license key is required to continue. **Buy now via PayPal:**

| Tier | Link |
|---|---|
| Starter — $199 | [Pay $199](https://www.paypal.com/ncp/payment/RY263RA748ZWY) |
| Business — $299 | [Pay $299](https://www.paypal.com/ncp/payment/VNFMWHE2UQ9AE) |
| Unlimited — $599 | [Pay $599](https://www.paypal.com/ncp/payment/57ZWKLYLZ6B3W) |

After payment, email **support@linus-ai.com** with your order confirmation — your license key will be delivered within 1 business day.

---

## Modules

| Module | Starter | Business | Unlimited |
|---|---|---|---|
| **Dashboard** — activity feed, KPIs, cash flow snapshot | ✓ | ✓ | ✓ |
| **Invoicing** — create, send, track invoices + payments | ✓ | ✓ | ✓ |
| **Contacts / CRM** — customers, vendors, interaction history | ✓ | ✓ | ✓ |
| **Tasks** — project tasks, deadlines, assignments | ✓ | ✓ | ✓ |
| **Calendar** — scheduling, reminders, team events | ✓ | ✓ | ✓ |
| **Documents** — file storage, templates, e-sign | — | ✓ | ✓ |
| **HR & Payroll** — employees, time tracking, payslips | — | ✓ | ✓ |
| **Accounting** — chart of accounts, P&L, balance sheet | — | ✓ | ✓ |
| **AI Assistant** — chat with your business data | read-only | ✓ | ✓ |

---

## AI Assistant

BizCore connects to a LINUS-AI server or Ollama instance on your LAN for AI assistance:

- Summarise invoices, flag overdue accounts
- Draft email responses to customers
- Answer questions about your HR records or financials
- Generate reports from natural language queries

**Setup:** Settings → AI → enter server address (default: `http://localhost:9480`). No internet required.

---

## Technical Features

- **Database:** SQLite with SQLCipher (AES-256 encryption at rest)
- **Key derivation:** PBKDF2 / Argon2id for database unlock
- **Field encryption:** AES-256-GCM for sensitive fields (SSN, bank details)
- **Built with:** Tauri 2.0 (Rust + WebView), React frontend, SQLite
- **Integrations:** Stripe (payments), SendGrid (email), Plaid (bank feeds) — all optional
- **PDF export:** Native PDF generation for invoices and reports
- **CSV import/export:** All data tables
- **Offline-first:** Works without internet; sync is always local

---

## System Requirements

| | Minimum | Recommended |
|---|---|---|
| **OS** | macOS 12, Ubuntu 22.04, Windows 10 | macOS 14, Ubuntu 24.04, Windows 11 |
| **RAM** | 4 GB | 8 GB |
| **Storage** | 500 MB | 2 GB |
| **Display** | 1024 × 600 | 1280 × 800 |
| **AI (optional)** | LINUS-AI on LAN | LINUS-AI Professional on same machine |

---

## License

Proprietary. See [LICENSE-COMMERCIAL.md](LICENSE-COMMERCIAL.md).
One license per purchased seat. Not for redistribution.


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


## Deployment Modes & Enterprise Licensing

Linus BizCore supports two distinct runtime environments, controlled via the UI at launch:
1. **Demo Mode:** Bypasses authentication and loads comprehensive mock data for demonstrations.
2. **Real Mode:** Initializes with a clean slate and requires an Enterprise License Key to provision the root administrator.

**RBAC Tier Mapping:**
- `LNBC-ENT*` → Super Admin (Full Ecosystem Access)
- `LNBC-PRO*` → Operations Manager (Pro Features)
- `LNBC-GRW*` → Finance Controller (Growth Features)
- `LNBC-STR*` → Staff Member (Core Features)

Network-aware capabilities are natively integrated; the application dynamically exposes a link to the `linus-ai` personal apps dashboard via local DNS (`http://linus-ai.local:1420`) upon license validation.
