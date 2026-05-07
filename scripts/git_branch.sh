#!/usr/bin/env bash
# Prints a styled round split-pill for the current git branch.
# Prints nothing if not in a git repo.
# Usage: git_branch.sh <path>

DIR="${1:-$PWD}"

branch=$(git -C "$DIR" symbolic-ref --short HEAD 2>/dev/null)
[ -z "$branch" ] && exit 0

[ ${#branch} -gt 24 ] && branch="${branch:0:22}…"

# colour5 = pywal magenta/purple
printf '#[fg=colour5,bg=default]#[fg=colour0,bg=colour5,bold]󰘬 %s#[fg=colour5,bg=default]#[default] ' \
    "$branch"

