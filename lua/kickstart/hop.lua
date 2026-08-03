vim.pack.add({
    {
        src = "https://github.com/folke/flash.nvim",
    },
})

require("flash").setup({
    labels = "lkjsdf.,mxcv",
    modes = {
        search = {
            enabled = true,
        },
        char = {
            enabled = false, -- don't override f/F/t/T
        },
    },
})

vim.keymap.set("n", "f", function()
    require("flash").jump({
        search = {
            mode = "search",
        },
    })
end, { silent = true, desc = "Flash Word" })
