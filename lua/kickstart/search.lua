local function gh(repo)
	return "https://github.com/" .. repo
end

-- ============================================================
-- SECTION 5: SEARCH & NAVIGATION
-- Telescope setup, keymaps, LSP picker mappings
-- ============================================================
do
	local telescope_plugins = {
		gh("nvim-lua/plenary.nvim"),
		gh("nvim-telescope/telescope.nvim"),
		gh("nvim-telescope/telescope-ui-select.nvim"),
		gh("dmtrKovalenko/fff"),
	}
	if vim.fn.executable("make") == 1 then
		table.insert(telescope_plugins, gh("nvim-telescope/telescope-fzf-native.nvim"))
	end

	vim.pack.add(telescope_plugins)

	vim.api.nvim_create_autocmd("PackChanged", {
		group = vim.api.nvim_create_augroup("fff-build", { clear = true }),
		callback = function(ev)
			local name, kind = ev.data.spec.name, ev.data.kind
			if name == "fff" and (kind == "install" or kind == "update") then
				if not ev.data.active then vim.cmd.packadd("fff") end
				require("fff.download").download_or_build_binary()
			end
		end,
	})

	vim.g.fff = {
		lazy_sync = true,
	}

    require("fff").setup({
        grep = {
            modes = { "regex", "fuzzy", "plain" },
        },
    })

	require("telescope").setup({
		extensions = {
			["ui-select"] = { require("telescope.themes").get_dropdown() },
		},
	})
	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "ui-select")

	-- See `:help telescope.builtin`
	local builtin = require("telescope.builtin")

	vim.keymap.set("n", "<leader>ff", function() require("fff").find_files() end, { desc = "[F]ind [F]iles" })
	vim.keymap.set("n", "<leader>fg", function()
		local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("%s+$", "")
		if git_root == "" then
			vim.notify("Not in a git repository", vim.log.levels.WARN)
			return
		end
		require("fff").find_files({ cwd = git_root, title = "Grep (Git Root)" })
	end, {})

	vim.keymap.set("n", "<leader>/", function() require("fff").live_grep() end, { desc = "[S]earch by [G]rep" })
	vim.keymap.set("n", "<leader>//", function()
		local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("%s+$", "")
		if git_root == "" then
			vim.notify("Not in a git repository", vim.log.levels.WARN)
			return
		end
		require("fff").live_grep({ cwd = git_root, title = "Grep (Git Root)" })
	end, { desc = "[G]rep from [G]it [R]oot" })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
		callback = function(event)
			local buf = event.buf
			vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = buf, desc = "[G]oto [R]eferences" })
			vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = buf, desc = "[G]oto [D]efinition" })
			vim.keymap.set("n", "K", builtin.lsp_document_symbols, { buffer = buf, desc = "Open Document Symbols" })
		end,
	})
end
