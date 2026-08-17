#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

log "Installing fzf from package manager"
install_packages fzf
remove_local_bin_shadow fzf

has fzf || die "fzf was installed, but fzf was not found"

log "fzf installed"
