#!/bin/bash

SESH="ags-session"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
	tmux new-session -d -s $SESH -n "editor"

	tmux send-keys -t $SESH:editor "cd ~/.dotfiles/configs/.config/ags" C-m
	tmux send-keys -t $SESH:editor "nvim ." C-m
	
	tmux new-window -t $SESH -n "ags-instance"
	tmux send-keys -t $SESH:ags-instance "kill $(ps aux | grep -e "ags run --gtk 4" -e "ags.js" | grep -v grep | awk '{print $2}')" C-m

	tmux send-keys -t $SESH:ags-instance "ags run --gtk 4" C-m

	tmux select-window -t $SESH:editor
fi

tmux attach-session -t $SESH
