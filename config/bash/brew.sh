#!/usr/bin/env bash

# Mostly generated via `brew shellenv`

export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"

path_prepend "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"

[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"

export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

shell_interactive || return

for f in "$HOMEBREW_PREFIX/etc/bash_completion.d/"*; do
    sourceif "$f"
done
