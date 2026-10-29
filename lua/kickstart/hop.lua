vim.pack.add({
	{ src = "https://github.com/Borber/hop.nvim", enabled = false },
})

require("hop").setup({
	multi_windows = false,
	keys = "lkjsdf.,mxcv",
})

vim.keymap.set("n", "f", ":HopWord<cr>", { remap = true, silent = true })
