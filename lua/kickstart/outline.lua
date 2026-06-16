vim.pack.add { 'https://github.com/hedyhli/outline.nvim' }
require('outline').setup {
  show_cursorline = true,
  outline_items = {
    show_symbol_details = false,
  },
  outline_window = {
    show_cursorline = true,
    auto_jump = true,
    jump_highlight_duration = 200,
    center_on_jump = true,
  },
  guides = {
    enabled = false,
  },
  symbol_folding = {
    autofold_depth = 1,
    hovered = false,
  },
  symbols = {
    filter = { 'String', exclude = true },
  },
  keymaps = {
    show_help = '?',
    close = { '<Esc>', 'q' },
    goto_location = '<Cr>',
    peek_location = 'o',
    goto_and_close = '<S-Cr>',
    restore_location = '<C-g>',
    hover_symbol = '<C-space>',
    toggle_preview = 'K',
    rename_symbol = 'r',
    code_actions = 'a',
    fold = 'h',
    unfold = 'l',
    fold_toggle = '<BS>',
    fold_toggle_all = '<Tab>',
    fold_all = 'W',
    unfold_all = 'E',
    fold_reset = 'R',
    down_and_jump = '<C-j>',
    up_and_jump = '<C-k>',
  },
}
vim.keymap.set('n', '<F3>', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })
