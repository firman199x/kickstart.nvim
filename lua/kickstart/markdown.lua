local gh = function(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  gh("epwalsh/obsidian.nvim"),
  gh("nvim-lua/plenary.nvim"),
  gh("OXY2DEV/markview.nvim"),
  gh("tadmccorkle/markdown.nvim"),
})

local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if ok then
  treesitter.setup({
    ensure_installed = { "markdown", "markdown_inline" },
    auto_install = true,
    highlight = { enable = true },
  })
end

require('obsidian').setup({
  workspaces = {
    { name = "personal", path = "~/vaults/personal" },
    { name = "work", path = "~/vaults/work" },
  },
  ui = { enable = false },
})
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianToday<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>od", "<cmd>ObsidianDailies<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<BS>", "<cmd>ObsidianBacklinks<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gd", "<cmd>ObsidianFollowLink<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gt", "<cmd>ObsidianTags<cr>", { silent = true, noremap = true })

local presets = require 'markview.presets'
require('markview').setup {
  markdown = {
    headings = presets.headings.glow,
    horizontal_rules = presets.horizontal_rules.dotted,
    tables = presets.tables.rounded,
  },
}

require('markdown').setup({})
