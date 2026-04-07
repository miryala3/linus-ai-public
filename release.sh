#!/usr/bin/env bash
# release.sh — publish linus-ai binaries to GitHub Releases
#
# Usage:
#   ./release.sh 3.0.0 /path/to/linus-ai/dist
#
# Requirements:
#   brew install gh          # GitHub CLI — must be authenticated
#   gh auth login
#
# The script:
#   1. Copies and renames binaries from dist/ into release-assets/
#   2. Generates SHA256SUMS.txt
#   3. Creates (or updates) the GitHub Release for the given tag
#   4. Uploads all assets

set -euo pipefail

VERSION="${1:-}"
DIST_DIR="${2:-../linus-ai/dist}"

if [[ -z "$VERSION" ]]; then
  echo "Usage: $0 <version> [dist-dir]"
  echo "  e.g. $0 3.0.0"
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

copy_binary "${DIST_DIR}/macos-arm64/linus_ai"      "linus-ai-${VERSION}-macos-arm64"
copy_binary "${DIST_DIR}/macos-x86_64/linus_ai"     "linus-ai-${VERSION}-macos-x86_64"
copy_binary "${DIST_DIR}/macos-universal/linus_ai"   "linus-ai-${VERSION}-macos-universal"
copy_binary "${DIST_DIR}/linux-x86_64/linus_ai"     "linus-ai-${VERSION}-linux-x86_64"
copy_binary "${DIST_DIR}/linux-arm64/linus_ai"      "linus-ai-${VERSION}-linux-arm64"
copy_binary "${DIST_DIR}/windows-x86_64/linus_ai.exe" "linus-ai-${VERSION}-windows-x86_64.exe"

# Make binaries executable
chmod +x "${ASSETS_DIR}"/linus-ai-*-macos-* 2>/dev/null || true
chmod +x "${ASSETS_DIR}"/linus-ai-*-linux-* 2>/dev/null || true

# ── 2. Generate SHA256SUMS.txt ────────────────────────────────────────────────

echo "==> Generating SHA256SUMS.txt"
(cd "${ASSETS_DIR}" && shasum -a 256 linus-ai-* > SHA256SUMS.txt)
echo "  SHA256SUMS.txt written"

# ── 3. Create or update the GitHub Release ────────────────────────────────────

echo "==> Creating GitHub Release ${TAG}"

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

# Delete existing release if present (so we can recreate it cleanly)
if gh release view "${TAG}" --repo "${REPO}" &>/dev/null; then
  echo "  Release ${TAG} already exists — deleting and recreating"
  gh release delete "${TAG}" --repo "${REPO}" --yes
  git push origin ":refs/tags/${TAG}" 2>/dev/null || true
fi

git tag -f "${TAG}"
git push origin "${TAG}" --force

gh release create "${TAG}" \
  --repo "${REPO}" \
  --title "LINUS-AI ${VERSION}" \
  --notes "${RELEASE_NOTES}" \
  "${ASSETS_DIR}"/linus-ai-* \
  "${ASSETS_DIR}/SHA256SUMS.txt"

echo ""
echo "==> Done: https://github.com/${REPO}/releases/tag/${TAG}"
echo "    Assets uploaded:"
ls -lh "${ASSETS_DIR}" | awk '{print "    " $0}'
