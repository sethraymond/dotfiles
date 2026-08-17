#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/lib/install.sh"

log "Installing zoxide from package manager"
install_packages zoxide
remove_local_bin_shadow zoxide

has zoxide || die "zoxide was installed, but zoxide was not found"

log "zoxide installed"
