#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

log "Installing lazygit from package manager"
install_packages lazygit
remove_local_bin_shadow lazygit

has lazygit || die "lazygit was installed, but lazygit was not found"

log "lazygit installed"
