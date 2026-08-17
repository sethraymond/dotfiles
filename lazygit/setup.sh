#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

ensure_command curl
ensure_local_bin

arch="$(architecture)"

version="$(
    curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest |
        sed -n 's/.*"tag_name": *"v\([^"]*\)".*/\1/p' |
        head -n1
)"

if [ -z "$version" ]; then
    die "Could not determine latest lazygit version"
fi

current=""
if has lazygit; then
    current="$(lazygit --version 2>/dev/null | sed -n 's/.*version=\([^,]*\).*/\1/p')"
fi

if [ "$current" = "$version" ]; then
    log "lazygit $version already exists"
    exit 0
fi

log "Installing lazygit $version"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

curl -fsSL \
    "https://github.com/jesseduffield/lazygit/releases/download/v${version}/lazygit_${version}_Linux_${arch}.tar.gz" |
    tar -xz -C "$tmp" lazygit

install -m 0755 "$tmp/lazygit" "$HOME/.local/bin/lazygit"

log "lazygit $version installed"
