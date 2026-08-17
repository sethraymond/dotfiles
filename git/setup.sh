#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

if has git; then
    log "git already exists"
else
    ensure_command git
    log "git installed"
fi
