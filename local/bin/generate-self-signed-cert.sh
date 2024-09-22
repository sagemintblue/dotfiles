#!/bin/bash

# Generates self-signed certificate with appropriate Subject Alternate Name (SAN) for compatibility
# with Google Chrome browser.
#
# [1] https://serverfault.com/questions/845766/
# [2] https://serverfault.com/questions/880804/

IP4_ADDRESS="${1?:Required arg 'IP4_ADDRESS' undefined}"; shift
PRIMARY_HOSTNAME="${1?:Required arg 'PRIMARY_HOSTNAME' undefined}"; shift

ALTERNATE_HOSTNAMES="DNS:$PRIMARY_HOSTNAME"
for ALTERNATE_HOSTNAME in $@; do
    ALTERNATE_HOSTNAMES="$ALTERNATE_HOSTNAMES,DNS:$ALTERNATE_HOSTNAME"
done

exec \
    openssl \
    req \
    -x509 \
    -newkey rsa:4096 \
    -sha256 \
    -days 3650 \
    -nodes \
    -keyout "$PRIMARY_HOSTNAME.key" \
    -new \
    -out "$PRIMARY_HOSTNAME.crt" \
    -subj "/CN=$PRIMARY_HOSTNAME" \
    -reqexts SAN \
    -extensions SAN \
    -config <(cat "/System/Library/OpenSSL/openssl.cnf"; \
              printf "[SAN]\nsubjectAltName=$ALTERNATE_HOSTNAMES,IP:$IP4_ADDRESS")
