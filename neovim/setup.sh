#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

install_neovim() {
    if has nvim; then
        log "neovim already exists"
        return 0
    fi

    ensure_command curl

    log "Installing Neovim"

    local asset
    case "$(architecture)" in
        x86_64)
            asset="nvim-linux-x86_64.tar.gz"
            ;;
        arm64)
            asset="nvim-linux-arm64.tar.gz"
            ;;
    esac

    local install_dir
    install_dir="$HOME/neovim"

    local tmp
    tmp="$(mktemp -d)"

    curl -fsSL \
        "https://github.com/neovim/neovim/releases/latest/download/$asset" \
        -o "$tmp/nvim.tar.gz"

    rm -rf "$install_dir"
    mkdir -p "$install_dir"

    tar \
        --strip-components=1 \
        -xzf "$tmp/nvim.tar.gz" \
        -C "$install_dir"

    rm -rf "$tmp"

    log "Neovim installed to $install_dir"
}

install_tree_sitter() {
    local target
    target="$HOME/.local/bin/tree-sitter"

    if [ -x "$target" ] && [ ! -d "$target" ]; then
        log "Tree-sitter already exists at $target"
        return 0
    elif [ -e "$target" ]; then
        die "$target exists but is not an executable file"
    fi

    ensure_command curl
    ensure_command unzip
    ensure_local_bin

    local asset
    case "$(architecture)" in
        x86_64)
            asset="tree-sitter-cli-linux-x64.zip"
            ;;
        arm64)
            asset="tree-sitter-cli-linux-arm64.zip"
            ;;
    esac

    local tmp
    tmp="$(mktemp -d)"

    log "Installing Tree-sitter"

    curl -fsSL \
        "https://github.com/tree-sitter/tree-sitter/releases/latest/download/$asset" \
        -o "$tmp/tree-sitter.zip"

    unzip -q "$tmp/tree-sitter.zip" -d "$tmp"
    install -m 0755 "$tmp/tree-sitter" "$target"

    rm -rf "$tmp"

    log "Tree-sitter installed to $target"
}

install_neovim
install_tree_sitter
