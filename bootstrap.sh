#!/bin/bash

set -e

apt-get install -y git
git clone git@github.com:sethraymond/dotfiles "$HOME/.dotfiles"

pushd "$HOME/.dotfiles"
./install.sh
popd
