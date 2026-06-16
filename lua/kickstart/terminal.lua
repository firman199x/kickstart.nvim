vim.pack.add { 'https://github.com/akinsho/toggleterm.nvim' }

require('toggleterm').setup {
  hide_numbers = false,
  direction = 'float',
  open_mapping = [[<F12>]],
  float_opts = { title_pos = 'center' },
  winbar = { enabled = false },
}

vim.keymap.set('n', '<C-b>', '<cmd>TermExec cmd="wcompile"<CR>', { desc = 'Run wcompile' })
vim.keymap.set('n', '<F10>', '<cmd>ToggleTerm direction=horizontal size=15<CR>', { desc = 'Horizontal terminal' })

vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { buffer = 0 })
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { buffer = 0 })
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { buffer = 0 })
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { buffer = 0 })
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { buffer = 0 })
  end,
})

vim.cmd [[
  command! VTerm :ToggleTerm direction=vertical size=80
  command! HTerm :ToggleTerm direction=horizontal size=80
  command! Term :require('toggleterm.terminal').Terminal:new({})
]]

vim.api.nvim_create_autocmd('TermEnter', {
  callback = function()
    vim.cmd [[highlight CppFile ctermfg=red guifg=#bff599 guibg=none]]
    vim.cmd [[call matchadd("CppFile", "[a-zA-Z0-9_]\+\.[a-z]\+([0-9]\+):[a-z ]")]]
    vim.cmd [[highlight CppError ctermfg=red guifg=#ffffff guibg=#cc4c4c]]
    vim.cmd [[call matchadd("CppError", "[a-zA-Z0-9_]\+\.[a-z]\+([0-9]\+):[a-z ]\+error")]]
    vim.cmd [[highlight CppWriteError ctermfg=red guifg=#000000 guibg=#d70000]]
    vim.cmd [[call matchadd("CppWriteError", "LINK .* cannot open .* for writing")]]
    vim.cmd [[highlight CppWarn ctermfg=red guifg=#ffd31a]]
    vim.cmd [[call matchadd("CppWarn", "[a-zA-Z0-9_]\+\.[a-z]\+([0-9]\+): warning")]]
    vim.cmd [[highlight CppLinking ctermfg=red guifg=#ffffff guibg=#005400]]
    vim.cmd [[call matchadd("CppLinking", "\zsLinking C\.* [a-z]\+\ze .*\\\zs[a-zA-Z_\.]\+\$")]]
    vim.cmd [[call matchadd("CppLinking", "static library\|executable\|shared library")]]
    vim.cmd [[highlight CppUnresolve ctermfg=red guifg=#7b5dff guibg=none]]
    vim.cmd [[call matchadd("CppUnresolve", "unresolved external symbol")]]
    vim.cmd [[highlight CppMethod ctermfg=red guifg=#65d1ff guibg=none]]
    vim.cmd [[call matchadd("CppMethod", "[0-9a-zA-Z]\+::[0-9a-zA-Z]\+\ze(")]]
  end,
})
