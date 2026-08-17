#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

if has fc-match; then
    log "fontconfig already exists"
    exit 0
fi

ensure_command fc-match fontconfig
log "fontconfig installed"
