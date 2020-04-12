#!/bin/sh

[ -f "$HOME/.xprofile" ] && . ~/.xprofile
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -f ~/.Xresources ] && xrdb ~/.Xresources

exec bspwm
