#!/bin/bash

keys_filepath="$HOME/.config/sops/age/keys.txt"

if [ -f "$keys_filepath" ]; then
	cp "$keys_filepath" "$keys_filepath.backup"
fi

private_key="$(kubectl -n encrypt get secret enc-key -o jsonpath='{.data.key}' | base64 -d)"
echo "$private_key" >> $keys_filepath
echo "Key successfully appended to file: $keys_filepath"
