#!/usr/bin/env bash

set -euo pipefail

has() {
    command -v "$1" >/dev/null 2>&1
}

die() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 1
}

run_as_root() {
    if [ "${EUID:-$(id -u)}" -eq 0 ]; then
        "$@"
    else
        has sudo || die "sudo is required to install packages"
        sudo "$@"
    fi
}

package_manager() {
    if [ -n "${DOTFILES_PACKAGE_MANAGER:-}" ]; then
        case "$DOTFILES_PACKAGE_MANAGER" in
            apt|apt-get)
                has apt-get || die "DOTFILES_PACKAGE_MANAGER is set to apt, but apt-get was not found"
                printf '%s\n' apt-get
                ;;
            pacman)
                has pacman || die "DOTFILES_PACKAGE_MANAGER is set to pacman, but pacman was not found"
                printf '%s\n' pacman
                ;;
            yay)
                has yay || die "DOTFILES_PACKAGE_MANAGER is set to yay, but yay was not found"
                printf '%s\n' yay
                ;;
            *)
                die "Unsupported DOTFILES_PACKAGE_MANAGER: $DOTFILES_PACKAGE_MANAGER"
                ;;
        esac
        return 0
    fi

    if has yay && [ "${EUID:-$(id -u)}" -ne 0 ]; then
        printf '%s\n' yay
    elif has pacman; then
        printf '%s\n' pacman
    elif has apt-get; then
        printf '%s\n' apt-get
    else
        die "No supported package manager found. Install apt-get, pacman, or yay."
    fi
}

install_git() {
    if has git; then
        return 0
    fi

    case "$(package_manager)" in
        apt-get)
            run_as_root apt-get update
            run_as_root apt-get install -y git
            ;;
        pacman)
            run_as_root pacman -Sy --needed --noconfirm git
            ;;
        yay)
            [ "${EUID:-$(id -u)}" -ne 0 ] || die "yay must not be run as root"
            yay -S --needed --noconfirm git
            ;;
    esac
}

install_git

git clone https://github.com/sethraymond/dotfiles.git "$HOME/.dotfiles"

pushd "$HOME/.dotfiles"
./install.sh "$@"
popd
