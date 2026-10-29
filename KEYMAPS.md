# Keymaps

This is a curated reference for the most important keybindings. Many smaller text-editing shortcuts also exist; use `:map` or `:verbose map <key>` to inspect them.

## General

| Key | Mode | Description |
|---|---|---|
| `<Esc>` | n | Clear search highlight |
| `<C-q>` | n | Quit all |
| `<C-h/j/k/l>` | n | Move between windows |
| `<A-h/j/k/l>` | n | Resize windows |
| `<F4>` / `<BS>u` / `<BS>m` / `<C-m>` | n | Alternate buffer |
| `zx` | n | Scroll current line to top (`zt`) |

## Search and files

| Key | Mode | Description |
|---|---|---|
| `<leader>ff` | n | Find files |
| `<leader>fg` | n | Find files from Git root |
| `<leader>/` | n | Live grep |
| `<leader>//` | n | Live grep from Git root |
| `<F5><F5>` | n/x | Search current word or selection |
| `<F1>` | n | Append current word to search |
| `<leader>gh` | n | Copy GitHub URL for current line |

## LSP

| Key | Mode | Description |
|---|---|---|
| `gd` | n | Go to definition |
| `gr` | n | Go to references (picker) |
| `K` | n | Hover documentation |
| `<space>rn` | n | Rename symbol |
| `<space>fx` | n | Code action |
| `<space>d` | n | Show line diagnostics |
| `[d` / `]d` | n | Previous/next diagnostic |
| `<space>rs` | n | Restart LSP |
| `<space><space>f` | n | Format file |
| `<space>f` | x | Format selection |

## UI and navigation

| Key | Mode | Description |
|---|---|---|
| `<C-n>` | n | Toggle NvimTree |
| `<F3>` | n | Toggle Outline |
| `<F10>` | n | Horizontal terminal |
| `<C-b>` | n | Run `wcompile` |
| `ZZ` | n | Smart close |
| `<space>xc` | n | Close all except current window |
| `<space><space>n` | n | Open file location in explorer |
| `<space><space>l/h` | n | Next/previous tab |
| `<C-Left/Right>` | n | Previous/next buffer |
| `<C-Up/Down>` | n | Move buffer |

## Markdown / Obsidian

| Key | Mode | Description |
|---|---|---|
| `gd` | n | Follow Obsidian link |
| `gt` | n | Obsidian tags |
| `<leader>od` | n | Obsidian dailies |
| `<leader>ot` | n | Obsidian today |
| `<leader>oy` | n | Obsidian yesterday |
| `<BS>` | n | Obsidian backlinks |

## Completion and snippets

| Key | Mode | Description |
|---|---|---|
| `<Tab>` | i | Accept completion / snippet forward |
| `<C-j>` / `<Down>` | i | Next completion item |
| `<C-k>` / `<Up>` | i | Previous completion item |
| `<C-l>` | i/s | Expand or jump snippet forward |
| `<C-h>` | i/s | Jump snippet backward |
| `<leader>se` | n | Edit snippet |
| `<leader>sa` | n/x | Add snippet |

## Terminal mode

| Key | Mode | Description |
|---|---|---|
| `<Esc><Esc>` | t | Exit terminal mode |

## Notes

- `gd` jumps directly; `gr` opens a picker because references are usually multiple.
- `<F5>` highlights the current word; `<F5><F5>` searches it.
- NvimTree, Outline, and Terminal modules load lazily on first use.

## Known conflicts and caveats

- `<F5>` and `<F5><F5>` share a prefix, so double-F5 has a small `timeoutlen` delay.
- Arrow keys are intentionally remapped in normal/visual mode (`<Up/Down>` move 5 lines, `<Left/Right>` move by word).
- `<C-h/j/k/l>` are used for window navigation, which may conflict with terminal multiplexers.
- Markdown files override `gd` for Obsidian links.
