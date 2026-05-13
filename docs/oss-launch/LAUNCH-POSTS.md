# LINUS-AI launch posts — drafts

All drafts below are written for the **AGPL open-core launch + Founding
Member tier**. Sub them in, edit names/links as needed, and post when the
deployment is ready.

---

## 1. Hacker News — "Show HN"

**Title** (80 char limit):
```
Show HN: LINUS-AI – Private clinical AI suite, AGPL-3.0, runs on your hardware
```

**URL field**:
```
https://linus-ai.com
```

**Text (or first comment)**:

> Hi HN — I'm Sai. After 18 months of iterating, I'm releasing the LINUS-AI
> open-core suite under AGPL-3.0.
>
> Short version: hospitals (and a few law firms / accounting practices) kept
> telling me they wanted GPT-grade tools but uploading patient charts or
> client docs to a vendor cloud was a non-starter. So I built the
> opposite-of-that: a desktop Hub that talks to a self-hosted inference
> mesh on your own hardware. Mac Studios + GPU boxes + laptops all stitched
> together by Tailscale.
>
> It ships 12 apps under one license — medical first (SOAP notes,
> differential dx, lab/path/radiology interpretation, HIPAA §164.312(b)
> audit log), then BizCore (CRM/HR/finance), Pulse (personal AI), Trips,
> Forge, ConnectX, Reserve, Day, P2P Network, and Corridor (cross-border
> payments, still early).
>
> The Hub runs in the browser at https://hub.linus-ai.com — there's a
> public demo backend that returns canned-but-realistic responses so you
> can poke around the UI without installing anything. The desktop bundle
> (macOS arm64 today, Windows/Linux beta) is at /download.
>
> Open-core split:
>
>   • AGPL-3.0: every app, the inference engine, the Hub, the mesh runtime,
>     browser extensions.
>   • Proprietary: the license-issuing server (you can self-host an
>     alternative that speaks the same HTTP API).
>   • Commercial dual-license waives AGPL §13 — for hosted-SaaS use cases.
>
> Pricing: $19/mo Founding Member (capped at first 1,000), $49/mo public,
> $490/yr. Free 14-day trial. AGPL self-host obviously free.
>
> Things I'm proud of:
>
>   • 70B-class models run on a single Mac Studio, no quantization tricks
>     beyond standard int8/awq
>   • Cross-OS data layout — apps use the same files whether you launched
>     from PWA, Tauri desktop, or CLI
>   • SSO via license-key → Ed25519 JWT, no third-party identity provider
>
> Things that are NOT done:
>
>   • Windows code-signing pipeline
>   • iOS / Android (planned Q4)
>   • EHR connectors (FHIR works for import; Epic/Cerner planned Q4 with
>     pilot partners)
>   • Audit log is local-only; we don't centralize logs (deliberate but
>     means no fleet view yet)
>
> I'd love to hear what would make this useful to your team. Especially
> from people doing self-hosted LLMs already — what's the friction that
> killed adoption for you?
>
> Source: https://github.com/miryala3/linus-ai-public
> Roadmap: https://linus-ai.com/roadmap.html
> Trial: https://linus-ai.com/start
>
> AMA below.

---

## 2. Reddit — r/selfhosted

**Title**:
```
LINUS-AI: 12-app local-first suite (Hub PWA + desktop, AGPL-3.0). Tailnet-meshed inference. Launch + asking for feedback.
```

**Body**:

> Hey r/selfhosted — long-time lurker, first real post.
>
> I just open-sourced LINUS-AI under AGPL-3.0. It's a ChromeOS-style desktop
> Hub that gives you a dozen apps (medical AI, business OS, personal AI,
> trips, forge, p2p network, etc.) all driven by a local inference mesh.
>
> Why I think this might be interesting to you:
>
>   1. **No vendor accounts required.** No OpenAI key, no Anthropic key.
>      Stand up `linus-ai` on a single box and the Hub finds it. Add more
>      peers via Tailscale and it tensor-parallels across them.
>   2. **Data layout is `~/.linus/<app>/` consistently.** Pulling backups
>      is `tar -czf linus-backup.tgz ~/.linus/` and you've got everything.
>   3. **The Hub talks OpenAI-compatible /v1.** Drop-in replacement for
>      apps that already speak that protocol.
>   4. **The license server is open-API.** You can self-host an alternative
>      that speaks the same HTTP contract and never pay us.
>
> What's NOT solved yet for self-hosters specifically:
>
>   • Docker compose for one-box deploy (planned this month)
>   • k8s manifests (planned, looking for help)
>   • Auto-update channel for self-hosted Hub bundle
>
> If anyone wants to kick the tires, the Hub PWA runs in your browser at
> hub.linus-ai.com with a canned demo backend. Real local mesh requires
> the desktop bundle from /download.
>
> Repo: github.com/miryala3/linus-ai-public
> Bug reports VERY welcome. Especially deployment friction.

---

## 3. Reddit — r/medicine (or r/medicalpractice — read each sub's rules first)

**Title**:
```
[Tool] Open-source local AI for clinical work (SOAP notes, DDx, radiology assist) — no PHI ever leaves your network. Feedback wanted from clinicians.
```

**Body**:

