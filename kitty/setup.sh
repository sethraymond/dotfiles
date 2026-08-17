#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

if has kitty; then
    log "kitty already exists"
    exit 0
fi

ensure_command curl
ensure_local_bin

log "Installing Kitty"

mkdir -p \
    "$HOME/.local/share/applications"

curl -fsSL https://sw.kovidgoyal.net/kitty/installer.sh |
    sh /dev/stdin launch=n

ln -sf \
    "$HOME/.local/kitty.app/bin/kitty" \
    "$HOME/.local/bin/kitty"

ln -sf \
    "$HOME/.local/kitty.app/bin/kitten" \
    "$HOME/.local/bin/kitten"

cp \
    "$HOME/.local/kitty.app/share/applications/kitty.desktop" \
    "$HOME/.local/share/applications/kitty.desktop"

cp \
    "$HOME/.local/kitty.app/share/applications/kitty-open.desktop" \
    "$HOME/.local/share/applications/kitty-open.desktop"

sed -i \
    "s|Icon=kitty|Icon=$HOME/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" \
    "$HOME/.local/share/applications/kitty"*.desktop

sed -i \
    "s|Exec=kitty|Exec=$HOME/.local/kitty.app/bin/kitty|g" \
    "$HOME/.local/share/applications/kitty"*.desktop

mkdir -p "$HOME/.config"
printf '%s\n' 'kitty.desktop' > "$HOME/.config/xdg-terminals.list"

log "Kitty installed"
