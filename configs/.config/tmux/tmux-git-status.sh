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

	echo "#[fg=#ebcb8b,bg=#2e3440]#[fg=#2e3440,bg=#ebcb8b]$branch_display #[fg=#88c0d0,bg=#ebcb8b]#[fg=#2e3440,bg=#88c0d0]$repo_name "
fi
