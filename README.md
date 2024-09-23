# dotfiles
My dotfiles are designed to work with stow. This repo is also designed to
actually set up the environment properly by using package managers (right now
it only supports `apt`), through other software management (e.g. `go get`), and
by downloading and building from source.

NOTE: System configuration isn't actually working quite yet...

There's two ways to install everything:
1. Clone this repo and run the `install.sh` script
2. Use the raw URL for `bootstrap.sh` and `curl`/`wget` that URL and pipe it to
   `bash`
