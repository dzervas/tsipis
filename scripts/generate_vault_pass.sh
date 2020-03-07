#!/bin/sh
if [ -z "$1" ]; then
	echo "Usage: $0 <gpg-id>"
	exit 1
fi
gpg --gen-random --armor 1 50 | gpg --encrypt --armor --recipient "$1" > ~/.tsipis/vault_pass.gpg
