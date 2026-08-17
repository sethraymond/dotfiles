#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

if has bat; then
    log "bat already exists"
    exit 0
fi

log "Installing bat"
install_packages bat

if ! has bat && has batcat; then
    ensure_local_bin
    ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
fi

if has bat; then
    log "bat installed"
else
    die "bat was installed, but no bat or batcat command was found"
fi
