#!/usr/bin/env bash
set -euo pipefail

# Measure Neovim startup time for this configuration.
tmpfile="$(mktemp)"
nvim --headless -u init.lua --startuptime "$tmpfile" '+qa'
echo "Startup profile written to: $tmpfile"
tail -n 5 "$tmpfile"