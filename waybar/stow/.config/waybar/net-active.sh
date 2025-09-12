#!/usr/bin/env bash

# Icons
ETH_ICON="󰈀"
WIFI_ICON=""
VPN_ICON=""
DOWN_ICON=""

# Collect interfaces from nmcli, filter unwanted
INTERFACES=($(nmcli -t -f DEVICE,TYPE device status \
    | grep -Ev ':(bridge|loopback|wifi-p2p)$' \
    | grep -Ev '^veth' \
    | cut -d: -f1))

# Find default route interface
default_iface=$(ip route | awk '/^default/ {print $5; exit}')

# Build tooltip + default display
tooltip=""
default_text=""

for iface in "${INTERFACES[@]}"; do
    type=$(nmcli -t -f DEVICE,TYPE device status | grep "^${iface}:" | cut -d: -f2)
    ip=$(ip -4 addr show dev "$iface" 2>/dev/null | awk '/inet / {print $2}')

    if [ "$type" = "ethernet" ]; then
        if [ -n "$ip" ]; then
            line="$ETH_ICON $iface: $ip"
        else
            line="$DOWN_ICON $iface: (down)"
        fi

    elif [ "$type" = "wifi" ]; then
        ssid=$(nmcli -t -f DEVICE,SSID device wifi list | grep "^${iface}:" | cut -d: -f2 | head -n1)
        strength=$(nmcli -t -f DEVICE,SIGNAL device wifi list | grep "^${iface}:" | cut -d: -f2 | head -n1)

        if [ -n "$ip" ]; then
            line="$WIFI_ICON $iface: $ip"
            if [ -n "$ssid" ]; then
                line+=" ($ssid ${strength}%)"
            fi
        else
            line="$DOWN_ICON $iface: (down)"
        fi

    elif [ "$type" = "tun" ]; then
        if [ -n "$ip" ]; then
            line="$VPN_ICON $iface: $ip"
        else
            line="$DOWN_ICON $iface: (down)"
        fi

    else
        if [ -n "$ip" ]; then
            line="$iface: $ip"
        else
            line="$DOWN_ICON $iface: (down)"
        fi
    fi

    tooltip+="$line\n"

    if [ "$iface" = "$default_iface" ]; then
        default_text="$line"
    fi
done

# Output JSON
if [ -n "$default_text" ]; then
    echo "{\"text\": \"$default_text\", \"tooltip\": \"${tooltip%\\n}\"}"
else
    echo "{\"text\": \"$DOWN_ICON no net\", \"tooltip\": \"${tooltip%\\n}\"}"
fi
