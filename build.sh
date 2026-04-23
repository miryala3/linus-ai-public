#!/usr/bin/env bash
# build.sh — linus-ai-public release asset host
#
# This repo contains pre-built binaries — there is nothing to compile here.
# Use release.sh to stage and upload new binary releases.
#
# Usage:
#   ./build.sh            # Show repo status + release asset inventory
#   ./build.sh stage      # Run release.sh to stage binaries (requires built artifacts)
#
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
info()    { echo -e "${YELLOW}▶ $*${NC}"; }
success() { echo -e "${GREEN}✓ $*${NC}"; }

TARGET="${1:-status}"

case "$TARGET" in
  stage)
    info "Running release staging script..."
    bash release.sh
    ;;
  status|*)
    info "linus-ai-public release asset inventory:"
    for d in linus-ai linus-ai-med linus-aimed-ext linus-bizcore linus-bizcore-ext; do
      if [ -d "$d" ]; then
        COUNT=$(find "$d" -type f | wc -l | tr -d ' ')
        echo "  $d/ — ${COUNT} files"
      else
        echo "  $d/ — (not present)"
      fi
    done
    success "No build step required (pre-built binary host)"
    ;;
esac
