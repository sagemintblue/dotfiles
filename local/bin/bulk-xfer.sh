#!/bin/bash

# Transfer a large target path from this host to destination host.
#
# Usage: DEST_HOST=hostname bulk-xfer.sh /path/to/target
#
# Prefer bulk-rsync.sh for periodic updates of copy on destination host.

set -e
set -o pipefail

function log { echo "$(date): $@" >&2; }
function die { log "$@"; exit 1; }

TARGET="${1?Required param 'target' is undefined}"

SOURCE_ROOT=$(cd $(dirname "$TARGET"); pwd)
TARGET_BASE=$(basename "$TARGET")
TARGET="$SOURCE_ROOT/$TARGET_BASE"

[ -d "$TARGET" ] || die "Target path '$TARGET' not found"

DEST_HOST="sky"
[ "$(hostname)" = "Sky" ] && DEST_HOST="sea"
DEST_ROOT="${DEST_ROOT:-$SOURCE_ROOT}"
LOG="$SOURCE_ROOT/xfer-$DEST_HOST.log"

{
    log "Starting xfer of target '$TARGET'"
    # checkpoint every 10240 records (100 MiB)
    # default: 512 blocks / record; 20 bytes / block
    cd "$SOURCE_ROOT"
    tar -cvzf - \
        --checkpoint=10240 \
        --checkpoint-action=totals \
        --exclude '@eaDir' \
        "$TARGET_BASE" \
        | ssh "$DEST_HOST" "cd $DEST_ROOT; tar -xzpf -"
    log "Done"
} 2>>"$LOG" &

exec tail -f "$LOG"
