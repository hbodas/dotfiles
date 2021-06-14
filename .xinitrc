#!/bin/sh

wal -R

#start i3
exec i3

# starting the gnome keyring daemon
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
