#!/bin/bash

# This script attempts to find (and optionally rename) files whose names are too long.
#
# Max safe length of file names is derived from a few sources:
#
# 1. Synology ecryptfs on btrfs limits file name length to ~144 bytes / ascii characters
# https://unix.stackexchange.com/questions/32795/what-is-the-maximum-allowed-filename-and-folder-size-with-ecryptfs
#
# 2. Rsync and other utils often create temp files with names slightly longer than input files.
#
# Consequently, we assume a max file name length of 130 characters. This will break if we run into
# long filenames containing extended UTF-8 code points.

set -e
set -o pipefail

function log { echo "$@" >&2; }
function die { log "$@"; exit 1; }

MAX_LENGTH="130"
RENAME_FILES="false"

while [ "${#@}" -gt 1 ]; do
    case "$1" in
        --max_length) MAX_LENGTH="${2?Required param 'max_length' is undefined}"; shift ;;
        --rename_files) RENAME_FILES="true" ;;
    esac
    shift
done

ROOT="${1?Required arg 'root' is undefined}"

# Synology includes find 4.4.2 which doesn't support modern regular expressions w/ repetition
# operators so we construct the pattern explicitly.
PATTERN=".*/"
for ((n=0; n < MAX_LENGTH; n++)); do
    PATTERN="${PATTERN}[^/]"
done
PATTERN="${PATTERN}[^/][^/]*"

find "$ROOT" -type f -regex "$PATTERN" | while read file; do
    path=$(dirname "$file")
    base=$(basename "$file")

    # ensure base length > MAX_LENGTH
    [ "${#base}" -gt "$MAX_LENGTH" ] \
        || die "Find gave us a file whose base name is within max length limit: $file"

    prefix="${base%.*}"
    ext="${base##*.}"

    ext_length="${#ext}"
    max_prefix_length=$((MAX_LENGTH - ext_length - 1))
    [ "$max_prefix_length" -lt 1 ] && die "Max prefix length is < 1: $file"

    prefix_truncated=$(echo "$prefix" | cut "-c1-$max_prefix_length")

    # attempt to trim last (truncated) word from prefix
    prefix_trimmed="${prefix_truncated% *}"
    [ "$prefix_truncated" = "$prefix_trimmed" ] || prefix_truncated="$prefix_trimmed"

    # remove trailing whitespace
    prefix_truncated=$(echo $prefix_truncated)

    file_truncated="$path/$prefix_truncated.$ext"
    log "1: $file"
    log "2: $file_truncated"
    [ "$RENAME_FILES" = "true" ] && mv "$file" "$file_truncated"
done
