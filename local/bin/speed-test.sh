#!/bin/bash

HOST="${1?:Required param 'host' undefined}"
BLOCK_SIZE="${2:-1048576}"
COUNT="${3:-10}"

DD_CMD="dd if=/dev/urandom bs=$BLOCK_SIZE count=$COUNT"

echo "Upload to $HOST"
$DD_CMD | ssh "$HOST" 'cat >/dev/null'

echo "Download from $HOST"
ssh "$HOST" "$DD_CMD" | cat >/dev/null

