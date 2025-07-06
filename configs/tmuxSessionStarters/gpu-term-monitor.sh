#!/bin/bash

SESH="nvidia-term"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
	tmux new-session -d -s $SESH -n "editor"

	tmux send-keys -t $SESH:editor "cd ~/nvidia-gpu-term-monitor/" C-m
	tmux send-keys -t $SESH:editor "nvim ." C-m
	
	tmux new-window -t $SESH -n "app"
	tmux send-keys -t $SESH:app "cd ~/nvidia-gpu-term-monitor/" C-m

	tmux send-keys -t $SESH:app "go run ." C-m

	tmux select-window -t $SESH:editor
fi

tmux attach-session -t $SESH
