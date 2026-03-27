#!/usr/bin/env bash
# Prints a styled round split-pill for battery status.
# Silent on desktops (no battery found).

BAT_PATH=$(find /sys/class/power_supply -maxdepth 1 -name "BAT*" 2>/dev/null | head -1)
[ -z "$BAT_PATH" ] && exit 0

capacity=$(cat "$BAT_PATH/capacity" 2>/dev/null)
status=$(cat "$BAT_PATH/status" 2>/dev/null)
[ -z "$capacity" ] && exit 0

# Icon
if [ "$status" = "Charging" ]; then
    icon="󰂄"
elif [ "$capacity" -ge 90 ]; then icon="󰁹"
elif [ "$capacity" -ge 70 ]; then icon="󰂁"
elif [ "$capacity" -ge 50 ]; then icon="󰁿"
elif [ "$capacity" -ge 30 ]; then icon="󰁽"
elif [ "$capacity" -ge 15 ]; then icon="󰁺"
else icon="󰂃"
fi

# Accent color by level
if [ "$status" = "Charging" ]; then accent=2
elif [ "$capacity" -ge 40 ]; then accent=2
elif [ "$capacity" -ge 20 ]; then accent=3
else accent=1
fi

printf '#[fg=colour%s,bg=default]\ue0b6#[fg=colour0,bg=colour%s,bold]%s#[fg=colour%s,bg=colour0]\ue0b0#[fg=colour15,bg=colour0]%s%%#[fg=colour0,bg=default]\ue0b4#[default] '\
    "$accent" "$accent" "$icon" "$accent" "$capacity"
