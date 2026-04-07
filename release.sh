#!/usr/bin/env bash
# release.sh — publish linus-ai binaries to GitHub Releases
#
# Usage:
#   ./release.sh 3.0.0
#   ./release.sh 3.0.0 /custom/path/to/dist
#
# Requirements:
#   brew install gh    # GitHub CLI, must be authenticated
#   gh auth login
#
# The script:
#   1. Copies and renames binaries from DIST_DIR into release-assets/
#   2. Generates SHA256SUMS.txt
#   3. Creates the GitHub Release if it doesn't exist (never deletes an existing one)
#   4. Uploads any assets not already attached to the release

set -euo pipefail

# ── Configuration ─────────────────────────────────────────────────────────────
# Override DIST_DIR via second argument or environment variable.
# Kept as a variable rather than a hard-coded sibling path so the script
# doesn't expose where the private build repo lives.

VERSION="${1:-}"
DIST_DIR="${2:-${LINUS_DIST_DIR:-}}"

if [[ -z "$VERSION" ]]; then
  echo "Usage: $0 <version> [dist-dir]"
  echo "  e.g. $0 3.0.0"
  echo ""
  echo "  dist-dir can also be set via the LINUS_DIST_DIR environment variable."
  exit 1
fi

if [[ -z "$DIST_DIR" ]]; then
  echo "Error: dist directory required."
  echo "  Pass it as the second argument or set LINUS_DIST_DIR=/path/to/dist"
  exit 1
fi

if [[ ! -d "$DIST_DIR" ]]; then
  echo "Error: dist directory not found: $DIST_DIR"
  exit 1
fi

TAG="v${VERSION}"
REPO="miryala3/linus-ai-public"
ASSETS_DIR="release-assets"

echo "==> Building release ${TAG} from ${DIST_DIR}"

# ── 1. Collect and rename binaries ────────────────────────────────────────────

rm -rf "${ASSETS_DIR}"
mkdir -p "${ASSETS_DIR}"

copy_binary() {
  local src="$1"
  local dest="${ASSETS_DIR}/$2"
  if [[ -f "$src" ]]; then
    cp "$src" "$dest"
    echo "  + $2"
  else
    echo "  ! MISSING: $src (skipping $2)"
  fi
}

copy_binary "${DIST_DIR}/macos-arm64/linus_ai"        "linus-ai-${VERSION}-macos-arm64"
copy_binary "${DIST_DIR}/macos-x86_64/linus_ai"       "linus-ai-${VERSION}-macos-x86_64"
copy_binary "${DIST_DIR}/macos-universal/linus_ai"     "linus-ai-${VERSION}-macos-universal"
copy_binary "${DIST_DIR}/linux-x86_64/linus_ai"       "linus-ai-${VERSION}-linux-x86_64"
copy_binary "${DIST_DIR}/linux-arm64/linus_ai"        "linus-ai-${VERSION}-linux-arm64"
copy_binary "${DIST_DIR}/windows-x86_64/linus_ai.exe" "linus-ai-${VERSION}-windows-x86_64.exe"

chmod +x "${ASSETS_DIR}"/linus-ai-*-macos-* 2>/dev/null || true
chmod +x "${ASSETS_DIR}"/linus-ai-*-linux-* 2>/dev/null || true

# ── 2. Generate SHA256SUMS.txt ────────────────────────────────────────────────

echo "==> Generating SHA256SUMS.txt"
(cd "${ASSETS_DIR}" && shasum -a 256 linus-ai-* > SHA256SUMS.txt)
echo "  SHA256SUMS.txt written"

# ── 3. Create the release if it doesn't exist ────────────────────────────────
# Never delete an existing release — that would break cached download URLs.
# If the release already exists, we skip creation and only upload new assets.

RELEASE_NOTES="## LINUS-AI ${VERSION}

Single binary, no Python, no cloud. Runs entirely on your hardware.

See the [README](https://github.com/${REPO}#how-to-launch) for full launch instructions.

### Quick start

\`\`\`bash
# macOS arm64 (Apple Silicon)
curl -LO https://github.com/${REPO}/releases/download/${TAG}/linus-ai-${VERSION}-macos-arm64
chmod +x linus-ai-${VERSION}-macos-arm64
xattr -d com.apple.quarantine linus-ai-${VERSION}-macos-arm64
./linus-ai-${VERSION}-macos-arm64

# Linux x86_64
curl -LO https://github.com/${REPO}/releases/download/${TAG}/linus-ai-${VERSION}-linux-x86_64
chmod +x linus-ai-${VERSION}-linux-x86_64
./linus-ai-${VERSION}-linux-x86_64
\`\`\`

Verify with \`sha256sum -c SHA256SUMS.txt\`."

if gh release view "${TAG}" --repo "${REPO}" &>/dev/null; then
  echo "==> Release ${TAG} already exists — skipping creation"
else
  echo "==> Creating GitHub Release ${TAG}"
  # Create the tag locally if it doesn't exist, then push it
  if ! git rev-parse "${TAG}" &>/dev/null; then
    git tag "${TAG}"
    git push origin "${TAG}"
  fi
  gh release create "${TAG}" \
    --repo "${REPO}" \
    --title "LINUS-AI ${VERSION}" \
    --notes "${RELEASE_NOTES}"
fi

# ── 4. Upload assets (skip any already attached) ──────────────────────────────

echo "==> Uploading assets to ${TAG}"

# Fetch the list of assets already on the release
EXISTING=$(gh release view "${TAG}" --repo "${REPO}" --json assets \
  --jq '.assets[].name' 2>/dev/null || true)

upload_asset() {
  local file="$1"
  local name
  name="$(basename "$file")"
  if echo "${EXISTING}" | grep -qx "${name}"; then
    echo "  = ${name} (already uploaded, skipping)"
  else
    gh release upload "${TAG}" "${file}" --repo "${REPO}"
    echo "  ↑ ${name}"
  fi
}

for f in "${ASSETS_DIR}"/linus-ai-*; do
  upload_asset "$f"
done
upload_asset "${ASSETS_DIR}/SHA256SUMS.txt"

echo ""
echo "==> Done: https://github.com/${REPO}/releases/tag/${TAG}"
