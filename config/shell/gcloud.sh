#!/usr/bin/env bash

GOOGLE_CLOUD_SDK_DIR="$HOME/workspace/google-cloud-sdk"

# Add Google Cloud SDK to PATH
sourceif "$GOOGLE_CLOUD_SDK_DIR/path.bash.inc"

# Enable shell command completion for gcloud
sourceif "$GOOGLE_CLOUD_SDK_DIR/completion.bash.inc"
