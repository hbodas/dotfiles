#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc


if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

# opam configuration
test -r /home/hrishikesh/.opam/opam-init/init.sh && . /home/hrishikesh/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
