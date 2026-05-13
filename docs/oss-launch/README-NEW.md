# LINUS-AI

> **Private clinical AI that never leaves your hospital.**
> Plus 11 more apps (BizCore, Pulse, Trips, Forge, ConnectX, Reserve, Day, P2P, Corridor…) under the same license.
> Local-first. AGPL-3.0 open-core. Self-hostable. No cloud lock-in.

[![License: AGPL-3.0](https://img.shields.io/badge/License-AGPL_v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
[![Status: shipping](https://img.shields.io/badge/status-shipping-success.svg)](https://linus-ai.com/roadmap.html)

```
hub.linus-ai.com   ←  public demo (canned responses, no signup)
hub.linus-ai.com/?hsk=<key>  ←  signed-in trial / paid
```

---

## Why this exists

Hospitals, law firms, finance teams, and small businesses keep ending up with
the same problem: they want LLM-grade productivity tools, but uploading
patient charts / contracts / books to a vendor's cloud is not actually OK.

LINUS-AI gives you a complete app suite (medical, business, personal) that
runs **entirely on hardware you own** — a Mac Studio, a GPU server, a NUC, even
a beefy laptop. The same desktop Hub speaks to:

- Your local LINUS inference mesh (Tailscale-glued peers), **or**
- A self-hosted LINUS server on a single box, **or**
- Our public demo backend (for testing without any install)

Every app stores its own data in `~/.linus/<app>/data/` — never in the cloud,
never on our servers.

## What ships today (2026-05-13)

| Suite | Apps |
|---|---|
| ⚕ **Medical** | Clinical AI · Patients · Lab/Path · Radiology · Audit Log · Intelligent Patient · aiMED · HMS |
| ⬡ **Business** | BizCore (CRM/HR/Finance/Inventory/Projects/Analytics) · ConnectX · Browser extensions |
| 💡 **Personal** | Pulse (chat/habits/clipboard) · Forge (projects/design/strategy/LiveNode/Vault/ModelTest) · Trips (itineraries/hotels/flights/calendar/expenses/docs) |
| 🌐 **Network** | P2P Network (nodes/routing/bandwidth/wallet/privacy/monitor) · Day · Reserve · Corridor |
| 🧠 **Foundation** | LINUS-AI Core inference engine · OpenAI-compatible API · Mesh runtime · Local RAG |

Full status with "shipped / beta / planned" labels →
[linus-ai.com/roadmap.html](https://linus-ai.com/roadmap.html)

## Try it without installing

→ <https://hub.linus-ai.com> — Hub PWA. Every app loads instantly. The
public demo backend returns canned-but-honest responses so you can see the
UI flow. No signup required.

## Install for real (desktop, local mesh)

```sh
# macOS arm64 — download the DMG
open https://linus-ai.com/download.html

# Linux / Windows beta builds — same page
# Once installed:
#   open the Hub
#   Settings → Inference URL → http://<your-mesh-peer>:9480
#   Done.
```

For a multi-machine mesh (Mac Studio + GPU box + laptop), see
[`linus-mesh-setup/README.md`](../../linus-mesh-setup/README.md). It's a 15-minute
setup using Tailscale.

## Pricing

| Tier | Price | Cap |
|---|---|---|
| **14-day trial** | Free | Email-gated, full feature access |
| **Founding Member** | $19 / user / mo (lifetime) | First **1,000** customers only |
| **All Apps Monthly** | $49 / user / mo | — |
| **All Apps Annual** | $490 / user / yr | Save 17% |
| **AGPL self-host** | Free | Source disclosure if hosted to others (AGPL §13) |
| **Commercial (dual-license)** | from $5,000 / company / yr | Waives AGPL §13 |

Buy → <https://linus-ai.com/start>

## How is this open-source AND commercial?

It's the MongoDB / GitLab / Sentry model:

- The **open core** (Hub PWA, all 12 apps, inference engine, agents,
  extensions, mesh runtime) is AGPL-3.0. You can run it for yourself, fork
  it, modify it.
- The **license server** that issues paid `.lic` certificates is proprietary
  and lives in `linus-ai-private`. You can self-host an alternative that
  speaks the same HTTP API (we documented it).
- If you want to run a hosted SaaS on LINUS-AI **without** disclosing your
  source (which AGPL §13 would require), buy a commercial dual-license from
  us. Starts at $5K/yr per company.

Details: [`LICENSE-AGPL-NOTICE.md`](./LICENSE-AGPL-NOTICE.md).

## Contributing

We welcome PRs. See [`CONTRIBUTING.md`](./CONTRIBUTING.md) and [`CLA.md`](./CLA.md).

TL;DR: discuss bigger changes first; sign the one-line CLA; match the
existing style; one logical change per PR. We review within 3 business days.

## Repo layout

```
linus-ai-public/
├── linus-ai/             # Inference engine (Rust + Python bridge)
├── linus-hub/            # Desktop Hub (React + Vite + Tauri)
├── linus-bizcore/        # Business OS
├── linus-aiMED/          # Medical AI suite
├── linus-pulse/          # Personal AI
├── linus-trips/          # Travel
├── linus-forge/          # Product/design AI
├── linus-connectx/       # Relationship intelligence
├── linus-reserve/        # Hospitality AI
├── linus-day/            # Daily AI
├── linus-p2pnet/         # P2P / DePIN
├── linus-corridor/       # Cross-border payments (early)
├── linus-aiMED-ext/      # Browser extension (medical)
├── linus-bizcore-ext/    # Browser extension (business)
└── docs/                 # User + developer docs
```

## Status

- **Shipping**: Hub PWA (browser + macOS), inference core, mesh, every app
  listed above with the tabs shown at <https://hub.linus-ai.com>.
- **Beta**: ConnectX, Day, P2P Network, Windows + Linux desktop bundles.
- **Q3 2026**: AGPL open-core release · Founding Member tier launch ·
  FHIR/HL7 import · QuickBooks connector.
- **Q4 2026**: EHR connectors (Epic, Cerner) · LINUS Corridor banking pilot ·
  iOS/Android companions.

Full roadmap: <https://linus-ai.com/roadmap.html>

## Community

- **GitHub Discussions**: https://github.com/miryala3/linus-ai-public/discussions
- **Issues**: https://github.com/miryala3/linus-ai-public/issues
- **Email**: <oss@linus-ai.com> (open source) · <support@linus-ai.com>
  (paying customers)

## License

AGPL-3.0 — see [`LICENSE-AGPL-NOTICE.md`](./LICENSE-AGPL-NOTICE.md). For
commercial dual-licensing, email <support@linus-ai.com>.

© 2024-2026 Linus Software, LLC. *LINUS-AI*, *aiMED*, *BizCore*, *Pulse*,
*Forge*, *ConnectX*, *Reserve*, *Trips*, *Day*, *P2P Network*, and *Corridor*
are trademarks of Linus Software, LLC (USPTO filing pending).
