#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

if has yazi && has ya; then
    log "Yazi already exists"
    exit 0
fi

ensure_command curl
ensure_command unzip
ensure_local_bin

case "$(architecture)" in
    x86_64)
        target="x86_64-unknown-linux-gnu"
        ;;
    arm64)
        target="aarch64-unknown-linux-gnu"
        ;;
esac

log "Installing Yazi"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

archive="yazi-${target}.zip"

curl -fsSL \
    "https://github.com/sxyazi/yazi/releases/latest/download/$archive" \
    -o "$tmp/yazi.zip"

unzip -q "$tmp/yazi.zip" -d "$tmp"

directory="$tmp/yazi-${target}"

install -m 0755 "$directory/yazi" "$HOME/.local/bin/yazi"
install -m 0755 "$directory/ya" "$HOME/.local/bin/ya"

log "Yazi installed"
