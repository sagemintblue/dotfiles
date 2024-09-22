#!/bin/bash

# Rsync a large target path from this host to destination host.
#
# Usage: DEST_HOST=hostname bulk-rsync.sh /path/to/target
#
# Prefer bulk-xfer.sh for initial transfer of target path.

set -e
set -o pipefail

function log { echo "$(date): $@" >&2; }
function die { log "$@"; exit 1; }

TARGET="${1?Required param 'target' is undefined}"

SOURCE_ROOT=$(dirname "$TARGET")
DEST_HOST="sky"
[ "$(hostname)" = "Sky" ] && DEST_HOST="sea"
DEST_ROOT="${DEST_ROOT:-$SOURCE_ROOT}"
LOG="$SOURCE_ROOT/rsync-$DEST_HOST.log"

# strip source root prefix
TARGET="${TARGET#$SOURCE_ROOT/}"

cd "$SOURCE_ROOT"
[ -d "$TARGET" ] || die "Target path '$TARGET' not found in source root '$SOURCE_ROOT'"

DEST_PATH=$(dirname "$TARGET")
if [ "$DEST_PATH" = "." ]; then
    DEST_PATH=""
else
    DEST_PATH="$DEST_PATH/"
fi
DEST="$DEST_HOST:$DEST_ROOT/$DEST_PATH"

{
    log "Starting rsync of target '$TARGET' to '$DEST'"
    rsync \
        --archive \
        --compress \
        --progress \
        --verbose \
        --exclude '@eaDir' \
        "$TARGET" \
        "$DEST"
    log "Done"
} 2>>"$LOG" &

exec tail -f "$LOG"
