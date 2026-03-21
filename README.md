# LINUS-AI

**Private, distributed AI inference — runs entirely on your hardware.**

No cloud. No telemetry. All models and conversation data stay on your machine.

---

## Download v2.2.2

| Platform | File |
|---|---|
| macOS (Universal — Apple Silicon + Intel) | `linus-ai-macos-universal` |
| macOS (Apple Silicon) | `linus-ai-macos-arm64` |
| macOS (Intel) | `linus-ai-macos-x86_64` |
| macOS Installer (.dmg) | `linus-ai-macos.dmg` |
| Linux x86_64 | `linus-ai-linux-x86_64` |
| Linux x86_64 (headless/server) | `linus-ai-headless-linux-x86_64` |
| Linux arm64 (headless/server) | `linus-ai-headless-linux-arm64` |
| Windows x86_64 (.exe) | `linus-ai-windows-x86_64.exe` |
| Windows x86_64 (MSIX installer) | `linus-ai-windows-x86_64.msix` |
| iOS (XCFramework staticlib) | `LinusAIEngine.xcframework.zip` |

Verify with `SHA256SUMS.txt`.

---

## Quick Start

**macOS / Linux**
```bash
chmod +x linus-ai-*
./linus-ai-macos-universal   # or the binary for your platform
# Open http://localhost:9480 in your browser
```

**Windows**
```
Run linus-ai-windows-x86_64.exe  (or install the .msix)
Open http://localhost:9480 in your browser
```

---

## Tiers

| | Community | Professional | Team | Studio | Enterprise |
|---|---|---|---|---|---|
| **Price** | Free forever | $99/yr · $299 perp | $349/yr · $999 perp | $899/yr · $2,499 perp | $2,499/yr |
| **Seats** | 1 | 1 | 5 | 20 | Unlimited |
| **Max model size** | 7B params | 70B params | 70B params | 70B params | Unlimited |
| **AI profiles** | 6 built-in | 14 + custom | 14 + custom | 14 + custom | Unlimited |
| **Local inference** | ✓ | ✓ | ✓ | ✓ | ✓ |
| **GUI** | ✓ | ✓ | ✓ | ✓ | ✓ |
| **Tensor parallel** | — | ✓ | ✓ | ✓ | ✓ |
| **Pipeline parallel** | — | ✓ | ✓ | ✓ | ✓ |
| **Mesh networking** | — | ✓ | ✓ | ✓ | ✓ |
| **Custom prompts** | — | ✓ | ✓ | ✓ | ✓ |
| **Federated learning** | — | — | ✓ | ✓ | ✓ |
| **Blockchain audit log** | — | — | ✓ | ✓ | ✓ |
| **Air-gap activation** | — | — | — | — | ✓ |
| **SSO / LDAP** | — | — | — | — | ✓ |
| **Fine-tuning** | — | — | — | — | ✓ |
| **Support** | Community | Email | Priority email | Priority + 48h SLA | Dedicated + on-site |
| **License transfer** | — | ✓ | ✓ | ✓ | ✓ |

Purchase at **[linus-ai.com/pricing](https://linus-ai.com/pricing)**

---

## Source Licensing

LINUS-AI is distributed as a binary. Source access is available separately:

| | Description | Price |
|---|---|---|
| **Source Viewer** | Read-only audit access (up to 3 reviewers) | $499/year |
| **Source Viewer Enterprise** | Unlimited internal reviewers | Contact us |
| **Enterprise Source** | Build + modify internally (Enterprise subscribers only) | Contact us |

See [SOURCE-VIEWER-LICENSE.md](SOURCE-VIEWER-LICENSE.md) and
[ENTERPRISE-SOURCE-LICENSE.md](ENTERPRISE-SOURCE-LICENSE.md) for terms.

---

## Recommended Models

Download GGUF models and place them in your model directory:

| Model | Size | Use case |
|---|---|---|
| `Llama-3.1-8B-Instruct.Q4_K_M.gguf` | ~5 GB | Community tier — general use |
| `Llama-3.1-70B-Instruct.Q4_K_M.gguf` | ~40 GB | Professional+ — high quality |
| `Phi-3-mini-4k-instruct.Q4_K_M.gguf` | ~2 GB | Low-RAM devices |
| `Mistral-7B-Instruct-v0.3.Q4_K_M.gguf` | ~4 GB | Fast responses |

Model directory: `~/.local/share/linus_ai/models/` (Linux/Windows) or
`~/Library/Application Support/linus_ai/models/` (macOS)

---

## System Requirements

| | Minimum | Recommended |
|---|---|---|
| RAM | 8 GB | 16 GB+ |
| Disk | 10 GB | 50 GB+ (for large models) |
| GPU | Optional | Metal (macOS) · CUDA (NVIDIA) · ROCm (AMD) |
| OS | macOS 12+ · Ubuntu 20.04+ · Windows 10+ | Latest stable |

---

## Mesh Mode (Professional+)

Run LINUS-AI on multiple machines and combine their compute:

```bash
# Node 1 (primary)
LINUS_AI_MODE=full ./linus-ai

# Node 2 (additional)
LINUS_AI_MODE=mesh ./linus-ai
# Nodes discover each other automatically via mDNS on the same network
```

---

## License

- **Community use** (personal, academic, non-profit): Free. See [LICENSE.md](LICENSE.md).
- **Commercial use**: Requires a paid license. See [linus-ai.com/pricing](https://linus-ai.com/pricing).
- **Source access**: See [SOURCE-VIEWER-LICENSE.md](SOURCE-VIEWER-LICENSE.md).

---

## Support

- Community: [github.com/LINUS-AI-PRO/linus-ai-public/issues](https://github.com/LINUS-AI-PRO/linus-ai-public/issues)
- Email (Professional+): support@linus-ai.com
- Documentation: [linus-ai.com/docs](https://linus-ai.com/docs)
