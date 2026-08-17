#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

if has tmux; then
    log "tmux already exists"
else
    ensure_command tmux
    log "tmux installed"
fi

ensure_command git

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TPM_DIR/.git" ]; then
    log "Installing tmux plugin manager"
    git clone \
        https://github.com/tmux-plugins/tpm \
        "$TPM_DIR"
else
    log "Updating tmux plugin manager"
    git -C "$TPM_DIR" pull --ff-only
fi

log "tmux setup complete"
