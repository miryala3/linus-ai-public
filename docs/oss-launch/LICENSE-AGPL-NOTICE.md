# GNU Affero General Public License v3.0

The LINUS-AI open-core components (everything in this repo *except* the
`license_server/`, `paypal/`, and `linus-ai-private/` paths) are licensed
under the **GNU Affero General Public License v3.0** — full text at
<https://www.gnu.org/licenses/agpl-3.0.txt>.

> Copyright (C) 2024-2026 Linus Software, LLC
>
> This program is free software: you can redistribute it and/or modify it
> under the terms of the GNU Affero General Public License as published by
> the Free Software Foundation, either version 3 of the License, or (at
> your option) any later version.
>
> This program is distributed in the hope that it will be useful, but
> WITHOUT ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero
> General Public License for more details.
>
> You should have received a copy of the GNU Affero General Public License
> along with this program. If not, see <https://www.gnu.org/licenses/>.

## What this means in practice

| You can | You cannot |
|---|---|
| Run LINUS-AI for yourself or your business — free | Distribute a modified version without also publishing your source |
| Fork the code, modify it, redistribute it under AGPL | Run a modified LINUS-AI as a **hosted service** without offering the modified source to your users (this is the §13 network clause) |
| Use it in commercial production for your own customers | Strip the `AGPL-3.0` notices from source headers |
| Self-host the license server (proprietary modules excluded) | Sell hosted LINUS-AI access under a closed proprietary license without a separate commercial license from us |

## Dual-licensing for commercial use

If the AGPL §13 (network clause) is incompatible with how you want to ship —
for example, you want to offer hosted LINUS-AI to your own customers as part
of a closed-source SaaS — buy a **commercial license** from us:

→ <support@linus-ai.com> · subject: `commercial license inquiry`

Pricing for commercial dual-license starts at $5,000/yr per company, regardless
of seat count, and waives the AGPL §13 source-disclosure requirement.

## What's NOT AGPL

These components are **proprietary** and not open-sourced — they live in the
private `linus-ai-private` repository and are bundled into installer
artifacts only:

- `license_server/` — the FastAPI service that issues `.lic` certificates
- `paypal/` integration adapters used by the license server
- Anything containing `PRIVATE_KEY` or signing material

The Ed25519 **public** keys embedded in the desktop apps for offline cert
verification are AGPL — public keys are not secrets.

## Contributor License Agreement

By contributing to this repo (via PR, patch, or commit) you agree to the CLA
in [CLA.md](./CLA.md). The CLA grants Linus Software, LLC the right to
relicense your contribution under the dual-license model above.
