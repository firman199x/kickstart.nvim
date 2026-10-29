require("kickstart.plugins").load("hop")

require("hop").setup({
	multi_windows = false,
	keys = "lkjsdf.,mxcv",
})

vim.keymap.set("n", "f", ":HopWord<cr>", { remap = true, silent = true, desc = "f" })
