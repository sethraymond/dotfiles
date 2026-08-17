#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

if has kanshi; then
    log "kanshi already exists"
    exit 0
fi

ensure_command kanshi
log "kanshi installed"
