#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

install_neovim_from_package() {
    log "Installing Neovim from package manager"
    install_packages neovim

    local install_dir
    install_dir="$HOME/neovim"

    if [ -x "$install_dir/bin/nvim" ]; then
        log "Removing $install_dir so package-managed Neovim is used"
        rm -rf "$install_dir"
        hash -r 2>/dev/null || true
    elif [ -e "$install_dir" ]; then
        die "$install_dir exists but does not look like a managed Neovim install"
    fi

    has nvim || die "neovim was installed, but nvim was not found"

    log "Neovim installed"
}

install_neovim_from_github() {
    local install_dir
    install_dir="$HOME/neovim"

    if [ -x "$install_dir/bin/nvim" ]; then
        log "Neovim already exists at $install_dir"
        return 0
    elif [ -e "$install_dir" ]; then
        die "$install_dir exists but does not look like a managed Neovim install"
    fi

    ensure_command curl
    ensure_command tar

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

install_neovim() {
    case "${DOTFILES_NEOVIM_SOURCE:-package}" in
        package)
            install_neovim_from_package
            ;;
        github)
            install_neovim_from_github
            ;;
        *)
            die "Unsupported DOTFILES_NEOVIM_SOURCE: $DOTFILES_NEOVIM_SOURCE"
            ;;
    esac
}

install_tree_sitter_from_package() {
    log "Installing Tree-sitter from package manager"
    install_packages tree-sitter-cli
    remove_local_bin_shadow tree-sitter

    has tree-sitter || die "tree-sitter-cli was installed, but tree-sitter was not found"
}

install_tree_sitter_from_github() {
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

install_tree_sitter() {
    case "${DOTFILES_TREE_SITTER_SOURCE:-package}" in
        package)
            install_tree_sitter_from_package
            ;;
        github)
            install_tree_sitter_from_github
            ;;
        *)
            die "Unsupported DOTFILES_TREE_SITTER_SOURCE: $DOTFILES_TREE_SITTER_SOURCE"
            ;;
    esac
}

install_neovim
install_tree_sitter
