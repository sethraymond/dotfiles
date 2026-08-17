#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

if has zsh; then
    log "zsh already exists"
else
    ensure_command zsh
    log "zsh installed"
fi

ensure_command git

ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [ ! -e "$ZINIT_HOME" ]; then
    log "Installing Zinit"
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone \
        https://github.com/zdharma-continuum/zinit.git \
        "$ZINIT_HOME"
elif [ -d "$ZINIT_HOME/.git" ]; then
    log "Updating Zinit"
    git -C "$ZINIT_HOME" pull --ff-only
else
    die "$ZINIT_HOME exists but is not a git checkout"
fi

log "zsh setup complete"
