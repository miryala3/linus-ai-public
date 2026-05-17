# LINUS-AI — the public source tree

**Private AI for business + clinical teams. Runs entirely on your hardware. No cloud at runtime.**

> This repo is the **README of READMEs** for the public-facing LINUS-AI
> product surface. Every product directory below has its own README;
> every licence file below applies; every link points at the canonical
> source. Start here when you're trying to find anything.

[![Open core — AGPL-3.0](https://img.shields.io/badge/open%20core-AGPL--3.0-2ea043)](LICENSE.md)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey)]()
[![Status — production](https://img.shields.io/badge/status-production-388bfd)]()

**→ Trial / buy:** [linus-ai.com/start.html](https://linus-ai.com/start.html) · [bundles](https://linus-ai.com/bundles.html)
**→ Hosted Hub:** [hub.linus-ai.com](https://hub.linus-ai.com)
**→ Support:** [support@linus-ai.com](mailto:support@linus-ai.com) · [SLA](https://linus-ai.com/sla.html)

---

## What's in this repo

The public **source tree** for every LINUS-AI product the customer can
self-host. Each subdirectory is a complete product with its own build
instructions in its own README.

### Per-product READMEs

| Product | Source | Latest | Platforms | Marketed in |
|---|---|---|---|---|
| **LINUS-AI** (inference engine) | [linus-ai/README.md](linus-ai/README.md) | v4.0.2 | macOS · Linux · Windows | Bundled into every Suite |
| **LINUS BizCore** | [linus-bizcore/README.md](linus-bizcore/README.md) | v4.0.1 | macOS · Linux | Business AI Suite |
| **BizCore Browser Extension** | [linus-bizcore-ext/README.md](linus-bizcore-ext/README.md) | v4.0.0 | Chrome · Edge · Firefox · Brave | Business AI Suite |
| **aiMED Medical** | [linus-ai-med/README.md](linus-ai-med/README.md) | v4.0.2 | macOS · Linux | Medical AI Suite |
| **aiMED Browser Extension** | [linus-aimed-ext/README.md](linus-aimed-ext/README.md) | v4.0.2 | Chrome · Edge · Firefox · Brave | Medical AI Suite |
| **LINUS ConnectX** | [connectx/README.md](connectx/README.md) | v0.1.2 | macOS · Linux | Business AI Suite |
| **LINUS Pulse** | [pulse/README.md](pulse/README.md) | v0.1.2 | macOS · Linux | Personal AI Suite |
| **LINUS Forge** | [forge/README.md](forge/README.md) | v0.1.2 | macOS · Linux | Personal + Business |
| **LINUS Trips** | [trips/README.md](trips/README.md) | v0.1.3 | macOS · Linux | Personal AI Suite |
| **LINUS Reserve** | [reserve/README.md](reserve/README.md) | v2.0.2 | macOS · Linux | Personal AI Suite |
| **LINUS Day** | [day/README.md](day/README.md) | v2.2.4 | macOS · Linux | Personal + Business |
| **P2P Network** | [p2pnet/README.md](p2pnet/README.md) | v0.5.1 | macOS · Linux | Business AI Suite |
| **LINUS Hub** (GUI shell) | [gui/README.md](gui/README.md) | v0.6.0 | All | The launcher around everything |

---

## The four revenue streams (commercial map)

```
                          ┌──────────────────────────────┐
                          │  Stream 1: Cloud Hub         │
                          │  hub.linus-ai.com            │
                          │  14-day trial → $49/mo paid  │
                          └──────────────┬───────────────┘
                                         │  upgrade path ↓
   ┌──────────────────────┬──────────────┴───────────┬──────────────────────┐
   ▼                      ▼                          ▼                      ▼
┌──────────┐         ┌──────────┐               ┌──────────┐         ┌──────────────┐
│Stream 2: │         │Stream 3: │               │Stream 4: │         │  Sovereign   │
│ Personal │         │ Business │               │ Medical  │         │  Editions    │
│ AI Suite │         │ AI Suite │               │ AI Suite │         │ LNAS/LNBS/   │
│  LNAP    │         │  LNAB    │               │  LNAM    │         │ LNMS         │
│  $149    │         │  $599    │               │  $2,499  │         │ $5K–$50K +   │
│ + $49/yr │         │ + $199/yr│               │ + $499/yr│         │  Mac Studio  │
└──────────┘         └──────────┘               └──────────┘         └──────────────┘
  Trips · Day ·        BizCore ·                  aiMED ·              White-glove
  Reserve ·            ConnectX ·                 Intelligent          install +
  Archive ·            Forge ·                    Patient ·            SOC 2 binder
  Pulse · Forge ·      Day ·                      HMS ·                + 24-hr SLA
  linus-ai Pro         P2PNet ·                   linus-ai Pro         + hardware
                       linus-ai Pro               (medical-tuned)        bundled
```

All four streams use the same single-binary suite + cdylib plugin
architecture. Sovereign Editions add a compliance + support contract
on top of identical bits.

→ **[See pricing + buy at linus-ai.com/bundles.html](https://linus-ai.com/bundles.html)**

---

## Quick start — LINUS-AI inference engine (free, open core)

```bash
# macOS arm64
curl -LO https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-macos-arm64
chmod +x linus-ai-v4.0.2-headless-macos-arm64
xattr -d com.apple.quarantine linus-ai-v4.0.2-headless-macos-arm64
./linus-ai-v4.0.2-headless-macos-arm64
# → open http://127.0.0.1:9480/app
```

```bash
# Linux x86_64
curl -LO https://github.com/miryala3/linus-ai-public/releases/download/v4.0.2/linus-ai-v4.0.2-headless-linux-x86_64
chmod +x linus-ai-v4.0.2-headless-linux-x86_64
./linus-ai-v4.0.2-headless-linux-x86_64
```

The other products require a licence key (free 14-day trial at
[linus-ai.com/start.html](https://linus-ai.com/start.html)).

---

## Licence activation

Keys arrive by email within minutes of purchase. Format: `PPPP-XXXX-XXXX-XXXX-XXXX`.

| Bundle | Key prefix | Activate |
|---|---|---|
| **Personal AI Suite** | `LNAP-` | `linus-license activate LNAP-…` |
| **Business AI Suite** | `LNAB-` | `linus-license activate LNAB-…` |
| **Medical AI Suite** | `LNAM-` | `linus-license activate LNAM-…` |
| **Personal Sovereign** | `LNAS-` | white-glove install (we ship a Mac mini) |
| **Business Sovereign** | `LNBS-` | white-glove install (we ship a Mac Studio) |
| **Medical Sovereign** | `LNMS-` | white-glove install (we ship a Mac Studio + iPads) |
| **14-day Trial** | `LNTL-` | enter at first launch |
| **Legacy per-app keys** | `LNBC- / LNMD- / LNCX- / LNPA- / LNFG- / LNTR- / LNRV- / LNDY- / LNPN-` | see per-product README |

**Lost your key?** → [linus-ai.com/reset](https://linus-ai.com/reset.html)

---

## Documentation index — every README + every doc

### Top-level
- [**README.md**](README.md) — you are here
- [LICENSE.md](LICENSE.md) — primary open-core licence (AGPL-3.0)
- [LICENSE-COMMERCIAL.md](LICENSE-COMMERCIAL.md) — commercial licence for proprietary use
- [ENTERPRISE-SOURCE-LICENSE.md](ENTERPRISE-SOURCE-LICENSE.md) — enterprise / source-access tier
- [SOURCE-VIEWER-LICENSE.md](SOURCE-VIEWER-LICENSE.md) — read-only viewer tier
- [THIRD-PARTY-LICENSES.md](THIRD-PARTY-LICENSES.md) — every upstream dep + its licence

### OSS launch + governance
- [docs/oss-launch/README-NEW.md](docs/oss-launch/README-NEW.md) — drafted open-source launch README
- [docs/oss-launch/CONTRIBUTING.md](docs/oss-launch/CONTRIBUTING.md) — contributor workflow
- [docs/oss-launch/CLA.md](docs/oss-launch/CLA.md) — contributor licence agreement
- [docs/oss-launch/LICENSE-AGPL-NOTICE.md](docs/oss-launch/LICENSE-AGPL-NOTICE.md) — AGPL-3 notice template
- [docs/oss-launch/LAUNCH-POSTS.md](docs/oss-launch/LAUNCH-POSTS.md) — launch announcement copy (HN, Reddit, X)
- [docs/oss-launch/USPTO-TRADEMARK-DRAFT.md](docs/oss-launch/USPTO-TRADEMARK-DRAFT.md) — trademark filing draft

### Build + release
- [build.sh](build.sh) — top-level build orchestrator (calls each product's build)
- [build-gui.sh](build-gui.sh) — Hub GUI shell build
- [run.sh](run.sh) — local dev launcher
- [release.sh](release.sh) — release artefact packager
- [release-assets/](release-assets/) — pre-built distributables per platform

---

## Sister repos (full commercial stack)

| Repo | Visibility | What lives there |
|---|---|---|
| **linus-ai-public** *(this repo)* | public | The open-source product tree — every product's source, AGPL-3.0 |
| **[linus-hub](https://github.com/miryala3/linus-hub)** | private | Cloud Hub PWA · suite binaries (Personal / Business / Medical) · cdylib plugins · devkit (Python + TS SDKs + CLI) · OSN crates (audit, cognitive-router, wasm-sandbox) · cross-platform release matrix · 200+ pages of architecture / strategy / bundles / support docs |
| **[linus-ai-website](https://github.com/miryala3/linus-ai-website)** | private | Marketing site at linus-ai.com · bundles.html · sla.html · start.html · shared TypeScript `@miryala3/linus-shared` package |
| **[linus-ai-private](https://github.com/miryala3/linus-ai-private)** | private | Licence server (FastAPI) · pricing.yaml (SKU registry) · Ed25519 signing key · PayPal plan setup · trial issuance |

---

## The hub-side architecture (for contributors who want to go deeper)

The bits in **this** repo (linus-ai-public) ship as the **public** core
of each product. The packaging — turning these source trees into the
three Suite binaries that customers download — lives in the private
linus-hub repo. If you're contributing to a product here, you don't
need linus-hub. If you're trying to understand how the whole commercial
stack fits together, these are the doc entry points:

| You want to understand… | Read (in linus-hub) |
|---|---|
| The whole system on one page | [developer.md](https://github.com/miryala3/linus-hub/blob/master/developer.md) |
| The commercial thesis + 4 revenue streams | [docs/strategy/omnisovereign-node.md](https://github.com/miryala3/linus-hub/blob/master/docs/strategy/omnisovereign-node.md) |
| How the 3 self-hosted Suites are packaged | [docs/architecture/suite-binaries.md](https://github.com/miryala3/linus-hub/blob/master/docs/architecture/suite-binaries.md) |
| Schema + BCNF proof for the data model | [docs/architecture/data-model.md](https://github.com/miryala3/linus-hub/blob/master/docs/architecture/data-model.md) |
| Entity model + OS-level integrations | [docs/architecture/ARCHITECTURE.md](https://github.com/miryala3/linus-hub/blob/master/docs/architecture/ARCHITECTURE.md) |
| Add a 14th app to the suite | [docs/architecture/extending.md](https://github.com/miryala3/linus-hub/blob/master/docs/architecture/extending.md) |
| Wire the licence gate into a Tauri app | [docs/bundles/wiring-tauri-apps.md](https://github.com/miryala3/linus-hub/blob/master/docs/bundles/wiring-tauri-apps.md) |
| Public SDK / CLI / Python ORM | [docs/devkit/](https://github.com/miryala3/linus-hub/tree/master/docs/devkit) |

---

## Licensing — what you can do with this repo

This repo is **open core** under **AGPL-3.0**. Brief summary (see [LICENSE.md](LICENSE.md) for the binding terms):

- ✅ Use for personal / non-commercial / open-source projects
- ✅ Fork, modify, redistribute under AGPL
- ✅ Run on your own hardware (the whole point)
- ❌ Use in a closed-source commercial product without [a commercial licence](LICENSE-COMMERCIAL.md)
- ❌ Re-sell or sublicence the source under terms other than AGPL

For commercial / closed-source use:
- [LICENSE-COMMERCIAL.md](LICENSE-COMMERCIAL.md) — standard commercial terms
- [ENTERPRISE-SOURCE-LICENSE.md](ENTERPRISE-SOURCE-LICENSE.md) — enterprise tier with source access
- [SOURCE-VIEWER-LICENSE.md](SOURCE-VIEWER-LICENSE.md) — read-only source viewing tier
- Or email <miryalas@gmail.com>

---

## Contributing

Read [docs/oss-launch/CONTRIBUTING.md](docs/oss-launch/CONTRIBUTING.md)
and sign the [CLA](docs/oss-launch/CLA.md) before submitting your first
PR. Small bug fixes don't require a CLA; any non-trivial contribution
does.

---

## Where to look first

| You want to… | Go to |
|---|---|
| **Try the product** | [hub.linus-ai.com](https://hub.linus-ai.com) — 14-day free trial, no credit card |
| **Buy a bundle** | [linus-ai.com/bundles.html](https://linus-ai.com/bundles.html) |
| **Understand pricing** | [linus-ai.com/bundles.html](https://linus-ai.com/bundles.html) + [linus-ai.com/sla.html](https://linus-ai.com/sla.html) |
| **Read the strategy** | [linus-hub/docs/strategy/omnisovereign-node.md](https://github.com/miryala3/linus-hub/blob/master/docs/strategy/omnisovereign-node.md) |
| **Build a product locally** | Open the product's directory + read its README |
| **Build the whole tree** | `bash build.sh` (orchestrator) |
| **Contribute** | [docs/oss-launch/CONTRIBUTING.md](docs/oss-launch/CONTRIBUTING.md) |
| **Report a bug** | [support@linus-ai.com](mailto:support@linus-ai.com) — SLAs at [/sla.html](https://linus-ai.com/sla.html) |
| **Enterprise inquiry** | [linus-ai.com/enterprise](https://linus-ai.com/enterprise.html) |
| **Lost your key** | [linus-ai.com/reset](https://linus-ai.com/reset.html) |

---

© 2026 Sunil Miryala / LINUS-AI. All product names + trademarks are
property of their respective owners. AGPL-3.0 open-core; commercial
licensing available.