> Throwaway-adjacent post (main account is on the repo). I'm a software
> engineer who spent the last 18 months building local-first clinical AI
> after my mother-in-law's clinic asked "why can't we use ChatGPT-grade
> tools without uploading patient charts to OpenAI." This is the AGPL-3.0
> release.
>
> What it does, today:
>
>   • SOAP note generator from your dictated context
>   • Differential diagnosis assistant with structured workup recs
>   • Medication interaction review
>   • Triage assessment (ESI 1-5)
>   • Discharge summary generator
>   • Lab / pathology interpretation (CBC, CMP, micro sensitivity)
>   • Radiology AI (CXR / CT structured-report assist, protocol selection)
>   • HIPAA §164.312(b) audit log (who/what/when/where, exportable)
>
> Architectural commitments:
>
>   • Everything runs on hardware you own (Mac Studio, GPU server, or even
>     a beefy laptop for smaller models). 70B-class model fits on a maxed
>     Mac Studio.
>   • No PHI in network transit to any third party. The Hub talks to your
>     local inference mesh over Tailscale.
>   • Audit log is local-only on purpose — we cannot subpoena your own log.
>   • All AI outputs are flagged "clinician verification required" and
>     can't be auto-signed.
>
> What it ISN'T:
>
>   • Not a replacement for clinician judgment. It's a draft generator.
>   • Not currently HIPAA-BAA-eligible from us as a vendor — you're
>     self-hosting, you're the covered entity.
>   • Not FDA-cleared. Documentation assistance only, no diagnostic claims.
>
> Free 14-day trial: linus-ai.com/start
> Self-host (AGPL): github.com/miryala3/linus-ai-public
> Try in browser (canned demo, no signup): hub.linus-ai.com → Medical
>
> Specifically asking clinicians: what workflows in your day would actually
> be helpful here? I want to build the right things, not the impressive
> things.

---

## 4. Reddit — r/LocalLLaMA

**Title**:
```
LINUS-AI [AGPL-3.0]: Hub PWA + 12 apps + Tailnet-meshed inference on Mac Studio / GPU peers. Asking for routing/perf critique.
```

**Body**:

> r/LocalLLaMA folks — sharing what I shipped today and asking for the
> kind of hard technical feedback I trust this sub for.
>
> Setup that works for me:
>
>   • Mac Studio M2 Ultra 192GB as the coordinator running a 70B reasoner
>     (int8 via mlx-lm)
>   • HP Z440 with 2× RTX A6000 as a tensor-parallel peer for batch
>   • Two laptops as "lite" peers for cheap chat
>   • Tailscale glues them together; the Hub PWA hits whichever is closest
>     by latency
>
> What I'd love your eyes on:
>
>   1. The peer-selection logic in `linus-ai/orchestrator/peer_router.rs` —
>      currently a hand-rolled latency-first + capacity-aware scheme.
>      I suspect there's prior art I'm reinventing.
>   2. The OpenAI-compatible /v1 surface — am I missing endpoints that
>      common clients require?
>   3. The streaming SSE protocol in the Hub — works but feels hand-rolled.
>
> If anyone has tried Distributed Llama / vLLM / Ollama in a multi-machine
> mesh and wants to share what broke for you, I'd love to hear.
>
> Source: github.com/miryala3/linus-ai-public
> Browser demo (canned): hub.linus-ai.com

---

## 5. 90-second demo video — narrated script

> [0:00 - opening shot of Hub PWA loading in Chrome]
>
> "This is LINUS-AI. It's a private AI suite — 12 apps — that runs entirely
> on your own hardware."
>
> [0:08 - cursor moves across the Hub launcher icons: Medical, Business,
> Personal]
>
> "Medical, business, personal. One license. Twelve apps."
>
> [0:14 - click into Medical → Clinical AI tab]
>
> "Here's the clinical workflow. Differential diagnosis, SOAP notes,
> radiology reads, lab interpretation. Same shape as ChatGPT or Claude,
> but every token of inference happens on your hardware, not ours."
>
> [0:24 - type a clinical scenario into the SOAP tool, watch it stream]
>
> "Watch the response stream. No third-party API key. No PHI in transit.
> The Hub is talking to a 70B model on the Mac Studio under my desk."
>
> [0:38 - click into Audit Log tab, scroll through the table]
>
> "Every access is logged here, locally. HIPAA §164.312(b). We can't
> subpoena your own log because we never see it."
>
> [0:46 - click into Business → BizCore → Inventory]
>
> "Same Hub, different app — BizCore for businesses. Inventory, CRM, HR,
> finance. AI demand forecasting. All on your hardware."
>
> [0:55 - cut to Personal → Forge → LiveNode]
>
> "And Forge for product teams. Design briefs, strategy, model evaluation."
>
> [1:04 - back to launcher, hover over Founding Member badge]
>
> "Open-core under AGPL-3.0. Free to self-host. Paid hosted tier starts at
> $19 a month for the first thousand customers, lifetime."
>
> [1:12 - Hub closes, browser shows linus-ai.com/start]
>
> "Try it free for 14 days at linus-ai.com/start. Source at
> github.com/miryala3/linus-ai-public. I'm one engineer — I'd love your
> feedback."
>
> [1:25 - logo + URL frame, hold for 5s]
>
> "LINUS-AI. Private AI you actually own."

Total: 90 seconds. Filming notes: screen-recording at 1080p, narration over,
slight zoom-pulse on tab transitions, monospaced caption overlay for each app
name. Background music: nothing or very faint synth — content carries it.

---

## Posting checklist

- [ ] Confirm hub.linus-ai.com demo backend is live and returning
- [ ] Confirm /start has the Founding Member card and PayPal plan id wired
- [ ] Confirm github.com/miryala3/linus-ai-public is public, README.md is the new one
- [ ] Confirm /roadmap.html is reachable from nav
- [ ] Post HN at 9:30 AM ET on a Tuesday or Wednesday
- [ ] Post Reddit posts staggered, NOT same hour as HN
- [ ] Upload demo video to YouTube + embed in /index.html hero
- [ ] Have laptop open + responses drafted for top-of-thread questions
