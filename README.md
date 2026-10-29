# kickstart.nvim (personal fork)

A modular Neovim configuration built on `vim.pack`, LSP, blink.cmp, mini.nvim, and fff.nvim.

## Requirements

- Neovim 0.11+ (this config uses `vim.pack` and `vim.lsp.config`)
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
- `:Mason` - manage language servers/formatters
- `:LspInfo` - inspect attached LSP clients

## Notes

- `gd` jumps directly to a definition.
- `gr` opens a picker because references are usually multiple.
- Snippets are loaded from `stdpath("config")/.lua_snippet`.

## Troubleshooting

- If search does not work, run `:lua require("fff.download").download_or_build_binary()`.
- If a plugin fails to load, check `:messages` and `:checkhealth`.
- Startup time can be checked with `nvim --startuptime /tmp/startup.log`.
