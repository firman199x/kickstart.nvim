require("kickstart.plugins").load("vellum")

require("vellum").setup({
	max_width = 100,
	tab = false,
})

vim.keymap.set("n", "<leader>mp", "<cmd>Vellum<cr>", { desc = "Markdown preview" })
vim.keymap.set("n", "<leader>mz", function()
	require("vellum").zoom()
end, { desc = "Zoom image at cursor" })