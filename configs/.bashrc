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
