# Third-Party Licenses

LINUS-AI is compiled from Rust crates and Python dependencies. The licenses
for all third-party components are listed below.

All Rust crates used by LINUS-AI are MIT and/or Apache 2.0 licensed.
The full text of the MIT License and Apache License 2.0 are reproduced at
the end of this file.

---

## Rust Crates

| Crate | Version | License |
|-------|---------|---------|
| tokio | 1.x | MIT |
| axum | 0.7.x | MIT |
| serde | 1.x | MIT / Apache-2.0 |
| serde_json | 1.x | MIT / Apache-2.0 |
| clap | 4.x | MIT / Apache-2.0 |
| tracing | 0.1.x | MIT |
| tracing-subscriber | 0.3.x | MIT |
| sha2 | 0.10.x | MIT / Apache-2.0 |
| hmac | 0.12.x | MIT / Apache-2.0 |
| uuid | 1.x | MIT / Apache-2.0 |
| tokio-stream | 0.1.x | MIT |
| futures | 0.3.x | MIT / Apache-2.0 |
| thiserror | 1.x | MIT / Apache-2.0 |
| anyhow | 1.x | MIT / Apache-2.0 |
| libloading | 0.8.x | ISC |
| rusqlite | 0.31.x | MIT |
| chacha20poly1305 | 0.10.x | MIT / Apache-2.0 |
| base32 | 0.4.x | MIT |
| base64 | 0.22.x | MIT / Apache-2.0 |
| tower | 0.4.x | MIT |
| tower-http | 0.5.x | MIT |
| bytes | 1.x | MIT |
| http-body-util | 0.1.x | MIT |
| rand | 0.8.x | MIT / Apache-2.0 |
| reqwest | 0.12.x | MIT / Apache-2.0 |
| sha1 | 0.10.x | MIT / Apache-2.0 |
| socket2 | 0.5.x | MIT / Apache-2.0 |
| cfg-if | 1.x | MIT / Apache-2.0 |
| encoding_rs | 0.8.x | MIT / Apache-2.0 |
| pbkdf2 | 0.12.x | MIT / Apache-2.0 |
| dirs | 5.x | MIT / Apache-2.0 |
| ureq | 2.x | MIT / Apache-2.0 |
| getrandom | 0.2.x | MIT / Apache-2.0 |
| log | 0.4.x | MIT / Apache-2.0 |
| ed25519-dalek | 2.x | BSD-3-Clause |
| tao | 0.26.x | Apache-2.0 |
| wry | 0.44.x | Apache-2.0 |
| tray-icon | 0.17.x | MIT / Apache-2.0 |
| muda | 0.14.x | MIT / Apache-2.0 |
| raw-window-handle | 0.6.x | MIT / Apache-2.0 / Zlib |
| android-activity | 0.6.x | MIT / Apache-2.0 |
| android_logger | 0.15.x | MIT / Apache-2.0 |
| tauri | 2.x | MIT / Apache-2.0 |
| tauri-build | 2.x | MIT / Apache-2.0 |
| mistralrs | 0.7.x | MIT |

SQLite (bundled via rusqlite `bundled` feature) is in the **public domain**
— no license restrictions. See https://www.sqlite.org/copyright.html

---

## MIT License (full text)

```
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## Apache License 2.0

Full text: https://www.apache.org/licenses/LICENSE-2.0

Key terms: You may reproduce and distribute copies of the Work or Derivative
Works in any form, provided that you include a copy of this License and a
NOTICE file (if applicable) in your distribution.

---

## BSD-3-Clause License (ed25519-dalek)

```
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
   this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
3. Neither the name of the copyright holder nor the names of its contributors
   may be used to endorse or promote products derived from this software
   without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
```

---

## ISC License (libloading)

```
Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE
USE OR PERFORMANCE OF THIS SOFTWARE.
```

---

*To regenerate this file from the current lockfile:*
```bash
cargo install cargo-about
cargo about generate --workspace > THIRD-PARTY-LICENSES.html
```
