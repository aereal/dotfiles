#!/bin/bash

set -e

config_file="$HOME/.secret.gitconfig"

name=

while getopts 'n:' opt; do
  case "$opt" in
    n) name="$OPTARG" ;;
    *)
      echo "Usage: $0 -n <signing key name>" >&2
      exit 1
      ;;
  esac
done

if [[ "$name" = "" ]]; then
  echo '! signing key name is required' >&2
  exit 1
fi

if ! which op >/dev/null; then
  echo '! 1Password CLI is not installed' >&2
  echo '! So the signing key is not configured' >&2
fi

public_key="$(op item get --fields 'public key' "$name")"

ssh_program=

case "$(uname)" in
  Linux)
    ;;
  Darwin)
    ssh_program=/Applications/1Password.app/Contents/MacOS/op-ssh-sign
    ;;
esac

if [[ ! -x "$ssh_program" ]]; then
  echo '! 1Password cannot be located' >&2
fi

git config set --file "$config_file" gpg.format ssh
git config set --file "$config_file" --type bool commit.gpgsign true
git config set --file "$config_file" gpg.ssh.program "$ssh_program"
git config set --file "$config_file" user.signingkey "$public_key"
