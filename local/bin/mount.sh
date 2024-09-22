#!/bin/bash

# Script which wraps synoshare to avoid leaking shared folder password via command history.
#
# [1] https://www.netmeister.org/blog/passing-passwords.html
# [2] https://blog.gitguardian.com/secrets-at-the-command-line/
# [3] https://blog.diogomonica.com/2017/03/27/why-you-shouldnt-use-env-variables-for-secret-data/
# [4] https://unix.stackexchange.com/questions/232063/

# Fail on error or use of undefined variable
set -eu -o pipefail

# Do not export variables or functions
set +a
unset -v SHARE_NAME
unset -v SHARE_PASSWORD

# Get command line arguments
SHARE_NAME="${1?Required parameter 'SHARE_NAME' undefined}"

# Clear command line arguments
set --

# Read password from stdin
IFS= read -rs SHARE_PASSWORD

# Invoke synoshare with empty environment
sudo /usr/syno/sbin/synoshare --enc_mount "$SHARE_NAME" "$SHARE_PASSWORD"
