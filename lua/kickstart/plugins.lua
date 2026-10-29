local M = {}

local gh = require("kickstart.util").gh

M.loaders = {
	init = function()
		vim.pack.add({
			gh("echasnovski/mini.nvim"),
		})
	end,

	search = function()
		vim.pack.add({
			gh("dmtrKovalenko/fff"),
			gh("echasnovski/mini.nvim"),
		})
	end,

	lsp = function()
		vim.pack.add({
			gh("neovim/nvim-lspconfig"),
			gh("mason-org/mason.nvim"),
			gh("mason-org/mason-lspconfig.nvim"),
			gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
		})
	end,

	completion = function()
		vim.pack.add({
			{ src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("2.*") },
		})
		vim.pack.add({
			gh("rafamadriz/friendly-snippets"),
		})
		vim.pack.add({
			gh("chrisgrieser/nvim-scissors"),
		})
		vim.pack.add({
			{ src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
		})
		vim.pack.add({
			"https://github.com/tpope/vim-fugitive",
		})
	end,

	["file-tree"] = function()
		vim.pack.add({
			"https://github.com/nvim-tree/nvim-tree.lua",
		})
	end,

	hop = function()
		vim.pack.add({
			{ src = "https://github.com/Borber/hop.nvim", enabled = false },
		})
	end,

	outline = function()
		vim.pack.add({
			"https://github.com/hedyhli/outline.nvim",
		})
	end,

	terminal = function()
		vim.pack.add({
			"https://github.com/akinsho/toggleterm.nvim",
		})
	end,

	statusline = function()
		vim.pack.add({
			"https://github.com/nvim-lualine/lualine.nvim",
		})
		vim.pack.add({
			"https://github.com/romgrk/barbar.nvim",
		})
	end,

	markdown = function()
		vim.pack.add({
			gh("epwalsh/obsidian.nvim"),
			gh("nvim-lua/plenary.nvim"),
			gh("OXY2DEV/markview.nvim"),
			gh("tadmccorkle/markdown.nvim"),
		})
	end,

	theme = function()
		vim.pack.add({
			{
				src = "https://github.com/sainnhe/gruvbox-material",
			},
		})
	end,
}

function M.load(name)
	local loader = M.loaders[name]
	if loader then
		loader()
	else
		vim.notify("Unknown plugin group: " .. tostring(name), vim.log.levels.WARN)
	end
end

return M
