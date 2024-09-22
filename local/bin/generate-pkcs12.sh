#!/bin/bash

# Generates PKCS#12 file, an archive containing SSL private key and certificate, for use with Plex
# Media Server.
#
# [1] https://www.ssl.com/how-to/create-a-pfx-p12-certificate-file-using-openssl/
# [2] https://forums.plex.tv/discussion/200002/

HOSTNAME="${1?:Required arg 'HOSTNAME' undefined}"

exec \
    openssl \
    pkcs12 \
    -export \
    -in "$HOSTNAME.crt" \
    -inkey "$HOSTNAME.key" \
    -out "$HOSTNAME.pfx" \
    -name "$HOSTNAME Certificate Archive"
