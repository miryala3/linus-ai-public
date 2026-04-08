# LINUS-AI — Operations & Administration Manual

**Version 4.0.0 — April 2026**

---

## Table of Contents

1. [Overview](#1-overview)
2. [Installation & First Run](#2-installation--first-run)
3. [Command-Line Reference](#3-command-line-reference)
4. [Server Configuration](#4-server-configuration)
5. [User & Access Management (RBAC)](#5-user--access-management-rbac)
6. [LDAP / Active Directory Integration](#6-ldap--active-directory-integration)
7. [Model Management](#7-model-management)
8. [Inference & Chat](#8-inference--chat)
9. [File Import & Export (RAG / Doc Server)](#9-file-import--export-rag--doc-server)
10. [Tensor Parallelism (Multi-Node)](#10-tensor-parallelism-multi-node)
11. [Mesh Networking & Peer Discovery](#11-mesh-networking--peer-discovery)
12. [Agentic Workflows](#12-agentic-workflows)
13. [Thermal Governor](#13-thermal-governor)
14. [Blockchain Audit Ledger](#14-blockchain-audit-ledger)
15. [Monitoring & Metrics](#15-monitoring--metrics)
16. [Logging](#16-logging)
17. [License Management](#17-license-management)
18. [Security Hardening](#18-security-hardening)
19. [Code Signing (macOS)](#19-code-signing-macos)
20. [Building from Source](#20-building-from-source)
21. [CI / Release Pipeline](#21-ci--release-pipeline)
22. [Complete API Reference](#22-complete-api-reference)

---

## 1. Overview

LINUS-AI is a distributed, self-hosted AI inference platform. A single binary runs a full HTTP API, a mesh network, a thermal governor, an audit ledger, and an optional desktop GUI — all without cloud dependencies.

**Key capabilities:**

| Capability | Description |
|---|---|
| Local inference | Runs GGUF models via the bundled `mistralrs` engine (Metal / CUDA / CPU) |
| Mesh networking | Multiple nodes auto-discover each other via mDNS and share load |
| Tensor parallelism | Split a model too large for one machine across several nodes |
| RBAC + LDAP | Role-based access control with optional Active Directory / OpenLDAP integration |
| File import | CSV, PDF, DOCX, XLSX and more parsed into text for RAG and inference |
| Blockchain audit | Immutable per-request audit trail stored in a distributed ledger |
| Thermal governor | Automatic CPU/GPU throttle and request rerouting when temperature limits are hit |
| Agentic workflows | Multi-step AI pipelines with tool use, defined by JSON workflow graphs |

---

## 2. Installation & First Run

### macOS (arm64 / x86_64)

```bash
# Download the universal binary
curl -LO https://github.com/linus-ai-public/linus-ai-public/releases/latest/download/linus_ai-macos-universal

chmod +x linus_ai-macos-universal
./linus_ai-macos-universal
```

On first launch the **first-run wizard** runs automatically:
- Prompts for an admin username and password
- Generates a random mesh secret
- Writes `~/.linus_ai/accounts.json` and `~/.linus_ai/linus_ai.toml`
- Opens `http://localhost:9480/app` in the default browser

### Linux (x86_64)

```bash
curl -LO https://github.com/linus-ai-public/linus-ai-public/releases/latest/download/linus_ai-linux-x86_64
chmod +x linus_ai-linux-x86_64
./linus_ai-linux-x86_64
```

### Systemd service

```ini
# /etc/systemd/system/linus-ai.service
[Unit]
Description=LINUS-AI Inference Server
After=network.target

[Service]
Type=simple
User=linus-ai
EnvironmentFile=/etc/linus-ai/env
ExecStart=/usr/local/bin/linus_ai
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

```bash
# /etc/linus-ai/env
LINUS_AI_API_PORT=9480
LINUS_AI_MODE=full
LINUS_AI_MODEL_DIR=/data/models
LINUS_AI_LOG_FILE=/var/log/linus-ai/server.log
LINUS_AI_LOG_MAX_MB=100
LINUS_AI_MESH_SECRET=your-strong-secret-here
```

```bash
systemctl enable --now linus-ai
```

---

## 3. Command-Line Reference

### Synopsis

```
linus_ai [OPTIONS] [COMMAND]
```

### Server options

| Flag | Env var | Default | Description |
|---|---|---|---|
| `--port <N>` | `LINUS_AI_API_PORT` | `9480` | TCP port for the HTTP API |
| `--host <IP>` | `LINUS_AI_HOST` | `0.0.0.0` | Bind address. Use `127.0.0.1` for localhost-only |
| `--mode <mode>` | `LINUS_AI_MODE` | `full` | `full` \| `mesh` \| `edge` |
| `--model-dir <path>` | `LINUS_AI_MODEL_DIR` | `~/.linus_ai/models` | Directory scanned for `.gguf` files |
| `--data-dir <path>` | `LINUS_AI_DATA_DIR` | `~/.linus_ai` | Accounts, settings, templates |
| `--mesh-secret <s>` | `LINUS_AI_MESH_SECRET` | `linus-ai-default-mesh-secret` | Shared secret authenticating mesh peers |
| `--scope <s>` | `LINUS_AI_SCOPE` | `private` | `private` \| `public` |
| `--ctx-size <N>` | `LINUS_AI_CTX_SIZE` | `4096` | KV-cache context window in tokens |
| `--enable-shell` | `LINUS_AI_ENABLE_SHELL` | off | Enable `/shell/exec` and `/shell/stream` |
| `--log-level <l>` | `LINUS_AI_LOG_LEVEL` | `info` | `trace` \| `debug` \| `info` \| `warn` \| `error` |
| `--log-file <path>` | `LINUS_AI_LOG_FILE` | — | Append logs to file |
| `--log-max-mb <N>` | `LINUS_AI_LOG_MAX_MB` | `50` | Rotate log file at this size (0 = never) |
| `--log-format <f>` | `LINUS_AI_LOG_FORMAT` | `text` | `text` \| `json` |
| `--shutdown-timeout <s>` | `LINUS_AI_SHUTDOWN_TIMEOUT` | `2` | Seconds to drain in-flight requests before hard-closing all connections |
| `--tailscale` | `LINUS_AI_TAILSCALE` | off | Prefer Tailscale IPs for mesh addresses |
| `--overlay` | `LINUS_AI_OVERLAY` | off | Enable overlay (relay) networking |
| `--overlay-server <url>` | `LINUS_AI_OVERLAY_SERVER` | — | Relay server URL |
| `--node-name <n>` | `LINUS_AI_NODE_NAME` | hostname | Custom node identifier shown in the mesh |

### LDAP flags

| Flag | Env var | Description |
|---|---|---|
| `--ldap-url <url>` | `LINUS_AI_LDAP_URL` | LDAP server URL — sets `enabled: true` in `ldap.json` |
| `--ldap-bind-dn <dn>` | `LINUS_AI_LDAP_BIND_DN` | Service account DN |
| `--ldap-bind-password <pw>` | `LINUS_AI_LDAP_BIND_PASSWORD` | Service account password (**use env var, not CLI**) |
| `--ldap-base-dn <dn>` | `LINUS_AI_LDAP_BASE_DN` | Base DN for all searches |
| `--ldap-default-role <r>` | `LINUS_AI_LDAP_DEFAULT_ROLE` | Role for users with no group match (`lan_user`) |
| `--ldap-only` | `LINUS_AI_LDAP_ONLY` | Reject all local-account logins |

### Document / RAG server

| Flag | Env var | Description |
|---|---|---|
| `--doc-server <url>` | `LINUS_AI_DOC_SERVER` | Pre-load RAG store from `<url>/api/documents` at startup |

### Inference tuning

| Flag | Env var | Description |
|---|---|---|
| `--ctx-size <N>` | `LINUS_AI_CTX_SIZE` | Smaller = more GPU layers = faster TTFT on 70B models |
| — | `LINUS_AI_SKIP_WARMUP=1` | Skip GPU shader pre-compilation warmup |
| — | `LINUS_AI_DISABLE_METAL=1` | Force CPU even on Metal-capable Mac |
| — | `LINUS_AI_BUNDLED_DEVICE` | `metal` \| `cuda` \| `cpu` — override device selection |

### Subcommands

| Command | Description |
|---|---|
| `linus_ai info` | Print hardware profile (CPU, GPU, RAM) and exit |
| `linus_ai models` | List all discovered `.gguf` files and exit |
| `linus_ai compile <file.py>` | Compile a Python 3.10+ script to a native binary |
| `linus_ai run <file.py>` | Run a Python script without compiling |
| `linus_ai emit <file.py>` | Emit C source from a Python script |
| `linus_ai targets` | List available cross-compilation targets |

### Examples

```bash
# Minimal — localhost only, 8-K context
linus_ai --host 127.0.0.1 --ctx-size 8192

# LAN server — custom port, restricted to one interface
linus_ai --host 192.168.1.10 --port 8080 --model-dir /data/models

# Active Directory, LAN user facing, ldap-only
export LINUS_AI_LDAP_BIND_PASSWORD=s3cr3t
linus_ai \
  --host 10.0.0.5 \
  --ldap-url ldaps://dc.corp.example.com:636 \
  --ldap-bind-dn "CN=svc,OU=ServiceAccounts,DC=corp,DC=example,DC=com" \
  --ldap-base-dn "DC=corp,DC=example,DC=com" \
  --ldap-only

# Mesh worker node (join as mesh peer)
linus_ai --mode mesh --mesh-secret prod-secret-2026

# Edge node — minimal local model, routes heavy inference to mesh peers
linus_ai --mode edge --mesh-secret prod-secret-2026

# With document pre-load for RAG
linus_ai --doc-server http://192.168.1.50:8080

# Fast TTFT on 70B — smaller context, skip warmup logging
LINUS_AI_SKIP_WARMUP=0 linus_ai --ctx-size 2048 --model-dir /data/models
```

---

## 4. Server Configuration

### Directory layout

```
~/.linus_ai/
├── accounts.json          # local user accounts (RBAC)
├── ldap.json              # LDAP configuration
├── linus_ai.toml          # mesh secret, auto-generated on first run
├── models/                # default model directory
├── templates/
│   ├── tokenizer_config.json          # ChatML fallback template
│   └── tokenizer_config_llama3.json   # Llama-3 template
└── vault/                 # encrypted secret store
```

### Settings API

Settings can be read and written at runtime without restarting:

```bash
# Read current settings
curl http://localhost:9480/settings

# Write settings
curl -X POST http://localhost:9480/settings \
  -H "Content-Type: application/json" \
  -d '{"mode": "mesh", "overlay": false}'

# Export settings as TOML
curl http://localhost:9480/settings/export
```

### GPU device selection

At model load time, LINUS-AI probes for GPU backends in this order:

1. Metal (macOS) — all Apple Silicon and 2018+ Intel Macs with AMD GPU
2. CUDA (Linux/Windows) — any NVIDIA GPU with CUDA drivers
3. CPU — fallback

Override with `LINUS_AI_BUNDLED_DEVICE=cpu|metal|cuda`.

Set `LINUS_AI_DISABLE_METAL=1` to force CPU on a Mac without disabling Metal globally (useful when Metal shader compilation is crashing).

### Context size and TTFT

The context size (`--ctx-size`) controls how many tokens the KV cache reserves. Smaller values leave more VRAM for model weights, which means more transformer layers fit on GPU — directly reducing time-to-first-token (TTFT).

| Model | Recommended `--ctx-size` for fast TTFT | Notes |
|---|---|---|
| ≤ 7B | 8192 | Fits easily; context rarely matters |
| 13B–34B | 4096 | Default is fine |
| 70B (Mac Studio 96 GB) | 2048–4096 | Use 2048 for fastest TTFT |
| 70B (64 GB Mac) | 1024–2048 | May need 1024 to avoid swapping |

GPU shader warmup fires automatically after each model load, compiling all Metal/CUDA compute kernels and priming the prefix cache with the default system prompt. The first real user request therefore hits pre-compiled shaders. Skip with `LINUS_AI_SKIP_WARMUP=1`.

---

## 5. User & Access Management (RBAC)

### Roles

| Role | RPM cap | Max model size | Admin ops | Shell |
|---|---|---|---|---|
| `lan_user` | 30 | 13B | No | No |
| `lan_superuser` | 120 | 70B | No | No |
| `remote_auth` | 20 | 13B | No | No |
| `admin` | unlimited | unlimited | Yes | Yes (if `--enable-shell`) |

When **no accounts exist** (fresh install), all requests are granted `admin` — the first-run wizard creates the initial admin account before the server accepts external connections.

### Local user management

All user endpoints require the `admin` role. Pass the session token as `X-Linus-Token: <token>` or `Authorization: Bearer <token>`.

**Create a user**

```bash
curl -X POST http://localhost:9480/admin/users \
  -H "X-Linus-Token: $ADMIN_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"username": "alice", "password": "hunter2", "role": "lan_superuser"}'
```

**List users**

```bash
curl http://localhost:9480/admin/users \
  -H "X-Linus-Token: $ADMIN_TOKEN"
```

**Update user role or password**

```bash
curl -X PUT http://localhost:9480/admin/users/alice \
  -H "X-Linus-Token: $ADMIN_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"role": "admin"}'
```

**Delete a user**

```bash
curl -X DELETE http://localhost:9480/admin/users/alice \
  -H "X-Linus-Token: $ADMIN_TOKEN"
```

### Session management

**Login (get token)**

```bash
curl -X POST http://localhost:9480/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username": "alice", "password": "hunter2"}'
# → {"ok":true,"token":"...64-hex...","role":"lan_superuser","source":"local"}
```

The `source` field is `"ldap"` when authenticated via directory.

**Who am I?**

```bash
curl http://localhost:9480/auth/whoami \
  -H "X-Linus-Token: $TOKEN"
```

**Logout**

```bash
curl -X POST http://localhost:9480/auth/logout \
  -H "X-Linus-Token: $TOKEN"
```

### Password security

Passwords are hashed using hand-rolled PBKDF2-SHA256 with 10,000 iterations and a per-user random 16-byte salt. No external crypto library is required — only the `hmac` and `sha2` workspace crates.

LDAP-synced users receive a random placeholder hash. They always authenticate via LDAP bind — their local hash is never used.

---

## 6. LDAP / Active Directory Integration

### How it works

1. Login request arrives at `POST /auth/login`.
2. If LDAP is enabled, LINUS-AI binds to the directory with the service account.
3. Searches for the user's DN using `user_filter` (with `{username}` substituted).
4. Re-binds using the user's DN and supplied password to verify credentials.
5. Resolves the user's role from group membership (`memberOf` for AD; group object search for OpenLDAP).
6. Issues a local session token and upserts the user into the local account store.
7. If LDAP fails and `ldap_only` is `false`, falls back to local account check.

### Configuration file

`~/.linus_ai/ldap.json` — created/updated by `--ldap-*` CLI flags or `POST /admin/ldap/config`.

```json
{
  "enabled": true,
  "url": "ldaps://dc.corp.example.com:636",
  "bind_dn": "CN=linus-svc,OU=Service Accounts,DC=corp,DC=example,DC=com",
  "bind_password": "s3cr3t",
  "base_dn": "DC=corp,DC=example,DC=com",
  "user_search_base": "OU=Users,DC=corp,DC=example,DC=com",
  "user_filter": "(&(objectClass=user)(sAMAccountName={username}))",
  "username_attr": "sAMAccountName",
  "email_attr": "mail",
  "display_name_attr": "displayName",
  "group_search_base": "OU=Groups,DC=corp,DC=example,DC=com",
  "group_member_attr": "member",
  "role_mappings": {
    "AI-Admins":     "admin",
    "AI-PowerUsers": "lan_superuser",
    "AI-Users":      "lan_user"
  },
  "default_role": "lan_user",
  "ldap_only": false,
  "timeout_secs": 5
}
```

> **Active Directory note:** Group CNs in `role_mappings` can be short names (`"AI-Admins"`) or full DNs (`"CN=AI-Admins,OU=Groups,DC=corp,DC=com"`). Full DN match is tried first; CN-only match is the fallback.

### OpenLDAP example

```json
{
  "enabled": true,
  "url": "ldap://ldap.example.com:389",
  "bind_dn": "cn=admin,dc=example,dc=com",
  "bind_password": "adminpass",
  "base_dn": "dc=example,dc=com",
  "user_filter": "(&(objectClass=inetOrgPerson)(uid={username}))",
  "username_attr": "uid",
  "email_attr": "mail",
  "display_name_attr": "cn",
  "group_member_attr": "uniqueMember",
  "role_mappings": {
    "ai-admins": "admin",
    "ai-users":  "lan_user"
  },
  "default_role": "lan_user"
}
```

### LDAP admin API

**Read config (bind_password redacted)**

```bash
curl http://localhost:9480/admin/ldap/config \
  -H "X-Linus-Token: $ADMIN_TOKEN"
```

**Save new config**

```bash
curl -X POST http://localhost:9480/admin/ldap/config \
  -H "X-Linus-Token: $ADMIN_TOKEN" \
  -H "Content-Type: application/json" \
  -d @ldap.json
```

Sending `bind_password: ""` preserves the existing password — safe for updating only other fields.

**Test connection**

```bash
curl -X POST http://localhost:9480/admin/ldap/test \
  -H "X-Linus-Token: $ADMIN_TOKEN"
# → {"ok":true,"message":"Connection, bind, and base search all succeeded.","entries_at_base":42}
# On failure → {"ok":false,"step":"service_bind","error":"...","hint":"..."}
```

**Sync users from directory**

Pulls all users matching `user_filter` (with `*` wildcard) and creates/updates local accounts:

```bash
curl -X POST http://localhost:9480/admin/ldap/sync \
  -H "X-Linus-Token: $ADMIN_TOKEN"
# → {"ok":true,"created":12,"updated":3,"skipped":47,"errors":[]}
```

### One-shot bootstrap from CLI

```bash
# Writes ldap.json before the server starts accepting connections
export LINUS_AI_LDAP_BIND_PASSWORD=s3cr3t
linus_ai \
  --ldap-url ldaps://dc.corp.example.com:636 \
  --ldap-bind-dn "CN=svc,OU=ServiceAccounts,DC=corp,DC=com" \
  --ldap-base-dn "DC=corp,DC=com" \
  --ldap-default-role lan_user \
  --ldap-only
```

---

## 7. Model Management

### Supported formats

LINUS-AI loads `.gguf` files. Any GGUF v1–v3 model from HuggingFace or llama.cpp compatible sources works. The magic bytes (`GGUF`) are validated before loading.

### Model directories searched

By default: `~/.linus_ai/models` and `~/models`. Override with `--model-dir`:

```bash
linus_ai --model-dir /data/models:/mnt/nas/models   # colon-separated on Unix
```

### Model API

```bash
# List all discovered models
curl http://localhost:9480/models

# Select a model for inference
curl -X POST http://localhost:9480/models/select \
  -d '{"name": "llama-3-70b-instruct.Q4_K_M.gguf"}'

# Load selected model into memory
curl -X POST http://localhost:9480/models/load

# Unload (free VRAM/RAM)
curl -X POST http://localhost:9480/models/unload

# Get a hardware-aware recommendation
curl http://localhost:9480/models/recommend

# Pull a model file from a peer (mesh)
curl -X POST http://localhost:9480/models/pull \
  -d '{"name": "llama-3-8b.Q4_K_M.gguf", "peer": "192.168.1.11:9480"}'

# Pull a model from HuggingFace
curl -X POST http://localhost:9480/models/hf-pull \
  -d '{"repo": "bartowski/Meta-Llama-3-70B-Instruct-GGUF", "filename": "Meta-Llama-3-70B-Instruct-Q4_K_M.gguf"}'

# Assign models to mesh roles
curl -X POST http://localhost:9480/models/roles \
  -d '{"main": "llama-3-70b.gguf", "router": "llama-3-8b.gguf"}'
```

### RAM fit calculation

At scan time, `fits_in_ram` is set `true` when `model_size_mb ≤ physical_ram_mb × 0.85`. On Apple Silicon, unified memory means most physical RAM can address model weights.

The auto-select logic picks the largest model with `fits_in_ram: true`. If nothing fits, it picks the smallest model as a fallback.

---

## 8. Inference & Chat

### Single-turn inference

```bash
curl -X POST http://localhost:9480/infer \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Explain quantum entanglement in one paragraph.",
    "max_tokens": 512,
    "temperature": 0.7
  }'
```

### Streaming inference (SSE)

```bash
curl -X POST http://localhost:9480/infer/stream \
  -H "Content-Type: application/json" \
  -d '{"prompt": "Write a haiku about servers.", "max_tokens": 64}' \
  --no-buffer
```

Tokens arrive as `data: <chunk>` SSE events. The stream ends with `data: [DONE]`.

Inference has a **180-second timeout**. Model load has a **300-second timeout**.

### Chat (multi-turn)

```bash
curl -X POST http://localhost:9480/infer \
  -H "Content-Type: application/json" \
  -d '{
    "system": "You are a helpful assistant.",
    "messages": [
      {"role": "user",      "content": "What is the capital of France?"},
      {"role": "assistant", "content": "Paris."},
      {"role": "user",      "content": "And its population?"}
    ],
    "max_tokens": 128
  }'
```

Chat history is stored server-side per session:

```bash
# View sessions
curl http://localhost:9480/chat/sessions

# View history for a session
curl "http://localhost:9480/chat/history?session_id=abc123"
```

### Agentic streaming

```bash
curl -X POST http://localhost:9480/agent/stream \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Search for the latest GPU benchmarks and summarise.",
    "profile": "research",
    "max_steps": 5
  }' --no-buffer
```

---

## 9. File Import & Export (RAG / Doc Server)

### Supported file formats

| Extension | Method |
|---|---|
| `.csv`, `.tsv` | `csv` crate — cells rendered as `col1 \| col2 \| …` |
| `.xlsx`, `.xls`, `.xlsm`, `.ods` | `calamine` — all sheets and cells |
| `.docx` | ZIP → `word/document.xml` text runs |
| `.doc` | Naive binary ASCII run extraction |
| `.pdf` | BT/ET text block heuristic extraction |
| `.txt`, `.md`, `.rst`, `.log` | UTF-8 passthrough |
| `.json`, `.jsonl`, `.yaml`, `.toml` | UTF-8 passthrough |

### Upload a file and extract text

```bash
curl -X POST http://localhost:9480/files/upload \
  -F "file=@/path/to/report.pdf"
# → {"files":[{"filename":"report.pdf","format":"pdf","text":"...","words":1234,"chars":7890}]}
```

### Add documents to the RAG store

```bash
# Upload and immediately add to RAG
curl -X POST "http://localhost:9480/files/upload?add_to_rag=true" \
  -F "file=@knowledge_base.csv"

# Dedicated RAG upload (multiple files)
curl -X POST http://localhost:9480/files/rag/add \
  -F "file=@manual.pdf" \
  -F "file=@faq.docx"
```

### RAG store management

```bash
# List stored documents (metadata only)
curl http://localhost:9480/files/rag/list

# Clear all RAG documents
curl -X DELETE http://localhost:9480/files/rag/clear
```

### Export

```bash
# Export conversation as CSV
curl "http://localhost:9480/files/export/conversation?format=csv" \
  -H "Content-Type: application/json" \
  --data '[{"role":"user","content":"Hello"},{"role":"assistant","content":"Hi!"}]' \
  -o conversation.csv

# Export all RAG documents as JSON
curl http://localhost:9480/files/export/rag -o rag_backup.json

# Other formats: ?format=txt, ?format=json (default)
```

### External document server (RAG pre-load)

Point LINUS-AI at an existing document server at startup. The server must expose:

```
GET /api/documents
→ [{"filename": "guide.pdf", "text": "extracted plain text..."}, ...]
```

```bash
linus_ai --doc-server http://192.168.1.50:8080
```

Or set `LINUS_AI_DOC_SERVER=http://192.168.1.50:8080` in the environment. Documents are fetched once at startup and loaded into the in-memory RAG store.

### Using RAG in inference

When the RAG store is populated, the inference handler prepends stored documents as context. Pass `use_rag: true` in the request body:

```bash
curl -X POST http://localhost:9480/infer \
  -d '{"prompt": "What does our policy say about refunds?", "use_rag": true, "max_tokens": 256}'
```

---

## 10. Tensor Parallelism (Multi-Node)

Split a model that is too large for one machine across several nodes. Requires `F_TENSOR_PARALLEL` license feature.

### RPC mode (recommended)

Requires `llama-rpc-server` on all worker nodes (`brew install llama.cpp`).

**Step 1 — start rpc-server on each worker**

```bash
curl -X POST http://worker-1:9480/tensor/rpc/start
curl -X POST http://worker-2:9480/tensor/rpc/start
```

**Step 2 — build a plan on the coordinator**

```bash
curl -X POST http://coordinator:9480/tensor/plan \
  -d '{
    "backend": "Rpc",
    "rpc_port": 9099,
    "model_path": "/data/models/llama-3-70b.Q4_K_M.gguf"
  }'
```

The coordinator auto-discovers mesh peers, ranks them by composite score, and assigns the highest-scoring node as rank 0 (itself).

**Step 3 — run inference via tensor parallelism**

```bash
curl -X POST http://coordinator:9480/tensor/infer \
  -d '{"prompt": "Explain Rust lifetimes.", "max_tokens": 512}'
```

**Stop workers**

```bash
curl -X POST http://worker-1:9480/tensor/rpc/stop
```

### Plan inspection

```bash
curl http://coordinator:9480/tensor/plan    # current plan
curl http://coordinator:9480/tensor/status  # world_size, backend, peer health
```

### GPU layer split

Layers are split proportionally to each node's RAM (`--tensor-split` is computed automatically). A 96 GB Mac Studio paired with a 64 GB Mac Pro would send ~60% of layers to the larger machine.

---

## 11. Mesh Networking & Peer Discovery

### Auto-discovery

Peers on the same subnet discover each other via **mDNS** within a few seconds. All peers must share the same `--mesh-secret`.

```bash
curl http://localhost:9480/peers
# → [{"node_id":"...","address":"192.168.1.11:9480","model":"...","ram_mb":65536,...}]
```

### Role assignment

```bash
# Assign inference roles across the mesh
curl -X POST http://localhost:9480/mesh/assign-roles \
  -d '{"main":"node-a","router":"node-b","student":"node-c"}'

# Get a recommended smart configuration
curl http://localhost:9480/mesh/smart-config
```

### Node exclusion

Exclude a node from receiving routed inference requests (maintenance):

```bash
curl -X POST http://localhost:9480/mesh/nodes/exclude \
  -d '{"node_id": "node-c"}'

curl -X POST http://localhost:9480/mesh/nodes/include \
  -d '{"node_id": "node-c"}'
```

### Benchmark

```bash
curl http://localhost:9480/benchmark
# Runs a timed 50-token completion and returns tokens/sec
```

### Overlay networking

When nodes are not on the same subnet (cross-datacenter, VPN):

```bash
linus_ai --overlay --overlay-server wss://relay.yourdomain.com
```

Tailscale integration (prefers Tailscale IPs over LAN IPs):

```bash
linus_ai --tailscale
```

---

## 12. Agentic Workflows

Workflows are multi-step AI pipelines. Each step can call tools, run inference, invoke sub-agents, or transform data.

### Create a workflow

```bash
curl -X POST http://localhost:9480/workflows \
  -H "Content-Type: application/json" \
  -d '{
    "name": "research-summarise",
    "steps": [
      {"type": "search", "query": "{{input}}"},
      {"type": "infer",  "prompt": "Summarise: {{search_result}}"},
      {"type": "output", "format": "markdown"}
    ]
  }'
# → {"id": "wf-abc123"}
```

### Generate a workflow from a description

```bash
curl -X POST http://localhost:9480/workflows/generate \
  -d '{"description": "Search the web for a topic and write a blog post."}'
```

### Run a workflow

```bash
curl -X POST http://localhost:9480/workflows/wf-abc123/run \
  -d '{"input": "quantum computing breakthroughs 2025"}'
```

### List / update / delete

```bash
curl http://localhost:9480/workflows              # list
curl http://localhost:9480/workflows/wf-abc123    # get
curl -X PUT http://localhost:9480/workflows/wf-abc123 -d '{...}'   # update
curl -X DELETE http://localhost:9480/workflows/wf-abc123           # delete
```

---

## 13. Thermal Governor

LINUS-AI monitors CPU and GPU temperatures. When thresholds are exceeded, it:
1. Throttles inference request rate.
2. Reroutes requests to cooler mesh peers automatically.
3. Logs a warning and updates the `/thermal` endpoint.

```bash
curl http://localhost:9480/thermal
# → {"cpu_temp_c":78,"gpu_temp_c":84,"throttle_active":false,"rerouted_count":0}
```

No configuration is required — thresholds are preset per platform.

---

## 14. Blockchain Audit Ledger

Every inference request and admin action is appended to a local, tamper-evident ledger. Requires `F_BLOCKCHAIN_AUDIT` license feature.

```bash
# Ledger stats
curl http://localhost:9480/blockchain

# Append a record manually
curl -X POST http://localhost:9480/ledger/record \
  -d '{"event": "model_loaded", "model": "llama-3-70b.gguf"}'

# List blocks
curl http://localhost:9480/ledger/blocks

# Verify chain integrity
curl http://localhost:9480/ledger/verify

# Get a specific block
curl http://localhost:9480/ledger/block/<hash>

# Merkle proof for a record
curl http://localhost:9480/ledger/proof/<record_id>
```

### Peer sync (distributed ledger)

```bash
curl -X POST http://localhost:9480/ledger/sync/push    # push new blocks to peers
curl http://localhost:9480/ledger/sync/blocks          # pull blocks from peers
curl http://localhost:9480/ledger/sync/tip             # get chain tip from peers
```

---

## 15. Monitoring & Metrics

### Health check

```bash
curl http://localhost:9480/health
# → {"ok":true,"uptime_s":3600,"model_loaded":true,"version":"4.0.0"}
```

### Status

```bash
curl http://localhost:9480/status
# → full JSON: model, peers, mesh mode, RAM, GPU, uptime
```

### Prometheus metrics

```bash
curl http://localhost:9480/metrics
```

Returns Prometheus text format (`text/plain; version=0.0.4`):

| Metric | Type | Description |
|---|---|---|
| `linus_ai_http_requests_total` | counter | All HTTP requests received |
| `linus_ai_infer_requests_total` | counter | Inference requests |
| `linus_ai_infer_errors_total` | counter | Failed inference requests |
| `linus_ai_infer_timeouts_total` | counter | Inference timeouts (180s limit) |
| `linus_ai_tokens_generated_total` | counter | Total tokens produced |
| `linus_ai_infer_active` | gauge | Concurrent in-flight inference requests |
| `linus_ai_peer_delegate_total` | counter | Requests forwarded to mesh peers |
| `linus_ai_peer_delegate_errors_total` | counter | Failed peer delegations |

**Prometheus scrape config:**

```yaml
scrape_configs:
  - job_name: linus-ai
    static_configs:
      - targets: ['192.168.1.10:9480']
    metrics_path: /metrics
```

### Version check

```bash
curl http://localhost:9480/version        # current version
curl http://localhost:9480/version/check  # compare against latest GitHub release
```

---

## 16. Logging

```bash
# Write to file with rotation at 100 MB
linus_ai --log-file /var/log/linus-ai.log --log-max-mb 100

# JSON structured logs (for Loki / Elasticsearch)
linus_ai --log-format json --log-file /var/log/linus-ai.json

# Verbose debug
linus_ai --log-level debug

# Last 1000 log lines via API
curl http://localhost:9480/logs
```

Log rotation creates `.1.log` and `.2.log` archives — the two most recent rotations are kept.

---

## 17. License Management

### License tiers

| Tier | Key prefix | Model cap | Key features |
|---|---|---|---|
| Community | — (no key) | 5B | Inference, GUI |
| Trial | — (first 30 days) | 70B | Full Professional features, no key required |
| Professional | `LNAI-PRO*` | 70B | Agentic workflows, Tensor Parallel, Mesh, Full API |
| Team | `LNAI-TEAM` | 70B | Professional + Federated Learning, Blockchain Audit |
| Studio | `LNAI-STD*` | 70B | Same as Team |
| Enterprise | `LNAI-ENT*` | Unlimited | Team + LDAP/SSO (Vault, Fine-tuning, Air-gap: roadmap) |
| Medical Solo | `LNMD-MED*` | 70B | HIPAA Audit, Clinical Roles, Audit PDF |
| Medical Enterprise | `LNMD-MEDE` | Unlimited | Medical Solo + Multi-site, LDAP |

Trial licenses expire after 30 days and revert to community tier (inference only, ≤ 5B models).

```bash
# Check current license status
curl http://localhost:9480/license/status

# Activate a license key (fully offline — no telemetry)
curl -X POST http://localhost:9480/license/activate \
  -d '{"key": "LNAI-XXXX-XXXX-XXXX-XXXX"}'

# Deactivate (transfer to another machine)
curl -X POST http://localhost:9480/license/deactivate
```

### License feature flags

| Feature flag | Description |
|---|---|
| `infer` | Basic inference (community) |
| `models_5b` | Models up to 5B parameters (community) |
| `models_70b` | Models up to 70B parameters |
| `models_unlimited` | No model size cap |
| `mesh` | Mesh networking and peer discovery |
| `tensor_parallel` | Multi-node tensor parallelism |
| `pipeline_parallel` | Pipeline-parallel inference |
| `agentic` | Agentic workflows — defined but not route-gated (available to all tiers in v4.0.0) |
| `blockchain_audit` | Distributed audit ledger (Team+) |
| `federated_learning` | Federated training coordination (Team+) |
| `sso_ldap` | LDAP / Active Directory integration (Enterprise+) |
| `vault` | Encrypted secret store — **roadmap, not yet in v4.0.0** |
| `api_full` | Full OpenAI-compatible REST API (Professional+) |
| `fine_tuning` | Local model fine-tuning — **roadmap, not yet in v4.0.0** |
| `air_gap` | Air-gapped deployment mode — **roadmap, not yet in v4.0.0** |
| `gui` | Desktop control panel |
| `med_hipaa` | HIPAA audit mode (linus-aiMED) |

---

## 18. Security Hardening

### Network exposure

| Scenario | Recommended setting |
|---|---|
| Developer laptop, single user | `--host 127.0.0.1` |
| LAN server, trusted network | `--host 0.0.0.0` (default) |
| Internet-facing | Reverse proxy (nginx/caddy) with TLS; `--host 127.0.0.1` behind proxy |

### Mesh secret

Change the default mesh secret before deploying more than one node:

```bash
# Via CLI
linus_ai --mesh-secret $(openssl rand -hex 32)

# Via API (admin only)
curl -X POST http://localhost:9480/admin/mesh-secret \
  -H "X-Linus-Token: $ADMIN_TOKEN" \
  -d '{"secret": "new-strong-secret"}'
```

### Shell endpoints

`/shell/exec` and `/shell/stream` are **disabled by default**. Enable only in single-user, trusted-network environments:

```bash
linus_ai --enable-shell --host 127.0.0.1
```

The `admin` role is required to call shell endpoints even when enabled.

### LDAP-only mode

Prevent local account bypass for corporate deployments:

```bash
linus_ai --ldap-only
```

The built-in first-run admin account is exempt (it has no LDAP equivalent). After LDAP is working, delete the local admin or rotate its password to an unguessable value.

### LDAP service account password

Never pass `--ldap-bind-password` on the command line in production — it appears in `ps` output. Use the environment variable:

```bash
export LINUS_AI_LDAP_BIND_PASSWORD="$(vault read -field=password secret/ldap-svc)"
linus_ai --ldap-url ldaps://dc:636 --ldap-bind-dn "CN=svc,..."
```

### HTTPS / TLS

LINUS-AI does not terminate TLS directly. Place it behind a reverse proxy:

**nginx example:**

```nginx
server {
    listen 443 ssl;
    ssl_certificate     /etc/ssl/linus-ai.crt;
    ssl_certificate_key /etc/ssl/linus-ai.key;

    location / {
        proxy_pass         http://127.0.0.1:9480;
        proxy_set_header   Upgrade $http_upgrade;
        proxy_set_header   Connection "upgrade";
        proxy_read_timeout 300s;   # long enough for large model inference
    }
}
```

---

## 19. Code Signing (macOS)

### Ad-hoc signing (local testing, no admin required)

```bash
codesign --force --deep --sign - dist/macos-arm64/linus_ai
```

- The `-` identity means "ad-hoc" — a local hash is embedded in the binary.
- **No admin rights needed** — only write access to the binary file.
- Gatekeeper will still block the binary on other machines (use Developer ID for distribution).

### Developer ID signing (distribution)

```bash
# Requires Apple Developer account and certificate in your keychain
codesign \
  --force \
  --deep \
  --sign "Developer ID Application: Your Name (TEAM_ID)" \
  --entitlements entitlements.plist \
  --options runtime \
  dist/macos-arm64/linus_ai
```

### Notarization

```bash
# Zip first (notarytool requires an archive for non-app bundles)
zip -j linus_ai-macos-arm64.zip dist/macos-arm64/linus_ai

xcrun notarytool submit linus_ai-macos-arm64.zip \
  --apple-id "you@example.com" \
  --team-id "TEAM_ID" \
  --password "@keychain:notarize-password" \
  --wait

# Staple the ticket to the binary
xcrun stapler staple dist/macos-arm64/linus_ai
```

### Universal binary

```bash
lipo -create \
  dist/macos-arm64/linus_ai \
  dist/macos-x86_64/linus_ai \
  -output dist/macos-universal/linus_ai

# Sign after lipo (signing before lipo loses the signature)
codesign --force --deep --sign "Developer ID Application: ..." \
  dist/macos-universal/linus_ai
```

---

## 20. Building from Source

### Prerequisites

| Platform | Requirements |
|---|---|
| macOS | Xcode Command Line Tools, Rust ≥ 1.78 |
| Linux | `libwebkit2gtk-4.1-dev`, `libgtk-3-dev`, `libayatana-appindicator3-dev`, `librsvg2-dev`, Rust ≥ 1.78 |
| Windows | Visual Studio 2022 Build Tools, Rust ≥ 1.78 |

### Build commands

```bash
cd linus-ai-rs

# Headless binary only (fastest)
cargo build --release --bin linus_ai

# Desktop GUI (native window)
cargo build --release --package linus-ai-gui --bin linus-ai

# With Metal GPU acceleration (macOS)
cargo build --release --bin linus_ai \
  --features "llama-bundled,llama-metal"

# With CUDA (Linux/Windows)
cargo build --release --bin linus_ai \
  --features "llama-bundled,llama-cuda"

# Workspace check (no compilation)
cargo check --workspace

# Run tests
cargo test --workspace
```

### Feature flags

| Cargo feature | Effect |
|---|---|
| `llama-bundled` | Bundle `mistralrs` engine (pure Rust, no C++ toolchain) |
| `llama-metal` | Metal GPU acceleration (macOS) |
| `llama-cuda` | CUDA GPU acceleration (Linux/Windows) |
| `candle-only` | Use HuggingFace Candle instead of mistralrs |
| `tray` | System tray icon (GUI crate only) |

### Build script

```bash
chmod +x build.sh
./build.sh          # builds all targets for current platform
./build.sh --run-tests   # also runs cargo test --workspace
```

---

## 21. CI / Release Pipeline

### Tag and release

```bash
# Bump version in all Cargo.toml files to e.g. 3.1.0, then:
git add -A
git commit -m "chore: release 3.1.0"
git tag v3.1.0
git push origin main v3.1.0
```

The `release.yml` workflow triggers on `v*.*.*` tags and builds:

| Platform | Artifacts |
|---|---|
| macOS arm64 | `linus_ai`, `linus-ai` GUI, `.dmg` |
| macOS x86_64 | `linus_ai`, `linus-ai` GUI |
| macOS universal | `linus_ai` (lipo of both), universal `.dmg` |
| Linux x86_64 | `linus_ai`, `linus-ai` GUI, `.deb` |
| Linux arm64 | `linus_ai` (headless only) |
| Windows x86_64 | `linus_ai.exe`, `linus-ai.exe` GUI, `.msi`, `.msix` |

### Tauri packaging (staged)

`release-tauri.yml` is workflow-dispatch only. Activate for production DMG/AppImage by adding:

```yaml
on:
  push:
    tags: ['v*.*.*']
```

---

## 22. Complete API Reference

### Authentication

All endpoints accept authentication via:
- `X-Linus-Token: <64-hex-token>` header
- `Authorization: Bearer <64-hex-token>` header

When no accounts exist, all requests are granted `admin`.

### Endpoint index

```
GET /endpoints
```

Returns a JSON array of all registered routes.

### Core

| Method | Path | Auth | Description |
|---|---|---|---|
| GET | `/` or `/app` | any | Serve embedded control panel HTML |
| GET | `/health` | any | Health check |
| GET | `/status` | any | Full system status JSON |
| GET | `/stats` | any | Extended stats (thermal, mesh, blockchain) |
| GET | `/ready` | any | Returns 200 when server is ready |
| GET | `/version` | any | Current version |
| GET | `/version/check` | any | Compare against latest GitHub release |
| POST | `/shutdown` | admin | Graceful shutdown |
| POST | `/reload` | admin | Reload config and rescan models |
| GET | `/logs` | admin | Last 1000 log lines |
| GET | `/metrics` | any | Prometheus text metrics |
| GET | `/endpoints` | any | List all API routes |

### Authentication & RBAC

| Method | Path | Auth | Description |
|---|---|---|---|
| POST | `/auth/login` | none | Login (local or LDAP) → token |
| POST | `/auth/logout` | token | Revoke session token |
| GET | `/auth/whoami` | token | Current user and role |
| GET | `/admin/users` | admin | List all local users |
| POST | `/admin/users` | admin | Create local user |
| PUT | `/admin/users/:name` | admin | Update user role or password |
| DELETE | `/admin/users/:name` | admin | Delete user |
| POST | `/admin/mesh-secret` | admin | Rotate mesh secret |

### LDAP

| Method | Path | Auth | Description |
|---|---|---|---|
| GET | `/admin/ldap/config` | admin | Read LDAP config (password redacted) |
| POST | `/admin/ldap/config` | admin | Save LDAP config |
| POST | `/admin/ldap/test` | admin | Test connection and service bind |
| POST | `/admin/ldap/sync` | admin | Sync users from directory |

### Models

| Method | Path | Auth | Description |
|---|---|---|---|
| GET | `/models` | any | List discovered models |
| POST | `/models/select` | superuser | Select active model |
| GET/POST | `/models/roles` | superuser | Get/set mesh role assignments |
| POST | `/models/load` | superuser | Load selected model |
| POST | `/models/unload` | superuser | Unload model, free memory |
| POST | `/models/pull` | superuser | Pull model from peer |
| POST | `/models/hf-pull` | superuser | Pull model from HuggingFace |
| PUT | `/models/push` | superuser | Receive a pushed model file |
| GET | `/models/recommend` | any | Hardware-aware model recommendation |
| POST | `/models/auto-push` | admin | Push model to all mesh peers |

### Inference

| Method | Path | Auth | Description |
|---|---|---|---|
| POST | `/infer` | lan_user | Single-turn inference |
| POST | `/infer/stream` | lan_user | Streaming inference (SSE) |

### Agent

| Method | Path | Auth | Description |
|---|---|---|---|
| POST | `/agent/stream` | lan_user | Agentic reasoning loop (SSE) |
| GET | `/agent/profiles` | any | Available agent profiles |

### Chat

| Method | Path | Auth | Description |
|---|---|---|---|
| GET | `/chat/sessions` | lan_user | List chat sessions |
| GET | `/chat/history` | lan_user | Session message history |

### Files

| Method | Path | Auth | Description |
|---|---|---|---|
| POST | `/files/upload` | lan_user | Upload file, extract text |
| POST | `/files/rag/add` | lan_user | Add documents to RAG store |
| DELETE | `/files/rag/clear` | superuser | Clear RAG store |
| GET | `/files/rag/list` | lan_user | List RAG documents |
| GET | `/files/export/conversation` | lan_user | Export conversation (CSV/JSON/TXT) |
| GET | `/files/export/rag` | superuser | Export RAG store as JSON |

### Mesh & Peers

| Method | Path | Auth | Description |
|---|---|---|---|
| GET | `/peers` | any | List mesh peers |
| POST | `/mesh/assign-roles` | admin | Assign model roles across mesh |
| GET | `/mesh/smart-config` | any | Recommended mesh configuration |
| POST | `/mesh/nodes/exclude` | admin | Exclude node from routing |
| POST | `/mesh/nodes/include` | admin | Re-include excluded node |
| GET | `/benchmark` | any | Local inference benchmark |

### Tensor Parallelism

| Method | Path | Auth | Description |
|---|---|---|---|
| GET/POST | `/tensor/plan` | admin | Get or set TP plan |
| GET | `/tensor/status` | any | TP cluster status |
| POST | `/tensor/infer` | lan_user | Run inference across TP cluster |
| POST | `/tensor/allreduce` | internal | Submit AllReduce partial |
| POST | `/tensor/rpc/start` | admin | Start llama-rpc-server |
| POST | `/tensor/rpc/stop` | admin | Stop llama-rpc-server |

### Jobs

| Method | Path | Auth | Description |
|---|---|---|---|
| GET | `/jobs` | superuser | List running jobs |
| POST | `/jobs` | superuser | Submit a background job |
| POST | `/jobs/stop` | superuser | Stop a job |

### Workflows

| Method | Path | Auth | Description |
|---|---|---|---|
| GET | `/workflows` | lan_user | List workflows |
| POST | `/workflows` | superuser | Create workflow |
| POST | `/workflows/generate` | superuser | Generate workflow from description |
| GET | `/workflows/:id` | lan_user | Get workflow |
| PUT | `/workflows/:id` | superuser | Update workflow |
| DELETE | `/workflows/:id` | superuser | Delete workflow |
| GET/POST | `/workflows/:id/run` | lan_user | Run workflow |

### System

| Method | Path | Auth | Description |
|---|---|---|---|
| GET/POST | `/settings` | admin | Read / write runtime settings |
| GET | `/settings/export` | admin | Export settings as TOML |
| GET | `/thermal` | any | Thermal governor status |
| GET | `/pipeline/plan` | any | Pipeline parallelism plan |
| GET | `/remote/view` | any | Remote node view |
| GET | `/billing` | admin | Billing accounts |
| POST | `/billing/topup` | admin | Top up billing account |
| POST | `/hive/train` | admin | Start federated training |
| GET | `/hive/status` | admin | Federated training status |
| POST | `/shell/exec` | admin + `--enable-shell` | Execute shell command |
| GET | `/shell/stream` | admin + `--enable-shell` | Stream shell output |

### License

| Method | Path | Auth | Description |
|---|---|---|---|
| GET | `/license/status` | any | License tier and expiry |
| POST | `/license/activate` | admin | Activate license key |
| POST | `/license/deactivate` | admin | Deactivate (transfer) license |

### Blockchain / Ledger

| Method | Path | Auth | Description |
|---|---|---|---|
| GET | `/blockchain` | any | Ledger statistics |
| POST | `/ledger/record` | lan_user | Append a record |
| GET | `/ledger/blocks` | any | List all blocks |
| GET | `/ledger/verify` | any | Verify chain integrity |
| GET | `/ledger/block/:hash` | any | Get block by hash |
| GET | `/ledger/proof/:id` | any | Merkle proof for record |
| POST | `/ledger/sync/push` | admin | Push blocks to peers |
| GET | `/ledger/sync/blocks` | any | Pull blocks from peers |
| GET | `/ledger/sync/tip` | any | Chain tip from peers |
| POST | `/ledger/sync/vote` | internal | BFT consensus vote |
| GET | `/ledger/peers` | any | Ledger peer list |
| GET | `/ledger/peers/known` | any | All known ledger peers |
| GET | `/ledger/peers/find/:target` | any | Find a peer by node ID |
| POST | `/ledger/peers/announce` | internal | Announce this node |
| POST | `/ledger/consensus/msg` | internal | Consensus message |
| GET | `/ledger/consensus/state` | any | Consensus state |

---

*This manual covers LINUS-AI 4.0.0. For the latest changes see the GitHub release notes.*

---

## Appendix A — GUI Reference (Control Panel Tab-by-Tab)

Access the control panel at **http://127.0.0.1:9480/app** after starting the binary.

### Configuration priority

| Method | Example | When to use |
|---|---|---|
| Command-line flag | `./linus_ai --port 8080` | One-off overrides |
| Environment variable | `LINUS_AI_MODE=mesh ./linus_ai` | Docker, scripts, launchd |
| GUI (browser) | Control panel → Settings | Day-to-day adjustments |

Defaults are safe. Nothing needs to be changed to get a working install.

---

### Models tab

Shows all `.gguf` files found in your model directories.

| Column | Meaning |
|---|---|
| **Name** | Filename |
| **Params** | Parameter count (e.g. `8.0B`) |
| **Quant** | Compression level — `q4_k` = smaller/faster, `q8_0` = larger/better, `f16` = full precision |
| **Size** | File size on disk |
| **Status** | `★ active` = loaded · `ready` = available · `⚠ too large` = exceeds 85% of available RAM |

**Use** — set as active model. Disabled if the model exceeds available RAM.  
**Force** — override RAM check (may cause heavy swapping).  
**Unload** — deactivate current model.

---

### Chat tab

| Control | What it does |
|---|---|
| Model selector | Pick which model answers the next message |
| Profile selector | Pre-configured system prompts (Chat, Code, Legal, Medical, Finance, Data Science, Tutor, Sales, HR, Support, Security, Creative) |
| Chat / Agent toggle | **Chat** = direct answer. **Agent** = ReAct loop with tool use (web search, calculator). Agent mode requires `--scope open` or `lan` for web search. |
| Session selector | Each conversation is a persistent session. Switch to start a fresh context window. |
| Export | Download conversation as Markdown |
| Attach files | Upload `.pdf`, `.docx`, `.txt` — text is extracted and prepended to the prompt |

---

### Permissions tab

Controls who can access this node. One-click presets:

| Preset | Effect |
|---|---|
| **LAN only** | Accept queries from local network only. Safe default. |
| **Local** | Localhost only. Strictest. |
| **Open** | LAN + WAN inference. Only if serving external traffic intentionally. |
| **Hub** | Open + federated learning participation. |

Quick actions:

| Button | Effect |
|---|---|
| Lock Down | Block all external access immediately |
| LAN Only | Open to local network, block internet |
| Stealth | Stop broadcasting beacon — peers won't discover this node |
| Gas On/Off | Toggle pay-per-use billing for external callers |
| Export/Import Config | Share permission settings as JSON between nodes |

**Inference settings:**

| Setting | Default | Description |
|---|---|---|
| Accept inference from LAN peers | On | Other LAN machines can send prompts |
| Accept inference from WAN peers | Off | Internet peers via overlay |
| Rate-limit requests | Off | Cap incoming requests per minute |
| Require Gas payment | Off | Callers must have a GU balance |

**Compute jobs:**

| Setting | Default | Description |
|---|---|---|
| Accept job submissions (LAN) | Off | Run batch AI jobs for LAN machines |
| CPU cap | 2 cores | Maximum cores per job |
| Wall-time limit | 30 min | Kill jobs that exceed this |
| Accept job submissions (WAN) | Off | Internet peers — off by default |

**Model sharing:**

| Setting | Default | Description |
|---|---|---|
| Let LAN peers push model files | Off | Peers can upload `.gguf` files to this node |
| Let LAN peers pull model files | Off | Peers can download models from this node |
| Storage quota | Unlimited | Max disk for peer-pushed models |

**Federation (advanced):**

Leave all off unless intentionally doing distributed training.

| Setting | Description |
|---|---|
| Participate in Hive federated learning | Contribute to and receive gradient updates |
| Share gradient updates (LAN / WAN) | Send training improvements to peers |
| Accept P2P solver tasks | Participate in distributed problem solving |

---

### Setup tab

**Node role** — high-level role in a multi-machine mesh:

| Role | Hardware | Description |
|---|---|---|
| SPOKE | Any with a model | Answers requests, no routing |
| HUB | 32 GB+ RAM, 13B+ model | Spoke + routes to optimal peers |
| MASTER HUB | 100 GB+ RAM, 70B+ model | Hub + orchestrates the whole mesh |
| EDGE | No models | Forwards requests to nodes that have models |

**Model role assignments:**

| Slot | Description |
|---|---|
| Main | Primary model for chat and API |
| Router | Model used for routing decisions |
| Student | Receives federated training updates |
| Worker | Background batch job model |

**Inference mode** (tensor parallelism):

| Mode | Description |
|---|---|
| Local | Single-node via bundled engine (default) |
| Pipeline | Layers distributed across N nodes sequentially |
| Tensor RPC | Weights split via `llama-rpc-server` — lowest latency on fast LAN |

---

### Mesh tab

Live view of all discovered peers:

| Column | Meaning |
|---|---|
| Host | Machine name and IP |
| Role | hub / spoke / edge / master_hub |
| Models | Models loaded on that peer |
| RAM | Total remote RAM |
| GPU | Backend (metal, cuda, cpu) |
| Thermal | nominal / warm / hot / critical |
| Load % | Current inference load |
| Latency | Round-trip time (ms) |
| Score | Composite routing score — higher = preferred |

---

### Thermal tab

Automatic throttle states:

| State | Behaviour |
|---|---|
| Nominal | No throttling |
| Warm | Slightly elevated, inference continues |
| Hot | Routes to cooler peers if available |
| Critical | Local inference suspended, routes to peers. Returns `503` if no peers. |
| Emergency | All inference refused, `503 Service Unavailable` |

Thresholds are read from the OS automatically — not configurable in the GUI.

---

### Hardware tab

Read-only hardware profile:

| Field | Meaning |
|---|---|
| CPU | Processor model and core count |
| RAM | Total physical memory |
| GPU | Card and backend (Metal / CUDA / CPU) |
| AI Score | Estimated tokens-per-second capability |

---

### Ledger tab

Read-only blockchain audit log. Every significant event (inference request, model load, startup, payment) is appended as a hash-linked entry. Entries cannot be deleted. Each entry includes timestamp, event type, SHA-256 hash, and Merkle proof.

**Verify Chain** — calls `GET /compliance/audit/verify` to confirm no tampering.

---

### Compliance & Security (Setup tab → Compliance card)

Pre-flight checks applied to every inference request before the prompt reaches the model.

**Profiles** (14 built-in, grouped by strictness):

| Tier | Profiles | Enforcement |
|---|---|---|
| OPEN | general, creative, reasoning, code, engineering | PII warnings only |
| AUDIT | education, support, sales, data_science | PII warnings + all decisions logged |
| REGULATED | medical, legal, finance, hr | PII blocking + consent required + full audit |
| RESTRICTED | security | Injection hard-block + PII block + consent |

**PII scanner** — 12 types detected. Blocking types (request rejected): CREDIT_CARD, CVV, SSN, PAN_LIKE. Redaction types (value replaced with `[REDACTED]`): EMAIL, PHONE, IP_ADDRESS, MAC_ADDRESS, PASSPORT, NHS_NUMBER, IBAN, MEDICAL_RECORD.

**Injection detection** — 8 categories: role override, prompt leak, jailbreak, system override, goal hijacking, multi-turn extraction, token smuggling. RESTRICTED tier hard-blocks; REGULATED tier logs and flags.

**Consent** — REGULATED and RESTRICTED profiles require recorded consent before first interaction. Stored in `~/.linus-ai/consent.json`.

**Audit log** — HMAC-SHA256 chained JSONL files at `~/.linus-ai/audit/audit-YYYY-MM.jsonl` (override with `LINUS_AI_AUDIT_DIR`). Completed months sealed with OS-level immutability. Secondary export paths via `LINUS_AI_AUDIT_EXPORT_DIRS` (colon-separated) for SIEM routing.

---

### RAG Document Access Control (Setup tab → RAG card)

Checks whether the requesting user may read each candidate document before it enters the context window — prevents information leakage across org boundaries.

**Document classification levels:**

| Level | Name | Access |
|---|---|---|
| 0 | PUBLIC | Everyone |
| 1 | INTERNAL | Company members via ACL |
| 2 | CONFIDENTIAL | Explicit ACL permit required |
| 3 | SECRET | Clearance ≥ 3 + ACL permit |
| 4 | TOP_SECRET | Clearance 4 + named explicitly |

**Principal identity fields:** User ID, Name, Email, Company, Division, Department, Clearance Level (0–4), Roles (comma-separated).

**ACL editor scopes:** allow/deny at user, company, division, department, and role level. Deny always overrides allow.

**Audit log** — every access decision written to `~/.linus-ai/rag-audit-YYYY-MM.jsonl`, propagated to `LINUS_AI_AUDIT_EXPORT_DIRS`.
