# kickstart.nvim (personal fork)

A modular Neovim configuration built on `vim.pack`, LSP, blink.cmp, mini.nvim, and fff.nvim.

## Requirements

- Neovim 0.12+ (this config uses `vim.pack` and `vim.lsp.config`)
- Git
- A Nerd Font (optional, but recommended)
- `ripgrep` and `fd` for fast search
- Language servers via Mason (`clangd`, `lua_ls`, `stylua`, ...)

## Install

```sh
git clone <this-repo> ~/.config/kickstart
NVIM_APPNAME=kickstart nvim
```

On first launch, `vim.pack` installs plugins and Mason installs servers.

### Windows (cmd/PowerShell)
- Install Neovim 0.12+, Git, `ripgrep`, `fd` (e.g. via `winget` or Scoop).
- Clone to `%LOCALAPPDATA%\\nvim` (or launch with `nvim -u C:\\path\\to\\kickstart\\init.lua`).
- For clipboard sync, install `win32yank` (otherwise the config falls back to `unnamed`).
- Run `scripts\\check-deps.ps1` (or the `.sh` via Git Bash) before first launch.
- Ensure `wcompile` (if used) is a Windows executable on `PATH`.
- Set `KICKSTART_VENDOR_DIR` to your vendor root if it is not under `%USERPROFILE%\\Dev`.

## Structure

```
init.lua
lua/kickstart/
  keymaps.lua
  search.lua
  lsp.lua
  completion.lua
  ...
```

Each module is independent and can be disabled by removing its `require(...)` line from `init.lua`.

## Useful commands

- `:checkhealth` - verify Neovim and plugins
- `:checkhealth kickstart` - verify this configuration's dependencies
- `:Mason` - manage language servers/formatters
- `:LspInfo` - inspect attached LSP clients

## Reproducibility

- This config targets Neovim 0.12+.
- Plugin versions are managed by `vim.pack`.
- For reproducible installs, track `nvim-pack-lock.json` in version control.
- Run `scripts/check-deps.sh` before first launch.
- Run `scripts/benchmark.sh` to measure startup time.

## Notes

- `gd` jumps directly to a definition.
- `gr` opens a picker because references are usually multiple.
- Snippets are loaded from `stdpath("config")/.lua_snippet`.

## Troubleshooting

- If search does not work, run `:lua require("fff.download").download_or_build_binary()`.
- If a plugin fails to load, check `:messages` and `:checkhealth`.
- Startup time can be checked with `nvim --startuptime /tmp/startup.log`.
