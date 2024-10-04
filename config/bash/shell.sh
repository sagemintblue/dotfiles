#!/usr/bin/env bash

export LANG="en_US.UTF-8"
export LC_ALL="$LANG"

export EDITOR="emacs -nw"
[ "${TERM_PROGRAM}" = "vscode" ] && EDITOR="code -w"
export VISUAL="$EDITOR"
export PAGER="less"

has scutil && HOSTNAME="$(scutil --get ComputerName)"
[ -z "$HOSTNAME" -a -n "$HOST" ] && HOSTNAME="${HOST%%.*}"
export HOSTNAME

alias path='echo "$PATH" | sed -e "s/:/\n/g"'
