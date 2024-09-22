#!/bin/bash

# Script for batch image size reduction with ImageMagick, adapted from [1].
#
# [1] https://www.smashingmagazine.com/2015/06/efficient-image-resizing-with-imagemagick/

set -euo pipefail

OUTPUT_PATH="${1?Required param OUTPUT_PATH undefined}"; shift
OUTPUT_PIXEL_WIDTH="${1?Required param OUTPUT_PIXEL_WIDTH undefined}"; shift

function log { echo "$@" >&2; }
function die { log "$@"; exit 1; }

[ ! -d "$OUTPUT_PATH" ] && mkdir -p "$OUTPUT_PATH"

exec \
    mogrify \
    -path "$OUTPUT_PATH" \
    -filter Triangle \
    -define filter:support=2 \
    -thumbnail "$OUTPUT_PIXEL_WIDTH" \
    -auto-orient \
    -unsharp 0.25x0.08+8.3+0.045 \
    -dither None \
    -posterize 136 \
    -quality 82 \
    -define jpeg:fancy-upsampling=off \
    -define png:compression-filter=5 \
    -define png:compression-level=9 \
    -define png:compression-strategy=1 \
    -define png:exclude-chunk=all \
    -interlace none \
    -colorspace sRGB \
    "$@"
