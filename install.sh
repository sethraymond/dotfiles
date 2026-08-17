#!/usr/bin/env bash

# Shamelessly borrowed from benjamg/dotfiles

set -euo pipefail

base_dir=$( cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
source "$base_dir/lib/install.sh"

process_module() {
    local module="$1"

    if [[ ! -d "${base_dir}/$module" ]]; then
        die "Unable to locate module '$module'"
    fi

    if [[ -d "${base_dir}/$module/stow" ]]; then
        log "Stowing $module"
        stow -v -d "${base_dir}/$module" -t "${HOME}" stow
    fi

    if [[ -f "${base_dir}/$module/setup.sh" ]]; then
        log "Running $module setup"
        "${base_dir}/$module/setup.sh"
    fi
}

install_prerequisites() {
    log "Installing prerequisites"
    refresh_package_index
    ensure_command git
    ensure_command stow
    ensure_command curl
    ensure_command tar
    ensure_go
}

desktop=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --desktop)
            desktop=true
            shift
            ;;
        --)
            shift
            break
            ;;
        *)
            die "Unknown argument: $1"
            ;;
    esac
done

install_prerequisites

declare -a common_preinstalled_files=("${HOME}/.zshrc" "${HOME}/.zprofile" "${HOME}/.bashrc" "${HOME}/.profile" "${HOME}/.gitconfig")
for f in "${common_preinstalled_files[@]}"
do
    if [ ! -L "$f" ] && [ -e "$f" ]; then  # if it's not a link, it's definitely not owned by stow
        log "Found $f, saving off as ${f}.old"
        mv "$f" "${f}.old"
    fi
done

mkdir -p "${HOME}/.config"

declare -a modules=("bash" "shell" "git" "bat" "fzf" "zoxide" "lazygit" "neovim" "ohmyposh" "vim" "yazi" "zsh")
for module in "${modules[@]}"
do
    process_module "$module"
done

if $desktop; then
    declare -a desktop_modules=("fontconfig" "kitty" "kanshi" "niri" "tmux" "noctalia")
    for module in "${desktop_modules[@]}"
    do
        process_module "$module"
    done
fi
