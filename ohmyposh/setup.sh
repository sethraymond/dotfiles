#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

ensure_command curl
ensure_local_bin

target="$HOME/.local/bin/oh-my-posh"

if [ -d "$target" ]; then
    if [ -x "$target/oh-my-posh" ]; then
        log "Repairing legacy Oh My Posh install path"
        mv "$target/oh-my-posh" "$target.tmp"
        rmdir "$target"
        mv "$target.tmp" "$target"
    else
        die "$target is a directory, but no executable was found inside it"
    fi
fi

if has oh-my-posh; then
    log "Oh My Posh already exists"
    exit 0
fi

case "$(architecture)" in
    x86_64)
        asset="posh-linux-amd64"
        ;;
    arm64)
        asset="posh-linux-arm64"
        ;;
esac

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

log "Installing Oh My Posh"

curl -fL \
    "https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/$asset" \
    -o "$tmp/oh-my-posh"

install -m 0755 "$tmp/oh-my-posh" "$HOME/.local/bin/oh-my-posh"

log "Oh My Posh installed"
