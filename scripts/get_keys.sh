#!/bin/bash

keys_filepath="$HOME/.config/sops/age/keys.txt"

if [ -f "$keys_filepath" ]; then
	mv "$keys_filepath" "$keys_filepath.backup"
fi

public_key="$(kubectl -n encrypt get secret enc-keys -o jsonpath='{.data.public-key}' | base64 -d)"
echo "# public key: $public_key" > $keys_filepath
private_key="$(kubectl -n encrypt get secret enc-keys -o jsonpath='{.data.private-key}' | base64 -d)"
echo "$private_key" >> $keys_filepath

export SOPS_AGE_RECIPIENTS="$public_key"
export SOPS_AGE_KEY_FILE="$keys_filepath"
