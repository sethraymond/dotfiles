RUNTIME_DIR="${XDG_RUNTIME_DIR:?XDG_RUNTIME_DIR not set}"

socket=$(find "$RUNTIME_DIR" -maxdepth 1 -type s -name 'wayland-*' | sed 's#.*/##' | sort | head -n1)

if [ -n "$socket" ]; then
    tmux set-environment -g WAYLAND_DISPLAY "$socket"
else
    tmux set-environment -gu WAYLAND_DISPLAY 2>/dev/null
fi
