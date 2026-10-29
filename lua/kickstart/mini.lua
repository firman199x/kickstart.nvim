--------------------- MINI -------------------

require("mini.indentscope").setup({
	symbol = "|",
	draw = {
		animation = require("mini.indentscope").gen_animation.none(),
	},
})

-- Disable for certain filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Disable indentscope for certain filetypes",
	callback = function()
		local ignore_filetypes = {
			"aerial",
			"dashboard",
			"help",
			"lazy",
			"leetcode.nvim",
			"mason",
			"neo-tree",
			"NvimTree",
			"neogitstatus",
			"notify",
			"startify",
			"toggleterm",
			"Trouble",
		}
		if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
			vim.b.miniindentscope_disable = true
		end
	end,
})

-- Disable in Visual mode
local f_en = function(args)
	vim.b[args.buf].miniindentscope_disable = true
end
local enable_opts = { pattern = "[vV\x16]*:*", callback = f_en }
vim.api.nvim_create_autocmd("ModeChanged", enable_opts)

local f_dis = function(args)
	vim.b[args.buf].miniindentscope_disable = false
end
local disable_opts = { pattern = "*:[vV\x16]*", callback = f_dis }
vim.api.nvim_create_autocmd("ModeChanged", disable_opts)

-- Disable in Terminal buffer
local f_2 = function(args)
	vim.b[args.buf].miniindentscope_disable = true
end
vim.api.nvim_create_autocmd("TermOpen", { callback = f_2 })

require("mini.surround").setup()
vim.keymap.set("n", "si", "sai", { silent = true, remap = true, desc = "si" })
vim.keymap.set("x", "q", "sa'", { silent = true, remap = true, desc = "q" })
vim.keymap.set("x", "Q", 'sa"', { silent = true, remap = true, desc = "Q" })
vim.keymap.set("x", "'", "sa'", { silent = true, remap = true, desc = "'" })
vim.keymap.set("x", '"', 'sa"', { silent = true, remap = true, desc = '"' })
vim.keymap.set("x", "(", "sa)", { silent = true, remap = true, desc = "(" })
vim.keymap.set("x", ")", "sa)", { silent = true, remap = true, desc = ")" })
vim.keymap.set("x", "}", "sa}", { silent = true, remap = true, desc = "}" })
vim.keymap.set("x", "{", "sa}", { silent = true, remap = true, desc = "{" })
vim.keymap.set("x", "]", "sa]", { silent = true, remap = true, desc = "]" })
vim.keymap.set("x", "[", "sa]", { silent = true, remap = true, desc = "[" })
vim.keymap.set("x", "`", "sa`", { silent = true, remap = true, desc = "`" })

require("mini.move").setup({
	mappings = {
		line_left = "<S-left>",
		line_right = "<S-right>",
		line_down = "<S-down>",
		line_up = "<S-up>",
	},
})
