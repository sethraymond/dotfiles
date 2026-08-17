#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

if has zoxide; then
    log "zoxide already exists"
    exit 0
fi

ensure_command curl
ensure_local_bin

log "Installing zoxide"

curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh |
    sh

log "zoxide installed"
