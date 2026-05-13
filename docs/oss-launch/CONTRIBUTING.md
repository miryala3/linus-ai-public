# Contributing to LINUS-AI

We welcome PRs! LINUS-AI is built and used by a small team; outside contributions
have made several features substantially better. To keep the review queue
honest, please read this short guide before opening a PR.

## TL;DR

1. **Discuss before building.** For anything >50 lines or that touches public
   APIs / DB schemas, open a [GitHub Discussion](https://github.com/miryala3/linus-ai-public/discussions)
   or an issue first. We will tell you within 48 hours whether we'd merge it.
2. **Sign the CLA.** Comment `I have read and agree to the CLA` on your first
   PR. The CLA is in [CLA.md](./CLA.md) — it's short.
3. **Match the existing style.** Don't reformat unrelated lines. Prettier &
   rustfmt configs are in the repo; run them before pushing.
4. **Add a test where it makes sense.** Bug fixes always need a regression test.
   Features need at least a smoke test.
5. **One logical change per PR.** Refactors and behavior changes go in separate
   PRs. Mixed PRs get sent back.

## What we want

- **Bug fixes** — almost always merged after review.
- **Backend connectors** — new RAG sources, new model providers, new LLM
  inference backends. We'll review fast.
- **Translations** — every UI string lives in `src/i18n/`. Adding a new
  language is a 1-2 day project.
- **Test coverage** — anywhere our coverage is < 70%.
- **Docs** — typos, clarifications, new how-to guides.

## What we'll probably reject

- **Switching frameworks** (React → Solid, Tauri → Electron, FastAPI →
  Flask) — too disruptive, will be a hard sell.
- **Breaking API changes** without a migration path AND deprecation period.
- **Telemetry / phone-home features** — LINUS-AI is local-first; please don't.
- **Adding cloud dependencies** to local-first components. Local code stays
  local.
- **Reformatting commits** that don't change behavior.

## Project layout

```
linus-ai-public/
├── linus-ai/             # Inference engine (Rust + Python bridge)
├── linus-bizcore/        # Business OS frontend + backend
├── linus-aiMED/          # Medical AI suite
├── linus-hub/            # ChromeOS-style desktop Hub (React + Vite)
├── linus-*/              # Other apps (Pulse, Trips, Forge, ConnectX, etc.)
├── shared/               # @miryala3/linus-shared TS package
│   ├── runtime/          # Tauri shell runtime
│   ├── license/          # LicenseGate component + JWT helpers
│   └── api/              # Typed API client
└── docs/                 # User + developer docs
```

The proprietary **license server** lives in a separate `linus-ai-private` repo
and is NOT open-source. The Hub talks to it via a documented HTTP API; you
can self-host an alternative that implements the same API.

## Development setup

```sh
# Mac / Linux
git clone https://github.com/miryala3/linus-ai-public
cd linus-ai-public
./scripts/bootstrap.sh   # installs Rust, Node 22, system deps
./scripts/build-all.sh   # builds every component for current host

# Hub PWA only (fastest iteration)
cd linus-hub
bun install
bun run dev              # http://localhost:5173
```

For inference backends you'll want `linus-ai` (the core) running on a peer
with a real GPU. The cloud demo backend at `linus-hub/scripts/demo-backend/`
is enough for UI development.

## Code style

- **Rust** — `cargo fmt` (group_imports = "StdExternalCrate") + `cargo clippy
  --workspace --all-targets`. CI gates on both.
- **TypeScript** — Prettier (single quotes, no semicolons in JSX attrs) + ESLint
  (`bun run lint`). TypeScript strict mode; no `any` unless commented why.
- **Python** — `ruff format` + `ruff check`. Type hints required on public APIs.
- **Commits** — present tense, ≤72 chars subject, body wrapped at 72. No
  `[skip-ci]` unless coordinated.

## Review timing

- **First response**: ≤ 3 business days. If we forget, ping with `@miryala3`.
- **Second-round review**: ≤ 2 business days after you push fixes.
- **Merge**: same week if green.

## Questions

Open a [GitHub Discussion](https://github.com/miryala3/linus-ai-public/discussions)
or email <oss@linus-ai.com>. We reply.

## Releases

We tag releases monthly (first Monday). Patch releases can go out any day. The
Hub and per-app PWAs ship together; per-app desktop binaries ship from each
app's `release.yml` workflow.
