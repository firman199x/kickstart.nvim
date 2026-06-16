local ok = pcall(vim.pack.add, { 'https://github.com/swaits/tiny-jump.nvim' })
if ok then
  require('tiny-jump').setup {
    labels = 'fjdkslahgeiruowmcnvptyqxzb',
  }
  vim.keymap.set('n', 'f', function() require('tiny-jump').start() end, { desc = 'Tiny jump' })
end
