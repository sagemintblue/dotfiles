#!/usr/bin/env bash

# Only evaluate for interactive shells
shell_interactive || return

export LANG="en_US.UTF-8"
export LC_ALL="$LANG"

export EDITOR="emacs -nw"
if [ "${TERM_PROGRAM}" = "vscode" ]; then
  EDITOR="code -w"
fi
export VISUAL="$EDITOR"
export PAGER="less"

if has scutil; then
  HOSTNAME="$(scutil --get ComputerName)"
fi
[ -z "$HOSTNAME" ] && HOSTNAME="${HOST%%.*}"
export HOSTNAME
