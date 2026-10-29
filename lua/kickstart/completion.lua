local gh = require("kickstart.util").gh

vim.pack.add({ { src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("2.*") } })

vim.pack.add({ gh("rafamadriz/friendly-snippets") })

local ls = require("luasnip")
ls.setup({})

require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "cpp", "vue" } })
require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/.lua_snippet" })

vim.keymap.set({ "i", "s" }, "<C-l>", function()
	if ls.expand_or_locally_jumpable() then
		ls.expand_or_jump()
	end
end, { desc = "Snippet: jump forward" })
vim.keymap.set({ "i", "s" }, "<C-h>", function()
	if ls.locally_jumpable(-1) then
		ls.jump(-1)
	end
end, { desc = "Snippet: jump backward" })

vim.pack.add({ gh("chrisgrieser/nvim-scissors") })
require("scissors").setup({
	snippetDir = vim.fn.stdpath("config") .. "/.lua_snippet",
})
vim.keymap.set("n", "<leader>se", function()
	require("scissors").editSnippet()
end, { desc = "Snippet: [E]dit" })
vim.keymap.set({ "n", "x" }, "<leader>sa", function()
	require("scissors").addNewSnippet()
end, { desc = "Snippet: [A]dd" })

vim.pack.add({ { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") } })
require("blink.cmp").setup({
	keymap = {
		["<C-j>"] = { "select_next", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = { documentation = { auto_show = false } },
	sources = { default = { "lsp", "path", "snippets" } },
	snippets = { preset = "luasnip" },
	fuzzy = { implementation = "lua" },
	cmdline = {
		keymap = {
			["<Tab>"] = { "select_and_accept", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
		},
		sources = { "buffer", "cmdline" },
		completion = { menu = { auto_show = true } },
	},
})

vim.pack.add({ "https://github.com/tpope/vim-fugitive" })
vim.keymap.set("n", "<tab><tab>l", "3X", { noremap = true, silent = true })
vim.keymap.set("n", "<tab><tab>h", "2X", { noremap = true, silent = true })
-- Keep LSP running during Git commands; stopping it globally caused stale diagnostics.
