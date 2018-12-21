#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# get all the aliases
source ~/.bash_aliases
source ~/.bash_aliases_tmp

# path variable
export PATH=$PATH":$HOME/bin:$HOME/.local/bin"

# other variables 
export EDITOR=vim
export BROWSER=firefox
export TERMINAL=urxvt
export READER=zathura

# prompt
PS1='\[\033[01;92m\]\u@\h\[\033[00m\]:\[\033[01;94m\]\w\[\033[00m\]$ '

# pywal settings 
(cat ~/.cache/wal/sequences &)

# export pywal colors
~/.cache/wal/colors.sh

# tmux
tmux
