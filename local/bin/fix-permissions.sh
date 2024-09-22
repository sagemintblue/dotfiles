#!/bin/bash

# Fixes ownership and permissions of all files and directories within target directories.

set -e

function log { echo "$@" >&2; }
function die { log "$@"; exit 1; }

ARGS=()
while [[ "$#" -gt 0 ]]; do
	OPT="$1"; shift
	case "$OPT" in
		-o|--owner) OWNER="1" ;;
		--) ARGS+="$@"; break ;;
		*) ARGS+=("$OPT") ;;
	esac
done
set -- "${ARGS[@]}"

TARGET="${1?-Required param 'target' is undefined}"

[[ -n "$OWNER" ]] && sudo chown -R "$(whoami):users" "$@"
find "$@" -type d -exec chmod 0755 '{}' '+'
find "$@" -type f -exec chmod 644 '{}' '+'
