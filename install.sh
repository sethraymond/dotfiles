#!/bin/bash

# Shamelessly borrowed from benjamg/dotfiles

set -e

ERROR_APP_NAME=$0
base_dir=$( cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

function die()
{
    echo "${ERROR_APP_NAME}: ${1}" 1>&2
    exit 1
}

function process_module()
{
    if [[ ! -d "${base_dir}/$1" ]]; then
        die "Unable to locate module '$1'"
    fi

    if [[ -d "${base_dir}/$1/stow" ]]; then
        stow -v -d "${base_dir}/$1" -t "${HOME}" stow
    fi

    if [[ -f "${base_dir}/$1/setup.sh" ]]; then
        ${base_dir}/$1/setup.sh
    fi
}

declare -a common_preinstalled_files=("${HOME}/.zshrc" "${HOME}/.zprofile" "${HOME}/.bashrc" "${HOME}/.profile" "${HOME}/.gitconfig")
for f in "${common_preinstalled_files[@]}"
do
    if [ ! -L "$f" ] && [ -e "$f" ]; then  # if it's not a link, it's definitely not owned by stow
        echo "Found $f, saving off as ${f}.old..."
        mv "$f" "${f}.old"
    fi
done

mkdir -p "${HOME}/.config"

basedir=`pwd`
declare -a modules=("bash" "bat" "fzf" "git" "lazygit" "neovim" "ohmyposh" "shell" "vim" "yazi" "zsh")
for module in "${modules[@]}"
do
    process_module $module
done

declare -a desktop_modules=("fontconfig" "kitty" "niri" "tmux" "noctalia")
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
            break
            ;;
    esac
done

if $desktop; then
    for module in "${desktop_modules[@]}"
    do
        process_module $module
    done
fi
