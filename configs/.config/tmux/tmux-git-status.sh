#!/bin/bash

pane_path=$(tmux display-message -p -F "#{pane_current_path}")

if git -C "$pane_path" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
	repo_root=$(git -C "$pane_path" rev-parse --show-toplevel)
	repo_name=$(basename "$repo_root")

	branch=$(git -C "$pane_path" rev-parse --abbrev-ref HEAD)

	if git -C "$pane_path" status --porcelain | grep -qE '^[ M]'; then
		branch_display="$branch*"
	else
		branch_display="$branch"
	fi

	echo "#[fg=yellow, bg=black]#[fg=black, bg=yellow]$branch_display #[fg=red, bg=yellow]#[fg=black, bg=red]$repo_name  "
fi
