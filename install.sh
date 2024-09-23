#!/bin/bash

# Shamelessly borrowed from benjamg/dotfiles

set -e

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

sudo apt-get install -y stow

#declare -a common_preinstalled_files=("${HOME}/.zshrc" "${HOME}/.zprofile" "${HOME}/.bashrc" "${HOME}/.profile" "${HOME}/.gitconfig")
#for f in "${arr[@]}"
#do
#    if [ ! -L "$f" ]; then  # if it's not a link, it's definitely not owned by stow
#        mv "$f" "${f}.old"
#    fi
#done

basedir=`pwd`
declare -a modules=("$basedir/bash" "$basedir/bat" "$basedir/fzf" "$basedir/git" "$basedir/lazygit" "$basedir/neovim" "$basedir/ohmyposh" "$basedir/shell" "$basedir/tmux" "$basedir/vim" "$basedir/wezterm" "$basedir/zsh")
for module in "${modules[@]}"
do
    pushd $module
    stow -d $module -t "$HOME" stow
    popd
done
