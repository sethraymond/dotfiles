#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

if has fzf; then
    log "fzf already exists"
    exit 0
fi

ensure_command git

log "Installing fzf"

FZF_DIR="$HOME/.fzf"

if [ ! -d "$FZF_DIR/.git" ]; then
    git clone --depth 1 \
        https://github.com/junegunn/fzf.git \
        "$FZF_DIR"
else
    git -C "$FZF_DIR" pull --ff-only
fi

"$FZF_DIR/install" \
    --key-bindings \
    --completion \
    --no-update-rc

log "fzf installed"
