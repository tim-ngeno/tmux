#!/usr/bin/env bash
# Regenerates ~/.cache/tmux_session_colors
# Uses pywal kitty colors when available, falls back to hardcoded palette

WAL_CACHE=~/.cache/wal/colors-kitty
MAPFILE=~/.cache/tmux_session_colors

# Load pywal colors into array (color0..color15)
if [ -f "$WAL_CACHE" ]; then
    source "$WAL_CACHE"
    # kitty exposes color0..color15 as hex; build an index array of the
    # vivid accent colors (1-6, 9-14 — skip 0/7/8/15 which are bg/fg/grey)
    palette=()
    for i in 1 2 3 4 5 6 9 10 11 12 13 14; do
        palette+=("$i")
    done
else
    palette=(1 2 3 4 5 6 9 10 11 12 13 14)
fi

mapfile -t sessions < <(tmux list-sessions -F '#S' 2>/dev/null)

mkdir -p ~/.cache
: > "$MAPFILE"

for session in "${sessions[@]}"; do
    hash=$(echo -n "$session" | md5sum | cut -c1-2)
    index=$((0x$hash % ${#palette[@]}))
    echo "$session ${palette[$index]}" >> "$MAPFILE"
done

