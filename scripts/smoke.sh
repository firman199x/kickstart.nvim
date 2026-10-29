#!/usr/bin/env bash
set -euo pipefail

# Basic startup smoke test for the kickstart configuration.
nvim --headless -u init.lua '+qa'
echo "Startup smoke test passed."