#!/usr/bin/env bash
# Prints a styled round split-pill for the session name.
# Usage: session_pill.sh <session_name>
#
# Shape:  [accent]  icon  [dim]  name  [reset]

SESSION="${1:-main}"
MAP="$HOME/.cache/tmux_session_colors"

COLOR=$(grep "^${SESSION} " "$MAP" 2>/dev/null | awk '{print $2}')
COLOR=${COLOR:-4}

# \ue0b6 = left round cap, \ue0b4 = right round cap
printf '#[fg=colour%s,bg=default]#[fg=colour0,bg=colour%s,bold]󰌆  %s#[fg=colour%s,bg=default]#[default] ' \
    "$COLOR" "$COLOR" "$SESSION" "$COLOR"
