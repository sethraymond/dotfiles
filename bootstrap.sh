#!/bin/bash

sudo apt-get install -y git
git clone git@github.com:sethraymond/dotfiles "$HOME/.dotfiles"

pushd "$HOME/.dotfiles"
./install.sh
popd
