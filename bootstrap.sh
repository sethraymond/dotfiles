#!/bin/bash

set -e

apt-get install -y git stow
git clone https://github.com/sethraymond/dotfiles.git "$HOME/.dotfiles"

pushd "$HOME/.dotfiles"
./install.sh
popd
