#!/usr/bin/env bash

set -euo pipefail

log() {
    printf '\n==> %s\n' "$*"
}

die() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 1
}

has() {
    command -v "$1" >/dev/null 2>&1
}

require_sudo() {
    if [ "${EUID:-$(id -u)}" -ne 0 ]; then
        has sudo || die "sudo is required to install packages"
    fi
}

run_as_root() {
    if [ "${EUID:-$(id -u)}" -eq 0 ]; then
        "$@"
    else
        require_sudo
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

install_packages() {
    local manager
    manager="$(package_manager)"

    case "$manager" in
        apt-get)
            if [ "${EUID:-$(id -u)}" -eq 0 ]; then
                apt-get install -y "$@"
            else
                require_sudo
                sudo apt-get install -y "$@"
            fi
            ;;
        pacman)
            if [ "${EUID:-$(id -u)}" -eq 0 ]; then
                pacman -S --needed --noconfirm "$@"
            else
                require_sudo
                sudo pacman -S --needed --noconfirm "$@"
            fi
            ;;
        yay)
            [ "${EUID:-$(id -u)}" -ne 0 ] || die "yay must not be run as root"
            yay -S --needed --noconfirm "$@"
            ;;
    esac
}

install_package_for_manager() {
    local apt_package="$1"
    local arch_package="${2:-$apt_package}"

    case "$(package_manager)" in
        apt-get)
            install_packages "$apt_package"
            ;;
        pacman|yay)
            install_packages "$arch_package"
            ;;
    esac
}

refresh_package_index() {
    case "$(package_manager)" in
        apt-get)
            log "Refreshing apt package index"
            run_as_root apt-get update
            ;;
        pacman|yay)
            ;;
    esac
}

ensure_command() {
    local command_name="$1"
    local package_name="${2:-$command_name}"

    if has "$command_name"; then
        return 0
    fi

    log "Installing $package_name"
    install_packages "$package_name"
}

remove_local_bin_shadow() {
    local command_name="$1"
    local target="$HOME/.local/bin/$command_name"

    if [ -L "$target" ] || [ -f "$target" ]; then
        log "Removing $target so package-managed $command_name is used"
        rm -f "$target"
        hash -r 2>/dev/null || true
    elif [ -e "$target" ]; then
        die "$target exists but is not a file or symlink"
    fi
}

ensure_local_bin() {
    mkdir -p "$HOME/.local/bin"

    case ":$PATH:" in
        *":$HOME/.local/bin:"*)
            ;;
        *)
            PATH="$HOME/.local/bin:$PATH"
            export PATH
            ;;
    esac
}

architecture() {
    case "$(uname -m)" in
        x86_64)
            printf '%s\n' x86_64
            ;;
        aarch64|arm64)
            printf '%s\n' arm64
            ;;
        *)
            die "Unsupported architecture: $(uname -m)"
            ;;
    esac
}

go_architecture() {
    case "$(architecture)" in
        x86_64)
            printf '%s\n' amd64
            ;;
        arm64)
            printf '%s\n' arm64
            ;;
    esac
}

ensure_go_path() {
    if [ -d /usr/local/go/bin ]; then
        case ":$PATH:" in
            *:/usr/local/go/bin:*)
                ;;
            *)
                PATH="/usr/local/go/bin:$PATH"
                export PATH
                ;;
        esac
    fi

    if has go; then
        local go_path
        go_path="$(go env GOPATH 2>/dev/null || true)"

        if [ -n "$go_path" ]; then
            case ":$PATH:" in
                *":$go_path/bin:"*)
                    ;;
                *)
                    PATH="$PATH:$go_path/bin"
                    export PATH
                    ;;
            esac
        fi
    fi
}

ensure_go_from_package() {
    install_package_for_manager golang-go go

    if [ -d /usr/local/go ]; then
        log "Removing /usr/local/go so package-managed Go is used"
        run_as_root rm -rf /usr/local/go
        hash -r 2>/dev/null || true
    fi

    has go || die "Go was installed, but go was not found"
    ensure_go_path
    log "Go $(go env GOVERSION) installed"
}

ensure_go_from_github() {
    local version="${DOTFILES_GO_VERSION:-1.26.6}"

    ensure_go_path

    if has go && go version | grep -q "go${version} "; then
        log "Go $version already exists"
        return 0
    fi

    ensure_command curl
    ensure_command tar

    local tmp
    tmp="$(mktemp -d)"

    log "Installing Go $version"

    curl -fL \
        "https://go.dev/dl/go${version}.linux-$(go_architecture).tar.gz" \
        -o "$tmp/go.tar.gz"

    run_as_root rm -rf /usr/local/go
    run_as_root tar -C /usr/local -xzf "$tmp/go.tar.gz"

    ensure_go_path

    has go || die "Go installation failed"
    log "Go $(go env GOVERSION) installed"

    rm -rf "$tmp"
}

ensure_go() {
    case "${DOTFILES_GO_SOURCE:-package}" in
        package)
            ensure_go_from_package
            ;;
        github)
            ensure_go_from_github
            ;;
        *)
            die "Unsupported DOTFILES_GO_SOURCE: $DOTFILES_GO_SOURCE"
            ;;
    esac
}
