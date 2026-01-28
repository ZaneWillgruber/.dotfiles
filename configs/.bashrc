#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias Settings='cd ~/.dotfiles/configs/.config && nvim .'
PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"
# (cat ~/.cache/wal/sequences &)
export PATH=$PATH:$HOME/go/bin

# Created by `pipx` on 2026-01-26 16:22:39
export PATH="$PATH:/home/zane/.local/bin"
