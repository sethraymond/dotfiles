#!/bin/bash

# Shamelessly borrowed from benjamg/dotfiles

set -e

sudo apt-get install -y stow

declare -a common_preinstalled_files=("${HOME}/.zshrc" "${HOME}/.zprofile" "${HOME}/.bashrc" "${HOME}/.profile" "${HOME}/.gitconfig")
for f in "${arr[@]}"
do
    if [! test -L $f]; then  # if it's not a link, it's probably not owned by stow
        rm $f
    fi
done
stow bash bat fzf git lazygit neovim ohmyposh shell tmux zsh
