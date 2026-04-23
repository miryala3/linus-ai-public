#!/usr/bin/env bash
# test.sh — Verify linus-ai-public release asset directories are present
#
# Usage:
#   ./test.sh
#
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
info()    { echo -e "${YELLOW}▶ $*${NC}"; }
success() { echo -e "${GREEN}✓ $*${NC}"; }
error()   { echo -e "${RED}✗ $*${NC}" >&2; exit 1; }

info "Checking release asset directories..."
MISSING=0
for d in linus-ai linus-ai-med linus-aimed-ext linus-bizcore linus-bizcore-ext; do
  if [ ! -d "$d" ]; then
    echo -e "  ${RED}MISSING: $d/${NC}"
    MISSING=$((MISSING + 1))
  else
    echo -e "  ${GREEN}OK: $d/${NC}"
  fi
done

[ "$MISSING" -eq 0 ] && success "All release asset directories present" || error "${MISSING} director(ies) missing"
