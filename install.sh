#!/bin/bash

# Shamelessly borrowed from benjamg/dotfiles

set -e

function die()
{
    echo "${ERROR_APP_NAME}: ${1}" 1>&2
    exit 1
}

function process_module()
{
    if [[ ! -d "${base_dir}/modules/$1" ]]; then
        die "Unable to locate module '$1'"
    fi

    if [[ -d "${base_dir}/modules/$1/stow" ]]; then
        stow -v -d "${base_dir}/modules/$1/stow" -t "${HOME}" stow
    fi

    if [[ -f "${base_dir}/modules/$1/setup.sh" ]]; then
        ${base_dir}/modules/$1/setup.sh
    fi
}

apt-get install -y stow

declare -a common_preinstalled_files=("${HOME}/.zshrc" "${HOME}/.zprofile" "${HOME}/.bashrc" "${HOME}/.profile" "${HOME}/.gitconfig")
for f in "${arr[@]}"
do
    if [ ! -L "$f" ] && [ -e "$f" ]; then  # if it's not a link, it's definitely not owned by stow
        mv "$f" "${f}.old"
    fi
done

basedir=`pwd`
declare -a modules=("bash" "bat" "fzf" "git" "lazygit" "neovim" "ohmyposh" "shell" "tmux" "vim" "wezterm" "zsh")
for module in "${modules[@]}"
do
    process_module $module
done
