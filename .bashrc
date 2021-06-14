#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# get all the aliases
source ~/.bash_aliases
source ~/.bash_aliases_tmp
# source ~/.bash_profile

# path variable
export PATH=$PATH":$HOME/bin:$HOME/.local/bin:$HOME/spicetify-cli"

# other variables 
export EDITOR=vim
export BROWSER=firefox
export TERM=screen-256color-it
export READER=zathura

# GOPATH - probably change this later?
# export GOPATH="/home/hrishikesh/documents/Courses/15-440 (F20)/p3"

# prompt
export PROMPT_DIRTRIM=2
PS1='\[\033[01;33m\]\w\[\033[00m\] \[\033[01;34m\]>\033[00m\] '

# colors fix for tmux
# [ -n "$TMUX" ] && export TERM=screen-256color

# pywal settings 
(cat ~/.cache/wal/sequences &)

# export pywal colors
# ~/.cache/wal/colors.sh
