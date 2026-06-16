vim.pack.add({ 'https://github.com/swaits/tiny-jump.nvim' })
require('tiny-jump').setup {
  labels = 'asdfjkl;',
}
vim.keymap.set('n', 'f', function() require('tiny-jump').start() end, { desc = 'Tiny jump' })
