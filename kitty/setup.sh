#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

log "Installing Kitty from package manager"
install_packages kitty
remove_local_bin_shadow kitty
remove_local_bin_shadow kitten

install_dir="$HOME/.local/kitty.app"
if [ -x "$install_dir/bin/kitty" ]; then
    log "Removing $install_dir so package-managed Kitty is used"
    rm -rf "$install_dir"
elif [ -e "$install_dir" ]; then
    die "$install_dir exists but does not look like a managed Kitty install"
fi

rm -f \
    "$HOME/.local/share/applications/kitty.desktop" \
    "$HOME/.local/share/applications/kitty-open.desktop"

mkdir -p "$HOME/.config"
printf '%s\n' 'kitty.desktop' > "$HOME/.config/xdg-terminals.list"

has kitty || die "kitty was installed, but kitty was not found"
has kitten || die "kitty was installed, but kitten was not found"

log "Kitty installed"
