# dotfiles
My dotfiles are designed to work with stow. This repo is also designed to
actually set up the environment properly by using package managers (right now
it supports `apt-get`, `pacman`, and `yay`), through other software management
and by downloading release artifacts where that is more appropriate.

Package manager detection prefers `yay` when it is available and the installer
is not running as root, then falls back to `pacman`, then `apt-get`. Set
`DOTFILES_PACKAGE_MANAGER` to `yay`, `pacman`, or `apt-get` to force one.
The installer installs Go from the package manager by default. Set
`DOTFILES_GO_SOURCE=github` and optionally `DOTFILES_GO_VERSION` to use the
official Linux tarball instead.
Neovim setup installs Neovim and Tree-sitter through the package manager by
default. Set `DOTFILES_NEOVIM_SOURCE=github` or
`DOTFILES_TREE_SITTER_SOURCE=github` to use the upstream GitHub binaries
instead.

NOTE: System configuration isn't actually working quite yet...

There's two ways to install everything:
1. Clone this repo and run the `install.sh` script
2. Use the raw URL for `bootstrap.sh` and `curl`/`wget` that URL and pipe it to
   `bash`
