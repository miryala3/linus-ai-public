#!/usr/bin/env bash
# run.sh — Serve linus-ai-public release assets locally
#
# Useful for inspecting release bundles before pushing.
#
# Usage:
#   ./run.sh              # Serve on http://localhost:8090 (default)
#   ./run.sh 9000         # Serve on custom port
#
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

YELLOW='\033[1;33m'; NC='\033[0m'
info() { echo -e "${YELLOW}▶ $*${NC}"; }

PORT="${1:-8090}"
info "Serving linus-ai-public on http://localhost:${PORT}"
info "Press Ctrl+C to stop"
python3 -m http.server "$PORT"
