#!/usr/bin/env bash
# build.sh — standardized GUI build wrapper for linus-ai-public
set -euo pipefail

GUI_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$GUI_DIR/.." && pwd)"
GUI_PROJECT_NAME="$(basename "$PROJECT_DIR")"
GUI_PROJECT_DIR="$PROJECT_DIR"
GUI_WORKSPACE_DIR="$(cd "$PROJECT_DIR/.." && pwd)"
export GUI_DIR GUI_PROJECT_NAME GUI_PROJECT_DIR GUI_WORKSPACE_DIR

source "$GUI_WORKSPACE_DIR/scripts/gui-build-common.sh"
gui_run "$@"
