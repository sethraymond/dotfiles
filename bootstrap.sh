#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Switching to root to install packages..."
    sudo bash <<EOF
    apt-get update
    apt-get install -y git stow
EOF
else
    # already running as root, just install...
    apt-get update
    apt-get install -y git stow
fi

git clone https://github.com/sethraymond/dotfiles.git "$HOME/.dotfiles"

pushd "$HOME/.dotfiles"
./install.sh
popd
