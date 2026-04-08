# LINUS-AI — Technical Specification

**INIA — Integrated Node Integration Architecture · v1.4.0**

> Universal mesh AI platform. Every node type, every protocol, zero-trust security,
> minimal configuration.

---

## Table of Contents

1. [Architecture Overview](#1-architecture-overview)
2. [Node Taxonomy & Scoring](#2-node-taxonomy--scoring)
3. [Role Hierarchy](#3-role-hierarchy)
4. [Module Reference](#4-module-reference)
5. [HTTP API Reference](#5-http-api-reference)
6. [Mesh & Overlay Protocol](#6-mesh--overlay-protocol)
7. [Security Model](#7-security-model)
8. [Inference Pipeline](#8-inference-pipeline)
9. [py2c User Scripts](#9-py2c-user-scripts)
10. [Integration Catalog](#10-integration-catalog)
11. [Task Job Format](#11-task-job-format)
12. [Tensor Parallelism](#12-tensor-parallelism)
13. [Compliance & Security](#13-compliance--security)
14. [RAG Document Access Control](#14-rag-document-access-control)
15. [Changelog](#15-changelog)

---

## 1. Architecture Overview

```
┌──────────────────────────────────────────────────────────────────────┐
│  LINUS-AI Node                                                           │
│                                                                       │
│  ┌─────────┐  ┌──────────┐  ┌─────────┐  ┌──────────┐  ┌────────┐  │
│  │ linus_ai-  │  │ linus_ai-   │  │ linus_ai-  │  │ linus_ai-   │  │linus_ai-  │  │
│  │  http   │  │   ai     │  │  net    │  │  vault   │  │guardian│  │
│  │(axum API│  │(inference│  │(mDNS+   │  │(encrypted│  │(2FA +  │  │
│  │ + SSE)  │  │ engine)  │  │ TCP)    │  │ SQLite)  │  │ TOTP)  │  │
│  └────┬────┘  └────┬─────┘  └────┬────┘  └────┬─────┘  └───┬────┘  │
│       └────────────┴─────────────┴─────────────┴────────────┘        │
│                            linus-ai-core                                 │
│                  (EventBus · Config · Crypto · Types)                 │
│                                                                       │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────────────────┐ │
│  │ linus_ai-   │  │ linus_ai-   │  │ linus_ai-   │  │     linus-ai-bin        │ │
│  │ thermal  │  │  task   │  │blockchain│  │  (main.rs entrypoint)│ │
│  └──────────┘  └──────────┘  └──────────┘  └──────────────────────┘ │
└──────────────────────────────────────────────────────────────────────┘
         │ HTTP :9480                           │ TCP :9479
         ▼                                      ▼
   Browser / API clients              Mesh peers (mDNS + Tailscale)
```

**Core design principles:**

- **Zero-config discovery** — UDP multicast on port 9479, auto-role from hardware score
- **Zero-trust security** — every mesh message HMAC-SHA256 signed; vault data ChaCha20-AEAD encrypted
- **Single integration point** — one HTTP API (`/infer`, `/jobs`, `/settings`) for all connected software
- **Role-aware routing** — tasks automatically route to the best available hardware
- **py2c scripting** — any automation expressible in a type-annotated `.py` file, compiled to native

---

## 2. Node Taxonomy & Scoring

| # | Type | Examples | Typical Role |
|---|------|----------|--------------|
| 1 | IoT Device | Smart sensors, soil probes | `edge` |
| 2 | Edge Gateway | Raspberry Pi, Jetson Nano | `spoke` |
| 3 | Cloud VM | AWS EC2, GCP CE, Azure VM | `hub` / `master_hub` |
| 4 | Workstation | Mac Studio, threadripper | `hub` / `master_hub` |
| 5 | Mobile | Android ARM64, iOS | `edge` |
| 6 | 5G Device | gNB, CPE, mmWave AP | `spoke` |
| 7 | Industrial | PLC, SCADA server | `spoke` |
| 8 | Browser | WASM node | `edge` |

### Hardware Scoring (automatic)

```
composite = RAM_score + GPU_score + Model_score − Thermal_penalty − Load_penalty

RAM:  ≥64 GB = 40  ·  ≥32 GB = 30  ·  ≥16 GB = 20  ·  ≥8 GB = 10  ·  <8 GB = 5
GPU:  CUDA = 35  ·  Metal = 30  ·  ROCm = 25  ·  Vulkan = 15  ·  CPU-only = 0
```

---

## 3. Role Hierarchy

```
master_hub  (score ≥ 80)
├── hub     (score ≥ 50)
│   ├── worker   (score ≥ 20)
│   │   └── edge (score < 20)
│   └── student  (learning mode, any score)
└── spoke   (remote/WAN node)
```

Role assignments are automatic on peer connect. Override via:

```bash
curl -X POST http://localhost:9480/mesh/assign-roles
# or manually:
curl -X POST http://localhost:9480/models/roles \
  -d '{"main":"qwen2.5-7b-instruct.gguf","router":"llama-3.2-3b.gguf"}'
```

---

## 4. Module Reference

### linus-ai-core
- `EventBus` — async pub/sub backbone (tokio broadcast channels)
- `LinusAIConfig` — single config struct; all settings + env var overrides
- Crypto primitives: `chacha20_encrypt/decrypt`, `aead_encrypt/decrypt`, `pbkdf2_key`, `sign_message`, `verify_signature`, `merkle_root`
- Types: `NodeRole`, `Priority`, `TaskState`, `ThermalState`

### linus-ai-net
- `MeshNetwork` — Tailscale peer discovery + mDNS multicast (224.0.0.251:5353) + TCP wire
- Wire protocol: 4-byte length-prefixed frames, HMAC-SHA256 auth, heartbeats every 30 s
- Auto-role assignment on new peer connect
- Auto-push largest fitting GGUF to peers with 0 models and ≥ 4 GB RAM

### linus-ai-inference
- `ModelManager` — GGUF format parser (zero deps), scan/load/hot-swap
- `InferenceEngine` — thermal-aware request batching + SSE streaming
- Backend selected at **compile time** via Cargo feature flags (set by `build.sh`):
  - `llama-bundled` *(default)* — statically linked llama.cpp; Metal/CUDA GPU auto-enabled
  - `candle-only` — pure-Rust HuggingFace candle; safe for all cross-compilation targets
  - *(no features)* — subprocess fallback: `llama-server` HTTP → `ollama` HTTP → `llama-cli` → error

### linus-ai-http
- Axum HTTP server on `:9480`
- SSE streaming for `/infer/stream` and `/agent/stream`
- Hardware detection (`/hardware`)
- Multi-part upload with PDF/DOCX/TXT extraction (`/upload`)

### linus-ai-vault
- `VaultDB` — per-row ChaCha20+HMAC-SHA256 AEAD encrypted SQLite
- Key hierarchy: OS keychain → DPAPI (Win) → Secret Service (Linux) → PBKDF2+file (0600)
- Audit hash chain; optional Guardian 2FA gate per operation

### linus-ai-guardian
- `Guardian` — 2FA, TOTP (RFC 6238), sessions, bank-style auth gates
- `create_user`, `login`, `verify_totp`, `enroll_totp`
- Auth gates: `create_gate` → `approve_gate(gate_id, totp_code)`

### linus-ai-thermal
- `ThermalGovernor` — 5-stage machine:

  | State | Temp | Action |
  |---|---|---|
  | NOMINAL | < 70 °C | Normal operation |
  | THROTTLE | 70–79 °C | Reduce batch size |
  | HOT | 80–84 °C | Route new requests to peers |
  | CRITICAL | 85–89 °C | Queue only, no new inference |
  | EMERGENCY | ≥ 90 °C | HTTP 503, drain queue |

### linus-ai-task
- `TaskScheduler` — distributed job scheduler (LINUS-AI native format)
- Job types: `service`, `batch`, `system`
- Allocation scoring: hardware composite + thermal state + current load
- See [examples/](examples/) for job JSON templates

### linus-ai-blockchain
- `TransparencyLedger` — append-only SHA-256 hash chain in SQLite
- Every inference request, model load, and peer event logged
- `GET /blockchain/entries?limit=100` — audit trail

### linus_ai.compliance (Python)
- Domain-specific compliance enforcement for 14 industry profiles across 4 tiers (OPEN/AUDIT/REGULATED/RESTRICTED)
- `PIIScanner` — 12 PII types; CREDIT_CARD/CVV/SSN/PAN_LIKE block; others redact+warn
- `InjectionDetector` — 8 rule families; RESTRICTED hard-blocks; REGULATED warns
- `ConsentManager` — REGULATED/RESTRICTED require explicit user consent; stored in `~/.linus-ai/consent.json`
- `AuditLogger` — HMAC-SHA256 chained monthly `.jsonl` files; `verify_chain()` detects tampering; `seal_completed_months()` applies OS-level immutability (chmod 0o400 + macOS UF_IMMUTABLE + Linux chattr +i); `export_to(dest_dir)` for point-in-time snapshots
- Env vars: `LINUS_AI_AUDIT_DIR` (primary), `LINUS_AI_AUDIT_EXPORT_DIRS` (colon-separated SIEM sinks)

### linus_ai.rag_access (Python)
- Fine-grained RAG document access control with 5 classification levels (PUBLIC → TOP_SECRET)
- `DocumentACL` — allow/deny lists at user, role, department, division, company scope
- `RAGAccessController` — 7-step decision algorithm; explicit DENY always wins
- `filter_rag_chunks()` — filters a list of RAG chunks to only those the principal may read
- `RAGAuditLogger` — same HMAC-chain format as compliance audit; propagates to export dirs
- `DocumentRegistry`, `PrincipalRegistry` — JSON-backed persistent stores

---

## 5. HTTP API Reference

All endpoints on `http://localhost:9480` (port configurable via `LINUS_AI_API_PORT`).

### Inference

```
POST /infer
POST /infer/stream          (SSE — streams tokens)

Body: { "prompt": "...", "max_tokens": 512, "temperature": 0.7,
        "model": "optional-override.gguf" }
SSE events: {"token":"..."} ... {"type":"done","tokens":N}
```

### Agent (ReAct loop)

```
POST /agent/stream          (SSE — streams thought/action/observation/tokens)

Body: { "message": "...", "profile": "general", "history": [],
        "session_id": "optional", "allow_web_search": false }

SSE event types:
  {"type":"peer_start","peer":"addr:port","hostname":"X","role":"worker"}
  {"type":"peer_result","peer":"addr","text":"...","tokens":N}
  {"type":"thought","text":"..."}
  {"type":"action","tool":"search","args":"..."}
  {"type":"observation","text":"..."}
  {"type":"local_result","text":"..."}
  {"type":"synthesis_start","sources":N}
  {"token":"..."}
  {"type":"stats","tokens":N,"sources":N,"routed_to":"multi"}
```

### Models

```
GET  /models                       list loaded models + metadata
POST /models/roles                 set {main, router, student, worker}
GET  /models/roles                 get current role assignments
POST /models/load    {"model":"name.gguf"}
POST /models/unload  {"model":"name.gguf"}
GET  /models/recommend             hardware-aware catalog (22 curated models)
POST /models/auto-push             push best GGUF to peers with 0 models
```

### Mesh

```
GET  /peers                        connected peer list
POST /mesh/assign-roles            score peers, assign hub/worker/student
POST /mesh/push-model  {"peer":"addr:port","model":"name.gguf"}
```

### Vault & Guardian

```
POST /vault/store   {"key":"...", "value":{...}}
GET  /vault/get     ?key=...
POST /guardian/login    {"username":"...","password":"..."}
POST /guardian/totp     {"gate_id":"...","code":"123456"}
```

### Status & Monitoring

```
GET  /status        node overview (mode, peers, models, uptime)
GET  /stats         inference stats (requests, tokens, latency p50/p95/p99)
GET  /thermal       thermal state + temperature
GET  /hardware      AI capability score, RAM/GPU/NPU detail
GET  /blockchain/entries
GET  /jobs          running scheduled jobs
```

### Compliance & Security

```
GET  /compliance/preflight?text=...&profile=...    run PII + injection checks
GET  /compliance/profiles                          list 14 profiles with metadata
POST /compliance/consent  {user_id, action, profile}
GET  /compliance/consent?user_id=...
GET  /compliance/audit?limit=N&profile=...
GET  /compliance/audit/verify
POST /compliance/audit/seal
POST /compliance/audit/export  {dest_dir}
```

### RAG Document Access Control

```
GET    /rag/documents
POST   /rag/documents/register   {title, path, owner_user_id, classification, ...}
PUT    /rag/documents/{id}/acl   {allow_users[], deny_users[], allow_companies[], ...}
PUT    /rag/documents/{id}/classification  {classification}
DELETE /rag/documents/{id}
POST   /rag/access-check  {user_id, doc_id}
GET    /rag/principals
POST   /rag/principals    {user_id, name, clearance, company, division, department, roles[]}
DELETE /rag/principals/{user_id}
GET    /rag/audit?doc_id=...&user_id=...&denied_only=true&limit=N
```

### Agent Profiles

```
GET /agent/profiles    list all 14 profiles

Profiles:
  OPEN:       general · creative · reasoning · code · engineering
  AUDIT:      education · support · sales · data_science
  REGULATED:  medical · legal · finance · hr
  RESTRICTED: security
```

---

## 6. Mesh & Overlay Protocol

### LAN Discovery (mDNS)

Peers announce via UDP multicast to `224.0.0.251:5353`.
Announcement payload (JSON):

```json
{
  "node_id": "0c98b072-23b1-47d6-a1e3-...",
  "hostname": "macstudio",
  "api_port": 9480,
  "mesh_port": 9479,
  "ts": 1741600000,
  "auth": "HMAC_SHA256(mesh_secret, node_id + ':' + ts)"
}
```

### WAN Overlay Relay

For nodes that cannot reach each other directly (NAT, firewall):

```
Node A ──TCP──► Relay Server ──TCP──► Node B
                 :9777
```

**Start a relay server:**

```bash
# Using the LINUS-AI binary (no Go, no Python):
./linus_ai --mode relay --listen 0.0.0.0:9777 --mesh-secret YOUR_SHARED_SECRET

# systemd (Linux):
cp linus-ai-rs/packaging/linux/linus-ai.service ~/.config/systemd/user/
# Edit ExecStart to add: --mode relay --listen 0.0.0.0:9777
systemctl --user enable --now linus_ai
```

**Connect through a relay:**

```bash
./linus_ai --overlay --overlay-server relay.example.com:9777 --mesh-secret YOUR_SHARED_SECRET
```

**Overlay wire protocol (newline-delimited JSON over TCP):**

Node → relay message types: `register`, `heartbeat`, `peers`, `relay`
Relay → node message types: `registered`, `pong`, `peers`, `relay`, `relay_ack`, `error`

Registration handshake:

```json
// Node → relay
{
  "type": "register",
  "node_id": "...",
  "hostname": "macstudio",
  "listen_port": 9479,
  "api_port": 9480,
  "ts": 1741600000,
  "auth": "HMAC_SHA256(mesh_secret, node_id + ':' + ts)",
  "cap": {"ram_gb": 192, "gpu": "metal", "models": 3}
}

// Relay → node
{"type": "registered", "peers": [...]}
```

---

## 7. Security Model

### Mesh Authentication

Every message between mesh peers carries an HMAC-SHA256 signature:

```
auth = HMAC-SHA256(key=mesh_secret, msg=node_id + ':' + unix_timestamp)
```

Peers reject messages with: wrong signature · timestamp delta > 60 s · unknown node_id.

Change the mesh secret (all nodes must use the same value):

```bash
./linus_ai --mesh-secret "$(openssl rand -hex 32)"
# or via env:
export LINUS_AI_MESH_SECRET="$(openssl rand -hex 32)"
```

### Vault Encryption

Each vault record is encrypted independently:

```
key  = PBKDF2-HMAC-SHA256(passphrase, salt, 260 000 iterations) → 32 bytes
nonce = random 12 bytes (stored with record)
ciphertext = ChaCha20(key, nonce, plaintext)
tag  = HMAC-SHA256(key, nonce + ciphertext)
```

The vault passphrase is stored in the OS keychain (macOS Keychain · Windows DPAPI · Linux Secret Service). Falls back to a 0600-permission file if no keychain is available.

### Guardian 2FA

Guardian wraps any sensitive operation in an auth gate:

```bash
# Enroll TOTP (works with Google Authenticator, Authy, etc.)
POST /guardian/enroll-totp  {"username": "admin"}
# → {"qr_uri": "otpauth://totp/LINUS-AI:admin?secret=BASE32SECRET&issuer=LINUS-AI"}

# Create an auth gate (e.g., before a model push)
POST /guardian/gate/create  {"operation": "model_push", "session_id": "..."}
# → {"gate_id": "abc123"}

# Approve the gate
POST /guardian/gate/approve  {"gate_id": "abc123", "totp_code": "123456"}
# → {"approved": true}
```

### TLS

The HTTP API is plain HTTP by default (LAN-only recommendation).
For WAN exposure, terminate TLS in nginx or caddy (see `packaging/linux/linus-ai.service`).

---

## 8. Inference Pipeline

```
Request
  │
  ▼
ThermalGovernor ──EMERGENCY?──► HTTP 503
  │
  ▼ (NOMINAL / THROTTLE / HOT)
MeshRouter
  ├─ score peers (composite − load − thermal)
  ├─ HOT state? → prefer peers
  ├─ THROTTLE?  → reduce batch_size
  └─ local?     → InferenceEngine
                      │
                      ▼
              Backend selection
              llama-bundled (default) ← compile-time feature
              candle-only             ← compile-time feature
              subprocess fallback:
                llama-server → ollama → llama-cli → error
                      │
                      ▼
              SSE token stream → HTTP client
                      │
                      ▼
              TransparencyLedger (log event)
```

### Agent ReAct Loop

```
user message
  │
  ▼
fan-out to ≤ 3 peers (Connected, load < 80%, models > 0, score ≥ 35)
  │                  │
  ▼ peer results     ▼ local ReAct
thought → action → observation → thought → ... → local_result
  │
  ▼
synthesis (hub combines all peer results + local result)
  │
  ▼
SSE token stream
```

Tools available in agent mode: `search` (3-tier: Google News RSS → DDG HTML → DDG Instant),
`infer_peer`, `vault_read`, `vault_write`, `thermal_status`.

---

## 9. py2c User Scripts

`py2c` translates a Python-subset to C17, compiles with the platform toolchain, and links
against `nxrt.h` (zero-dependency C17 runtime). The same `.py` file runs interpreted
(`python3 script.py`) and compiles to any of 11 targets (`linus_ai compile script.py --target all`).

### Language subset

**Supported:**
- Type annotations on all function parameters and local variables (required for compiled path)
- `int`, `float`, `bool`, `str`, `bytes`, `list[T]`, `Optional[T]`
- All arithmetic, bitwise, comparison, and boolean operators
- `if` / `elif` / `else`, `while`, `for` with `range()`
- `break`, `continue`, `pass`, `assert`
- `@dataclass` classes, `match` / `case` (Python 3.10+)
- f-strings, walrus operator `:=`
- `import linus_ai` — resolves to `#include "nxrt.h"`
- `@linus_ai.native` decorator — raw C passthrough (escape hatch)

**Not supported (compile path):**
- `*args`, `**kwargs`
- Closures capturing mutable outer variables
- `try` / `except` (use `NxResult` return type)
- Dynamic attribute access
- Third-party imports

### Example: LINUS-AI API poller

```python
# poll_health.py
import linus_ai

ENDPOINT: str = "http://127.0.0.1:9480/status"
INTERVAL_MS: int = 5000

def check() -> int:
    resp: str = linus_ai.http_get(ENDPOINT)
    if linus_ai.str_contains(resp, "\"ok\":true"):
        print("LINUS-AI OK")
        return 0
    print("LINUS-AI NOT OK: " + resp)
    return 1

def main() -> int:
    while True:
        check()
        linus_ai.sleep_ms(INTERVAL_MS)
    return 0

if __name__ == "__main__":
    main()
```

```bash
# Run interpreted
python3 poll_health.py

# Compile to all targets
linus_ai compile poll_health.py -o poll_health --target all
```

### Example: Vault write with HMAC auth

```python
# vault_writer.py
import linus_ai

VAULT_URL: str = "http://127.0.0.1:9480/vault/store"
SECRET: str    = "linus-ai-default-mesh-secret"   # set via env in production

def make_auth(node_id: str, ts: int) -> str:
    msg: str = node_id + ":" + linus_ai.to_str(ts)
    return linus_ai.hmac_sha256_hex(SECRET, msg)

def write_record(key: str, value: str) -> int:
    node_id: str = linus_ai.node_id()
    ts: int      = linus_ai.unix_now()
    auth: str    = make_auth(node_id, ts)
    body: str    = '{"key":"' + key + '","value":"' + value + '","auth":"' + auth + '"}'
    resp: str    = linus_ai.http_post_json(VAULT_URL, body)
    print("vault response: " + resp)
    return 0

def main() -> int:
    return write_record("sensor_temp", "23.4")

if __name__ == "__main__":
    main()
```

### Example: Mesh status watcher

```python
# mesh_watch.py
import linus_ai

API: str = "http://127.0.0.1:9480"

def peer_count(status_json: str) -> int:
    # count occurrences of "node_id" as proxy for peer count
    count: int = 0
    i: int = 0
    while i < linus_ai.str_len(status_json) - 7:
        if linus_ai.str_contains(linus_ai.str_slice(status_json, i, i + 7), "node_id"):
            count = count + 1
        i = i + 1
    return count

def main() -> int:
    print("Watching LINUS-AI mesh...")
    while True:
        status: str = linus_ai.http_get(API + "/peers")
        count: int  = peer_count(status)
        print("Peers online: " + linus_ai.to_str(count))
        linus_ai.sleep_ms(10000)
    return 0

if __name__ == "__main__":
    main()
```

---

## 10. Integration Catalog

LINUS-AI exposes a single HTTP API. Any software that can make HTTP requests integrates in
one step. The following recipes use `linus_ai compile` user scripts where automation is needed.

### Relational Databases

**PostgreSQL — AI-enhanced query explanation:**

```python
# pg_explain.py — compile with: linus_ai compile pg_explain.py -o pg_explain
import linus_ai

LINUS_AI_API: str = "http://127.0.0.1:9480/infer"
PG_API:    str = "http://127.0.0.1:5433/explain"   # PostgREST proxy

def explain_query(sql: str) -> str:
    plan: str  = linus_ai.http_post_json(PG_API, '{"sql":"' + sql + '"}')
    body: str  = '{"prompt":"Explain this PostgreSQL query plan:\\n' + plan + '","max_tokens":300}'
    return linus_ai.http_post_json(LINUS_AI_API, body)

def main() -> int:
    result: str = explain_query("SELECT * FROM orders WHERE created_at > NOW() - INTERVAL 1 DAY")
    print(result)
    return 0

if __name__ == "__main__":
    main()
```

### Message Queues

**Redis / Valkey — job queue consumer:**

```python
# redis_consumer.py
import linus_ai

REDIS:     str = "http://127.0.0.1:6380"   # Webdis HTTP bridge
LINUS_AI_API: str = "http://127.0.0.1:9480/infer"

def pop_job() -> str:
    return linus_ai.http_get(REDIS + "/BRPOP/linus_ai:jobs/5")

def process(job_json: str) -> str:
    body: str = '{"prompt":"Process this task: ' + job_json + '","max_tokens":512}'
    return linus_ai.http_post_json(LINUS_AI_API, body)

def main() -> int:
    print("Consumer started")
    while True:
        job: str    = pop_job()
        result: str = process(job)
        print("Result: " + result)
    return 0

if __name__ == "__main__":
    main()
```

### Monitoring & Observability

**Prometheus metrics exporter:**

```python
# prom_exporter.py
import linus_ai

API:  str = "http://127.0.0.1:9480"
PORT: int = 9481   # serve metrics on this port

def build_metrics() -> str:
    status:  str = linus_ai.http_get(API + "/status")
    thermal: str = linus_ai.http_get(API + "/thermal")
    out: str = "# HELP linus_ai_peers Connected mesh peers\n"
    out = out + "# TYPE linus_ai_peers gauge\n"
    out = out + "linus_ai_peers " + linus_ai.json_get(status, "peer_count") + "\n"
    out = out + "# HELP linus_ai_thermal_state Thermal state (0=nominal 4=emergency)\n"
    out = out + "linus_ai_thermal_state " + linus_ai.json_get(thermal, "state_int") + "\n"
    return out

def main() -> int:
    print("Serving metrics on :" + linus_ai.to_str(PORT))
    while True:
        metrics: str = build_metrics()
        linus_ai.http_serve_once(PORT, "/metrics", metrics)
    return 0

if __name__ == "__main__":
    main()
```

### Industrial / SCADA

**Modbus TCP → LINUS-AI bridge:**

```python
# modbus_bridge.py — reads holding registers, sends to LINUS-AI for anomaly analysis
import linus_ai

LINUS-AI: str   = "http://127.0.0.1:9480/infer"
PLC_IP: str  = "192.168.1.100"
PLC_PORT: int = 502

def read_registers() -> str:
    # Modbus TCP raw read (function code 0x03, 10 registers from address 0)
    req: bytes = linus_ai.bytes_from_hex("0001000000060103000A000A")
    resp: bytes = linus_ai.tcp_send_recv(PLC_IP, PLC_PORT, req)
    return linus_ai.bytes_to_hex(resp)

def analyze(raw: str) -> str:
    body: str = '{"prompt":"Analyze these Modbus holding register values for anomalies: ' + raw + '","max_tokens":200}'
    return linus_ai.http_post_json(LINUS-AI, body)

def main() -> int:
    while True:
        raw: str    = read_registers()
        result: str = analyze(raw)
        print("Analysis: " + result)
        linus_ai.sleep_ms(30000)
    return 0

if __name__ == "__main__":
    main()
```

---

## 11. Task Job Format

LINUS-AI uses its own task job format. Job JSON templates are in [examples/](examples/).

```json
// examples/immediate-sse.job.json
{
  "spec": {
    "id": "immediate-inference",
    "type": "batch",
    "task_groups": [{
      "name": "infer",
      "count": 1,
      "tasks": [{
        "name": "run",
        "config": {
          "prompt": "Summarize the LINUS-AI mesh architecture",
          "max_tokens": 512,
          "stream": true
        }
      }]
    }]
  }
}
```

```bash
# Submit
curl -X POST http://localhost:9480/jobs -d @examples/immediate-sse.job.json

# Status
curl http://localhost:9480/jobs

# Cancel
curl -X DELETE http://localhost:9480/jobs/<job_id>
```

**Available example jobs:**

| File | Description |
|---|---|
| `immediate-sse.job.json` | Single inference task, SSE stream |
| `callback-origin.job.json` | Callback to the originating node |
| `callback-external.job.json` | Callback to an external HTTP endpoint |
| `download-file.job.json` | Download a file then summarize |
| `agentic-loop.job.json` | Multi-step ReAct agent job |
| `fanout-handover.job.json` | Fan-out to multiple peers, aggregate results |
| `hive-training.job.json` | Federated learning round |
| `inference-service.job.json` | Long-running inference service |
| `p2p-solver.job.json` | Distributed P2P problem solving |

---

## 12. Tensor Parallelism

Tensor parallelism (TP) splits **individual weight matrices** across N nodes.
All nodes process the same token simultaneously — each holds 1/N of every
layer's weights and computes a partial result; results are reduced (summed)
across nodes after each transformer block.

Contrast with pipeline parallelism (already in LINUS-AI), which splits
the model's *layers* sequentially across nodes.  Both can be combined:
pipeline groups where each group uses tensor parallelism internally.

### Backends

| Backend | Mechanism | Requirement |
|---------|-----------|-------------|
| **RPC** (default) | llama.cpp `--rpc` + `llama-rpc-server` | `brew install llama.cpp` (≥ b2373) |
| **Native** | LINUS-AI AllReduce over HTTP (TNSR wire format) | No extra tools — Phase 2 |

### RPC mode operation

```
Coordinator (rank 0)                    Workers (rank 1…N-1)
─────────────────────                   ─────────────────────
POST /tensor/plan  ──────────────────▶  POST /tensor/plan
                                        POST /tensor/rpc/start  → llama-rpc-server :50052
POST /tensor/infer
  └─ llama-server --rpc w1:50052,w2:50052
       └─ weight tensors split by RAM proportion
       └─ GPU layers offloaded to workers
       └─ token returned to client
```

### Native AllReduce (Megatron-LM style)

```
For each transformer block:

  ┌── Q/K/V projection  (column-parallel) ──────────────────────┐
  │  Each rank computes:  partial = X @ W_col_slice              │
  │  No communication needed (outputs concatenated logically)    │
  └──────────────────────────────────────────────────────────────┘
              ↓
  ┌── Output projection  (row-parallel) + AllReduce ────────────┐
  │  Each rank computes:  partial = partial_in @ W_row_slice     │
  │  POST partial to /tensor/allreduce on coordinator            │
  │  Coordinator sums all world_size partials → full activation  │
  └──────────────────────────────────────────────────────────────┘
              ↓
  ┌── FFN layer  (column then row, same pattern) ───────────────┐
  └──────────────────────────────────────────────────────────────┘
```

### TNSR wire format (native AllReduce frames)

```
Offset  Size    Field
──────  ──────  ─────────────────────────────────
0       4 B     magic  b"TNSR"
4       1 B     rank   (u8,  0 = coordinator)
5       1 B     world_size (u8)
6       16 B    request_id ([u8; 16], UUID v4)
22      4 B     element_count (u32 LE)
26      N×4 B   f32 elements (LE), N = element_count
```

### API

| Method | Path | Body | Description |
|--------|------|------|-------------|
| `GET` | `/tensor/plan` | — | Return active plan or `{"plan": null}` |
| `POST` | `/tensor/plan` | `TensorParallelPlan` JSON | Set tensor parallel plan |
| `GET` | `/tensor/status` | — | Plan summary + RPC worker health |
| `POST` | `/tensor/infer` | `{prompt, max_tokens?, temperature?}` | Run TP inference (coordinator only) |
| `POST` | `/tensor/allreduce` | binary TNSR frame | Submit partial tensor; returns reduced frame |
| `POST` | `/tensor/rpc/start` | `{rpc_port?}` | Spawn `llama-rpc-server` on this node |
| `POST` | `/tensor/rpc/stop` | — | Stop `llama-rpc-server` |

### Quick start (RPC mode, 2 nodes)

```bash
# — Node B (worker, rank 1) —
curl -X POST http://node-b:9480/tensor/rpc/start -d '{"rpc_port":50052}'

# — Node A (coordinator, rank 0) —
curl -X POST http://node-a:9480/tensor/plan -H 'Content-Type: application/json' -d '{
  "plan_id":    "plan-1",
  "world_size": 2,
  "local_rank": 0,
  "backend":    "Rpc",
  "rpc_port":   50052,
  "coord_server_port": 8182,
  "model_path": "/home/user/models/Llama-3.1-70B-Q4_K_M.gguf",
  "peers": [
    {"rank":0,"node_id":"node-a","address":"node-a:9480","rpc_address":"node-a:50052","ram_mb":65536,"gpu_backend":"metal"},
    {"rank":1,"node_id":"node-b","address":"node-b:9480","rpc_address":"node-b:50052","ram_mb":32768,"gpu_backend":"cuda"}
  ]
}'

curl -X POST http://node-a:9480/tensor/infer \
  -d '{"prompt":"Explain tensor parallelism in 3 sentences","max_tokens":256}'
```

### Relationship to pipeline parallelism

| Strategy | Split axis | Activation flow | Best for |
|----------|-----------|-----------------|---------|
| Pipeline | Layer depth | Sequential A→B→C | Models too large for any single node |
| Tensor | Weight matrix width | Parallel + AllReduce | Lowest latency on same-size nodes |
| Hybrid | Both | Pipeline groups with TP inside | Largest models (70B+) on heterogeneous mesh |

Pipeline parallel uses `/pipeline/plan` and `/pipeline/infer` (see §8).
Hybrid mode: set up TP groups first, then wrap in a pipeline plan.

### GUI (Control Panel)

All tensor and pipeline parallelism settings are exposed in the **Setup tab** of the web control panel (`linus_ai_control_panel.html`) under three cards:

| Card | DOM ID | Shows when |
|------|--------|-----------|
| **Inference Mode** | — | Always visible in Setup tab |
| **Tensor Parallelism** | `tensorParallelCard` | Mode = Tensor RPC or Tensor Native |
| **Pipeline Parallelism** | `pipelineParallelCard` | Mode = Pipeline |

#### Inference Mode switcher

A four-button toggle persisted to `localStorage` (`linus_ai_infer_mode`):

| Button | Mode key | Activates |
|--------|----------|-----------|
| Local | `local` | Standard single-node `/infer` |
| Pipeline | `pipeline` | Pipeline Parallelism card + `POST /pipeline/plan` |
| Tensor RPC | `tensor_rpc` | Tensor Parallelism card, backend forced to `Rpc` |
| Tensor Native | `tensor_native` | Tensor Parallelism card, backend forced to `Native` |

**Source:** `setInferMode()` — `linus_ai_control_panel.html` (JS section, `_inferMode` variable)

#### Tensor Parallelism card fields

| Field | Element ID | Maps to plan field |
|-------|------------|-------------------|
| Plan ID | `tpPlanId` | `plan_id` |
| Backend | `tpBackend` | `backend` (`Rpc` / `Native`) |
| This node's rank | `tpLocalRank` | `local_rank` |
| RPC port | `tpRpcPort` | `rpc_port` |
| Coordinator port | `tpCoordPort` | `coord_server_port` |
| Model path | `tpModelPath` | `model_path` |
| Peer rows | `#tpPeerList` | `peers[]` — rank, node_id, address, rpc_address, ram_mb |

Buttons: **Apply Plan** → `POST /tensor/plan`  |  **▶ Start RPC Worker** → `POST /tensor/rpc/start`  |  **■ Stop** → `POST /tensor/rpc/stop`

Status strip (`tpStatusStrip`) polls `GET /tensor/status` and shows world_size, local_rank, backend, is_coordinator, rpc_worker_active.

**Source functions:** `addTpPeer()`, `removeTpPeer()`, `_gatherTpPeers()`, `applyTensorPlan()`, `loadTensorStatus()`, `tensorRpcStart()`, `tensorRpcStop()` — `linus_ai_control_panel.html`

#### Pipeline Parallelism card fields

| Field | Element ID | Maps to plan field |
|-------|------------|-------------------|
| This node's index | `ppIndex` | `index` |
| Model path | `ppModelPath` | `model_path` |
| Layer slice start | `ppSliceStart` | `my_slice[0]` |
| Layer slice end | `ppSliceEnd` | `my_slice[1]` |
| Node rows | `#ppNodeList` | `plan[]` — address, port |

Button: **Apply Plan** → `POST /pipeline/plan`

Status strip (`ppStatusStrip`) polls `GET /pipeline/plan` and shows is_configured, shard_loaded, index, my_slice.

**Source functions:** `addPipelineNode()`, `removePipelineNode()`, `_gatherPipelineNodes()`, `applyPipelinePlan()`, `loadPipelineStatus()` — `linus_ai_control_panel.html`

#### Source file map

| Concern | File | Key symbols |
|---------|------|-------------|
| GUI HTML + JS | `linus_ai_control_panel.html` | `setInferMode`, `applyTensorPlan`, `applyPipelinePlan`, `loadTensorStatus`, `loadPipelineStatus` |
| Tensor parallel engine (Rust) | `linus-ai-rs/crates/linus-ai-inference/src/tensor_parallel.rs` | `TensorParallelPlan`, `TpPeer`, `TpBackend`, `rpc_infer`, `build_plan_from_peers` |
| HTTP endpoints (Rust) | `linus-ai-rs/crates/linus-ai-http/src/lib.rs` | `tensor_plan_get/set`, `tensor_status`, `tensor_infer`, `tensor_rpc_start/stop`, `tensor_allreduce` |
| Pipeline orchestrator (Python) | `ai/pipeline.py` | `PipelineOrchestrator`, `GGUFTensorIndex`, `LayerPlanner` |
| Pipeline HTTP handlers (Python) | `main.py` | `_handle_pipeline_plan`, `_handle_pipeline_forward`, `_api_pipeline_infer_async` |
| System tray launcher | `linus-ai-rs/crates/linus-ai-launcher/src/main.rs` | `winit` event loop, tray menu (macOS + Windows) |

---

## 13. Compliance & Security

The compliance layer (`linus_ai/compliance.py`) enforces domain-specific governance before every inference request.

### Profile tiers

| Tier | Profiles | PII blocking | Injection | Consent required |
|------|----------|-------------|-----------|-----------------|
| OPEN | general, creative, reasoning, code, engineering | Warn | Warn | No |
| AUDIT | education, support, sales, data_science | Block critical | Warn | No |
| REGULATED | medical, legal, finance, hr | Block critical | Warn | Yes |
| RESTRICTED | security | Block all | Hard block | Yes |

### Preflight check flow

```
text + profile
  │
  ▼ PIIScanner
  │  ├─ CREDIT_CARD / CVV / SSN / PAN_LIKE → BLOCK
  │  └─ other types → warn + redact
  ▼ InjectionDetector
  │  ├─ RESTRICTED profile → BLOCK
  │  └─ REGULATED profile → WARN
  ▼ ConsentManager
  │  └─ REGULATED/RESTRICTED and no consent → BLOCK
  ▼ AuditLogger.log()
  │  ├─ write to primary dir (LINUS_AI_AUDIT_DIR or ~/.linus-ai/audit)
  │  └─ propagate to LINUS_AI_AUDIT_EXPORT_DIRS (colon-separated)
  ▼
ALLOW / BLOCK / WARN result
```

### Audit immutability

Completed monthly log files are sealed by `AuditLogger.seal_completed_months()`:
1. `chmod 0o400` — read-only at OS level
2. `os.chflags(UF_IMMUTABLE)` — macOS schg flag (requires root to unset)
3. `chattr +i` — Linux immutable attribute (requires root to unset)

HMAC-SHA256 chaining allows tamper detection without immutability at the OS level: `verify_chain()` returns `False` if any record was altered or deleted.

---

## 14. RAG Document Access Control

The RAG access layer (`linus_ai/rag_access.py`) provides fine-grained per-document access control for retrieval-augmented generation.

### Classification levels

| Value | Name | Default access |
|-------|------|---------------|
| 0 | PUBLIC | Anyone |
| 1 | INTERNAL | Authenticated company members via ACL |
| 2 | CONFIDENTIAL | Explicit ACL permit required |
| 3 | SECRET | Clearance ≥ 3 + explicit ACL permit |
| 4 | TOP_SECRET | Clearance 4 + named on owner's explicit list |

### Access decision algorithm (7 steps)

```
1. Is principal the document owner?          → PERMIT
2. Is principal in doc's deny_users list?    → DENY
3. Is document PUBLIC?                       → PERMIT
4. principal.clearance < doc.min_clearance?  → DENY
5. TOP_SECRET and principal not in allow?    → DENY
6. ACL permits at any scope?                 → PERMIT
   (company → division → department → role → user)
7. Default                                   → DENY
```

All decisions are HMAC-chained in `~/.linus-ai/rag-audit-<YYYY-MM>.jsonl` and propagated to any export dirs configured via `LINUS_AI_AUDIT_EXPORT_DIRS`.

---

## 15. Changelog

### v1.4.0 (current)
- **Compliance & Security Layer** — 14 domain-specific profiles across 4 tiers (OPEN/AUDIT/REGULATED/RESTRICTED); PII scanner (12 types, 4 blocking); injection detector (8 rule families); consent manager; immutable HMAC-chained audit logs with OS-level sealing
- **RAG Document Access Control** — 5-level document classification (PUBLIC → TOP_SECRET); fine-grained ACL at user/role/department/division/company scope; 7-step access decision algorithm; `filter_rag_chunks()` helper; HMAC-chained RAG audit log
- **Enterprise audit routing** — `LINUS_AI_AUDIT_DIR` and `LINUS_AI_AUDIT_EXPORT_DIRS` env vars for real-time propagation to SIEM systems; `seal_completed_months()` and `export_to()` on `AuditLogger`
- **New REST API** — `/compliance/*` (8 endpoints) and `/rag/*` (10 endpoints) wired into `main.py`
- **Test suite expanded** — 62 new compliance tests + 53 new RAG access tests; total 263 tests (484 including Rust)
- **Control panel UI** — compliance profile card, RAG document registry with ACL editor, RAG audit viewer in `linus_ai_control_panel.html`

### v1.2.0 (previous)
- **py2c**: Python-subset → C17 → native binary compiler (11 cross-compilation targets)
  - Replaces VOLT language — same `.py` files run interpreted AND compile to native
  - All 11 targets tested from Mac Studio: native, macos-arm64/x86_64, linux-x86_64/arm64,
    windows-x86_64, android-arm64/x86_64, ios-arm64, ios-sim, wasm
- **VOLT retired**: `linus_ai-volt` crate and `linus_ai/volt/` module removed
- **Agent ReAct**: fan-out to ≤ 3 peers, synthesis pass on hub
- **Privacy scopes**: `private` | `lan` | `open` (replaces `allow_web_search` bool)
- **Auto-behaviors**: auto-push GGUF to peers with 0 models; auto-assign roles on peer connect
- **nxrt.h**: `nanosleep` replaces `usleep` for full musl/POSIX compatibility

### v0.8.x
- Rust binary replaces Nuitka-compiled Python (Phase 2 complete)
- linus-ai-vault: OS keychain key storage
- linus-ai-guardian: RFC 6238 TOTP, bank-style auth gates
- linus-ai-thermal: 5-stage governor, HOT → peer-priority routing
- linus-ai-blockchain: SQLite-backed SHA-256 hash chain
- Overlay relay: WAN mesh without Tailscale

---

## 16. Roadmap

### Near-term (v3.1 – v3.3)

| Feature | Description | Tier |
|---|---|---|
| **Vault** | Encrypted secret store (AES-256-GCM + Argon2id) with `/vault/*` HTTP routes — crate exists, routes not yet wired | Pro+ |
| **CLI `infer` subcommand** | `linus_ai infer "prompt"` — run a single inference and print response, no browser needed | All |
| **CLI `chat` subcommand** | Interactive REPL: `linus_ai chat --model llama3` | All |
| **CLI `pull` subcommand** | `linus_ai pull llama3:8b` — download model from HuggingFace/registry | All |
| **CLI `activate` subcommand** | `linus_ai activate LNAI-PRO-XXXX` — activate licence from terminal | All |
| **Code signing** | macOS notarisation + Windows Authenticode for v3.1 | — |

### Medium-term (v3.4 – v4.0)

| Feature | Description | Tier |
|---|---|---|
| **Fine-tuning** | LoRA adapter training via `/finetune/*` routes — `pulse.rs` module exists, not yet exposed | Enterprise |
| **Air-gap mode** | Pre-signed offline licence bundle; no activation server call required | Enterprise |
| **Gas / token metering** | Per-request billing at 1/3 commercial API rates; GU wallet in Vault; 80/10/10 distribution (node / relay / fund) | Pro+ |
| **Permission tree UI** | Granular per-feature, per-scope grants in control panel (LAN vs WAN, rate limits, job scheduling) | Pro+ |

### Long-term (NEXUM protocol)

NEXUM is the codename for a decentralised infrastructure layer built on top of LinusChain:
- **Mesh-controlled DNS** — naming without ICANN dependence
- **Distributed PKI** — TLS certificate authority operated by validator quorum
- **Compute marketplace** — metered inference across public mesh nodes
- **Federated identity** — node-ID-based auth, no OAuth, no accounts

NEXUM builds on the existing blockchain audit ledger and mesh peer-discovery already in v4.0.0.
