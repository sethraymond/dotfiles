#!/usr/bin/env bash
set -euo pipefail

# Simple Waybar <-> mako helper:
#   --count        => prints number of active notifications (for waybar)
#   --menu         => interactive menu to dismiss single/all notifications
#   --toggle-dnd   => toggle between mako 'default' and 'dnd' modes
#
# Requires: makoctl, jq. (fuzzel preferred for menu, rofi fallback.)

case "${1:-}" in
  --count)
    notifications_json=$(makoctl history 2>/dev/null || echo '{"data": []}')
    count=$(jq '[.data[] | select(.dismissed == false)] | length' <<<"$notifications_json" 2>/dev/null || echo 0)
    echo "$count"
    ;;

  --menu)
    notifications_json=$(makoctl history 2>/dev/null || echo '{"data": []}')
    undismissed=$(jq -r '.data[] | select(.dismissed == false) | "\(.id)|||\(.summary) — \(.body | gsub("\n"; " "))"' <<<"$notifications_json")

    if [ -z "$undismissed" ]; then
      notify-send "Mako" "No notifications"
      exit 0
    fi

    chosen=$(printf "%s\nDismiss All" "$undismissed" | fuzzel --dmenu --prompt="Notifications: " )

    # If user cancelled
    [ -z "${chosen:-}" ] && exit 0

    if [ "$chosen" = "Dismiss All" ]; then
      makoctl dismiss -a || true
      exit 0
    fi

    # Extract ID (before the '|||') and dismiss that notification
    id="${chosen%%|||*}"
    id="${id#"${id%%[![:space:]]*}"}"  # trim leading
    id="${id%"${id##*[![:space:]]}"}"  # trim trailing

    makoctl dismiss "$id" || true
    ;;

  --toggle-dnd)
    # Toggle using mako modes (expects modes 'default' and 'dnd' exist in mako config)
    current=$(makoctl mode 2>/dev/null || echo default)
    if [ "$current" = "dnd" ]; then
      makoctl mode default || true
      notify-send "Do Not Disturb" "Disabled"
    else
      makoctl mode dnd || true
      notify-send "Do Not Disturb" "Enabled"
    fi
    ;;

  *)
    cat <<'USAGE'
Usage: mako-menu.sh [--count|--menu|--toggle-dnd]
--count      Print number of active notifications (for Waybar)
--menu       Show interactive menu for dismissing notifications
--toggle-dnd Toggle between 'default' and 'dnd' mako modes (uses makoctl mode)
USAGE
    exit 1
    ;;
esac

