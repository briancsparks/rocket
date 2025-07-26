#!/bin/bash
# Enhanced status bar script for dwm
# Save this as ~/.config/dwm/statusbar.sh and make it executable

# Function to get battery status
get_battery() {
    if [ -f /sys/class/power_supply/BAT0/capacity ]; then
        echo "BAT: $(cat /sys/class/power_supply/BAT0/capacity)%"
    fi
}

# Function to get volume
get_volume() {
    # For PulseAudio
    if command -v pactl &> /dev/null; then
        vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+%' | head -1)
        echo "VOL: $vol"
    fi
}

# Function to get network status
get_network() {
    # Check for wireless
    if command -v iwconfig &> /dev/null; then
        wifi=$(iwconfig 2>/dev/null | grep -o 'ESSID:"[^"]*"' | sed 's/ESSID:"\(.*\)"/\1/')
        if [ -n "$wifi" ]; then
            echo "WIFI: $wifi"
            return
        fi
    fi
    
    # Check for ethernet
    if ip link | grep -q 'state UP'; then
        echo "ETH: Connected"
    else
        echo "NET: Down"
    fi
}

# Function to get memory usage
get_memory() {
    mem=$(free -h | awk '/^Mem/ {print $3 "/" $2}')
    echo "MEM: $mem"
}

# Main loop
while true; do
    # Build status string
    status=""
    
    # Add components with separators
    [ -n "$(get_network)" ] && status="$(get_network) | "
    [ -n "$(get_volume)" ] && status="${status}$(get_volume) | "
    [ -n "$(get_battery)" ] && status="${status}$(get_battery) | "
    status="${status}$(get_memory) | "
    status="${status}$(date '+%a %Y-%m-%d %H:%M:%S')"
    
    # Set root window name (dwm status bar)
    xsetroot -name "$status"
    
    # Update every 2 seconds
    sleep 2
done