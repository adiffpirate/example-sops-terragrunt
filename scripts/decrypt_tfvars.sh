#!/bin/bash

timestamp=$(date '+%Y%m%d-%H%M%S')

export SOPS_AGE_KEY_FILE="/tmp/sops-key-$timestamp"
kubectl -n encrypt get secret enc-key -o jsonpath='{.data.key}' | base64 -d > $SOPS_AGE_KEY_FILE

sops -d $1 > /tmp/decrypted_tfvars_$timestamp
echo "/tmp/decrypted_tfvars_$timestamp"
