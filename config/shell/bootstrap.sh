#!/usr/bin/env bash

# Define common paths
# See https://specifications.freedesktop.org/basedir-spec/latest/

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$HOME/.local/run}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Define common functions

function log { echo "$@" 2>&1; }

function die { log "$@"; exit 1; }

function sourceif { [ -r "$1" ] && source "$1"; }

function has { type "$1" &>/dev/null; }

function string_contains { [[ "$1" == *"$2"* ]]; }

function path_contains { string_contains ":$PATH:" ":$1:"; }

function path_update {
    local op="$1"; shift
    local ds=""
    for d in "$@"; do
        if [ -d "$d" ] && ! path_contains "$d"; then
            ds="$ds:$d"
        fi
    done
    ds="${ds#:}"
    [ -n "$ds" ] && export PATH=$($op "$PATH" "$ds")
}

function path_append {
    function append { echo "$1:$2"; }
    path_update append "$@"
}

function path_prepend {
    function prepend { echo "$2:$1"; }
    path_update prepend "$@"
}

function shell_interactive { string_contains "$-" "i"; }

# Source configuration scripts

CONF_SCRIPT_DIR="$XDG_CONFIG_HOME/shell"
sourceif "$CONF_SCRIPT_DIR/vscode.sh"
sourceif "$CONF_SCRIPT_DIR/gcloud.sh"
sourceif "$CONF_SCRIPT_DIR/brew.sh"
sourceif "$CONF_SCRIPT_DIR/shell.sh"
sourceif "$CONF_SCRIPT_DIR/prompt.sh"

# Ensure ~/.local/bin is first in PATH

path_prepend "$HOME/.local/bin"
