#!/usr/bin/env bash
# Prints a styled round split-pill for the current git branch.
# Prints nothing if not in a git repo.
# Usage: git_branch.sh <path>

DIR="${1:-$PWD}"

branch=$(git -C "$DIR" symbolic-ref --short HEAD 2>/dev/null)
[ -z "$branch" ] && exit 0

[ ${#branch} -gt 24 ] && branch="${branch:0:22}…"

# colour5 = pywal magenta/purple
printf '#[fg=colour5,bg=default]\ue0b6#[fg=colour0,bg=colour5,bold]󰘬 #[fg=colour5,bg=colour0]\ue0b0#[fg=colour15,bg=colour0] %s #[fg=colour0,bg=default]\ue0b4#[default] ' \
    "$branch"
