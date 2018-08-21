#
# ~/.bashrc
#

shopt -s autocd

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# get all the functions
source ~/.bash_functions

# get all the aliases
source ~/.bash_aliases

# path variable
export PATH=$PATH":$HOME/bin:$HOME/.local/bin"

# other variables 
export EDITOR=vim
export BROWSER=firefox
export TERMINAL=urxvt
export READER=zathura

