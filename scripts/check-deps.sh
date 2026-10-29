#!/usr/bin/env bash
set -euo pipefail

required=(git nvim rg fd)
optional=(clangd lua-language-server stylua)

echo "Required dependencies:"
for exe in "${required[@]}"; do
	if command -v "$exe" >/dev/null 2>&1; then
		echo "  [ok] $exe ($(command -v "$exe"))"
	else
		echo "  [missing] $exe"
	fi
done

echo
echo "Optional language tools:"
for exe in "${optional[@]}"; do
	if command -v "$exe" >/dev/null 2>&1; then
		echo "  [ok] $exe ($(command -v "$exe"))"
	else
		echo "  [missing] $exe"
	fi
done