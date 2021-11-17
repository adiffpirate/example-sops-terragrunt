#!/bin/bash

timestamp=$(date '+%Y%m%d-%H%M%S')

if [ -f "$HOME/.config/sops/age/keys.txt" ]; then
	export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"
else
	export SOPS_AGE_KEY_FILE="/tmp/sops-key-$timestamp"
	kubectl -n encrypt get secret enc-key -o jsonpath='{.data.key}' | base64 -d > $SOPS_AGE_KEY_FILE
fi

$(echo $0 | sed 's/\/decrypt_tfvars.sh//')/hcl2json <(sops -d $1)
