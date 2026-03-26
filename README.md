# LINUS-AI Suite

**Private, distributed AI inference — runs entirely on your hardware.**

No cloud. No telemetry. All models and conversation data stay on your machine.

→ **[linus-ai.com](https://linus-ai.com)** · [Pricing](https://linus-ai.com/pricing) · [Docs](https://linus-ai.com/docs) · [Store](https://linus-ai.com/store) · [Support](mailto:support@linus-ai.com)

---

## Products

| Product | Description | Community | Paid tiers |
|---|---|---|---|
| **[LINUS-AI](#linus-ai)** | Local AI inference desktop app | ✓ Free | Professional · Team · Enterprise |
| **[BizCore](#bizcore)** | Local-first business OS — CRM, HR, finance | — | Starter · Business · Unlimited |
| **[LINUS-Day](#linus-day)** | AI daily planner | — | Beta · Pro |
| **[aiMED](#aimed)** | HIPAA-ready clinical AI | — | Contact Sales |

---

## LINUS-AI

### Download v2.6.0

#### Community (Free)

> Community binaries run in **Starter mode**: local inference, GUI, up to 5B models, single seat.
> Upgrade at **[linus-ai.com/pricing](https://linus-ai.com/pricing)** to unlock vault, agentic mode, mesh, and more.

| Platform | File |
|---|---|
| macOS Universal DMG (Apple Silicon + Intel) | [`linus-ai-macos.dmg`](https://github.com/miryala3/linus-ai-public/releases/latest/download/linus-ai-macos.dmg) |
| macOS Universal binary | [`linus-ai-macos-universal`](https://github.com/miryala3/linus-ai-public/releases/latest/download/linus-ai-macos-universal) |
| Linux x86_64 GUI | [`linus-ai-linux-x86_64`](https://github.com/miryala3/linus-ai-public/releases/latest/download/linus-ai-linux-x86_64) |
| Linux x86_64 headless | [`linus-ai-headless-linux-x86_64`](https://github.com/miryala3/linus-ai-public/releases/latest/download/linus-ai-headless-linux-x86_64) |
| Linux arm64 headless | [`linus-ai-headless-linux-arm64`](https://github.com/miryala3/linus-ai-public/releases/latest/download/linus-ai-headless-linux-arm64) |
| macOS arm64 headless | [`linus-ai-headless-macos-arm64`](https://github.com/miryala3/linus-ai-public/releases/latest/download/linus-ai-headless-macos-arm64) |
| macOS x86_64 headless | [`linus-ai-headless-macos-x86_64`](https://github.com/miryala3/linus-ai-public/releases/latest/download/linus-ai-headless-macos-x86_64) |
| Windows x86_64 installer (.msix) | [`linus-ai-windows-x86_64.msix`](https://github.com/miryala3/linus-ai-public/releases/latest/download/linus-ai-windows-x86_64.msix) |
| Windows x86_64 binary | [`linus-ai-windows-x86_64.exe`](https://github.com/miryala3/linus-ai-public/releases/latest/download/linus-ai-windows-x86_64.exe) |
| Windows x86_64 headless | [`linus-ai-headless-windows-x86_64.exe`](https://github.com/miryala3/linus-ai-public/releases/latest/download/linus-ai-headless-windows-x86_64.exe) |
| Debian/Ubuntu package | [`linus-ai_2.6.0_amd64.deb`](https://github.com/miryala3/linus-ai-public/releases/latest/download/linus-ai_2.6.0_amd64.deb) |

Verify with [`SHA256SUMS.txt`](https://github.com/miryala3/linus-ai-public/releases/latest/download/SHA256SUMS.txt).

#### Quick Start

**macOS DMG**
```
Open linus-ai-macos.dmg → drag LINUS-AI to Applications
Right-click → Open (first launch — Gatekeeper prompt)
```

**macOS / Linux binary**
```bash
chmod +x linus-ai-macos-universal   # or your platform binary
./linus-ai-macos-universal
# Open http://localhost:9480 in your browser
```

**Windows**
```
Run linus-ai-windows-x86_64.msix  (or .exe)
Open http://localhost:9480 in your browser
```

**Linux — GUI runtime dependencies**
```bash
sudo apt-get install -y libwebkit2gtk-4.1-0 libgtk-3-0 \
  libayatana-appindicator3-1 librsvg2-2 libxdo3
```
The headless binary (`linus-ai-headless-linux-x86_64`) has no extra requirements.

### Tiers

| | Community | Professional | Team | Enterprise |
|---|---|---|---|---|
| **Price** | Free | $99/yr · $299 perp | $349/yr · $999 perp | $4,999/yr |
| **Seats** | 1 | 1 | 5 | Unlimited |
| **Local inference** | ✓ | ✓ | ✓ | ✓ |
| **GUI** | ✓ | ✓ | ✓ | ✓ |
| **Model size limit** | 5B | Unlimited | Unlimited | Unlimited |
| **Vault encrypted memory** | — | ✓ | ✓ | ✓ |
| **Agentic mode / RAG** | — | ✓ | ✓ | ✓ |
| **Mesh networking** | — | — | ✓ | ✓ |
| **Tensor + pipeline parallel** | — | — | ✓ | ✓ |
| **Blockchain audit log** | — | — | ✓ | ✓ |
| **Air-gap activation** | — | — | — | ✓ |
| **SSO / LDAP** | — | — | — | ✓ |
| **Fine-tuning** | — | — | — | ✓ |
| **Support** | Community | Email | Priority email | Email |

**→ [Buy a license at linus-ai.com/pricing](https://linus-ai.com/pricing)**

### Recommended Models

Download GGUF models and place them in your model directory:

| Model | Size | Best for |
|---|---|---|
| `Phi-3-mini-4k-instruct.Q4_K_M.gguf` | ~2 GB | Community — general use |
| `Llama-3.1-70B-Instruct.Q4_K_M.gguf` | ~40 GB | Professional+ — high quality |
| `Phi-3-mini-4k-instruct.Q4_K_M.gguf` | ~2 GB | Low-RAM devices |
| `Mistral-7B-Instruct-v0.3.Q4_K_M.gguf` | ~4 GB | Fast responses |

**Model directory:**
- macOS: `~/Library/Application Support/linus_ai/models/`
- Linux: `~/.local/share/linus_ai/models/`
- Windows: `%APPDATA%\linus_ai\models\`

### System Requirements

| | Minimum | Recommended |
|---|---|---|
| RAM | 8 GB | 16 GB+ |
| Disk | 10 GB | 50 GB+ (for large models) |
| GPU | Optional | Metal (macOS) · CUDA (NVIDIA) · ROCm (AMD) |
| OS | macOS 12+ · Ubuntu 20.04+ · Windows 10+ | Latest stable |

### Mesh Mode (Team+)

```bash
# Node 1 (primary)
LINUS_AI_MODE=full ./linus-ai

# Node 2 (worker — same LAN)
LINUS_AI_MODE=mesh ./linus-ai
# Nodes discover each other automatically via mDNS
```

---

## BizCore

**Local-first business OS — invoicing, CRM, HR, finance, and AI-assisted workflows. No SaaS fees. No data leaving your machine.**

→ **[linus-ai.com/products/bizcore](https://linus-ai.com/products/bizcore)**

### Tiers

| | Starter | Business | Unlimited |
|---|---|---|---|
| **Price** | $79 one-time | $199 one-time | $499 one-time |
| **Core modules** | 6 (Dashboard, Invoicing, Contacts, Tasks, Calendar, Documents) | All modules | All modules |
| **AI Smart Fill** | ✓ | ✓ | ✓ |
| **Users** | 1 | 5 | Unlimited |
| **AI CRM** | — | ✓ | ✓ |
| **HR & Payroll** | — | ✓ | ✓ |
| **Multi-entity finance** | — | — | ✓ |
| **API access** | — | — | ✓ |

**→ [Buy BizCore at linus-ai.com/products/bizcore](https://linus-ai.com/products/bizcore)**

BizCore is a licensed product — no free tier. Download available after purchase via [linus-ai.com/download](https://linus-ai.com/download).

---

## LINUS-Day

**AI daily planner that learns your work style — schedules, tasks, and focus blocks, all local.**

→ **[linus-ai.com/products/day](https://linus-ai.com/products/day)**

Currently in beta. Pre-order at [linus-ai.com/products/day](https://linus-ai.com/products/day) — download available at release.

---

## aiMED

**HIPAA-ready clinical AI — on-premise deployment, no PHI leaves your infrastructure.**

→ **[linus-ai.com/products/med](https://linus-ai.com/products/med)**

Enterprise and clinical deployment only. [Contact sales](mailto:support@linus-ai.com) for evaluation access and pricing.

---

## Licensing

| Document | Description |
|---|---|
| [LICENSE.md](LICENSE.md) | Community use terms — free for personal, academic, non-profit |
| [LICENSE-COMMERCIAL.md](LICENSE-COMMERCIAL.md) | Commercial license terms (Startup · Studio · Enterprise) |
| [THIRD-PARTY-LICENSES.md](THIRD-PARTY-LICENSES.md) | Open-source dependencies and their licenses |

- **Community use** (personal, academic, non-profit): free. See [LICENSE.md](LICENSE.md).
- **Commercial use**: requires a paid license. See [linus-ai.com/pricing](https://linus-ai.com/pricing).
- **Source access**: available separately under commercial license terms.

---

## Support

| Channel | Available to |
|---|---|
| [GitHub Issues](https://github.com/miryala3/linus-ai-public/issues) | All users |
| [support@linus-ai.com](mailto:support@linus-ai.com) | All tiers |
| Priority email | Professional+ |
| Email support | Enterprise |
| [linus-ai.com/docs](https://linus-ai.com/docs) | All users |
