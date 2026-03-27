#!/usr/bin/env bash
set -euo pipefail

VAULT="${1:-$HOME/Documents/Elastic Notes/Elastic Notes}"

export NVIM_APPNAME="nvim-notes"

cd "$VAULT"

if [ "$#" -gt 0 ]; then
  exec nvim "$@"
else
  exec nvim .
fi
