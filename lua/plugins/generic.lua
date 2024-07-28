return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  {
    'tpope/vim-fugitive',
    event = { 'CmdlineEnter' },
    config = function()
      vim.api.nvim_set_keymap('n', '<tab><tab>l', '3X', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<tab><tab>h', '2X', { noremap = true, silent = true })
    end,
  },

  { 'tpope/vim-sleuth' },

  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
        hide_numbers = false,
        direction = 'float',
        open_mapping = [[<F12>]],

        vim.keymap.set('n', '<C-b>', ':TermExec cmd="wmakeD"<CR>'),
      }

      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)

        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

        vim.keymap.set('t', '<A-h>', [[<Cmd>vertical resize +10<CR>]], opts)
        vim.keymap.set('t', '<A-l>', [[<Cmd>vertical resize -10<CR>]], opts)
        vim.keymap.set('t', '<A-k>', [[<Cmd>resize +10<CR>]], opts)
        vim.keymap.set('t', '<A-j>', [[<Cmd>resize -10<CR>]], opts)

        vim.keymap.set('t', '<C-b>', [[<Cmd>TermExec cmd="wmakeD"<CR>]], opts)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

      vim.cmd [[
            autocmd TermEnter * highlight CppFile ctermfg=red guifg='#bff599' guibg='none'
            autocmd TermEnter * call matchadd('CppFile', "[a-zA-Z0-9_]\\+\\.[a-z]\\+([0-9]\\+):[a-z ]")
            autocmd TermEnter * highlight CppError ctermfg=red guifg='#ffffff' guibg='#cc4c4c'
            autocmd TermEnter * call matchadd('CppError', "[a-zA-Z0-9_]\\+\\.[a-z]\\+([0-9]\\+):[a-z ]\\+error")
            autocmd TermEnter * highlight CppWriteError ctermfg=red guifg='#000000' guibg='#d70000'
            autocmd TermEnter * call matchadd('CppWriteError', "LINK .* cannot open .* for writing")
            autocmd TermEnter * highlight CppWarn ctermfg=red guifg='#ffd31a'
            autocmd TermEnter * call matchadd('CppWarn', "[a-zA-Z0-9_]\\+\\.[a-z]\\+([0-9]\\+): warning")
            autocmd TermEnter * highlight CppLinking ctermfg=red guifg='#ffffff' guibg='#005400'
            autocmd TermEnter * call matchadd('CppLinking', "\\zsLinking C\.* [a-z]\\+\\ze .*\\\\\\zs[a-zA-Z_\\.]\\+$")
            autocmd TermEnter * call matchadd('CppLinking', "static library\\|executable\\|shared library")
            ]]
      --

      -- vim.cmd [[ autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n> ]]
      vim.cmd [[ command! VTerm :ToggleTerm direction=vertical size=150 ]]
      vim.api.nvim_set_keymap('n', '<F10>', ':ToggleTerm direction=vertical size=150<CR>', { noremap = true, silent = true })
    end,
  },
}
