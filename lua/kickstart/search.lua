local gh = require("kickstart.util").gh

-- ============================================================
-- SECTION 5: SEARCH & NAVIGATION
-- fff for file finding/grep, mini.pick for LSP pickers & ui-select
-- ============================================================
do
	vim.pack.add({
		gh("dmtrKovalenko/fff"),
		gh("echasnovski/mini.nvim"),
	})

	vim.api.nvim_create_autocmd("PackChanged", {
		group = vim.api.nvim_create_augroup("fff-build", { clear = true }),
		callback = function(ev)
			local name, kind = ev.data.spec.name, ev.data.kind
			if name == "fff" and (kind == "install" or kind == "update") then
				if not ev.data.active then
					vim.cmd.packadd("fff")
				end
				require("fff.download").download_or_build_binary()
			end
		end,
	})

	vim.g.fff = {
		lazy_sync = true,
	}

	require("fff").setup({
		grep = {
			modes = { "plain", "regex", "fuzzy" },
		},
	})

	require("mini.pick").setup()
	require("mini.extra").setup()

	-- LSP picker helper via mini.extra
	local builtin_lsp = function(scope)
		return function()
			require("mini.extra").pickers.lsp({ scope = scope })
		end
	end
	local grep_current_word_or_selection = function()
		local mode = vim.fn.mode()
		local query
		if mode == "v" or mode == "V" or mode == "\22" then
			local start_pos = vim.fn.getpos("v")
			local end_pos = vim.fn.getpos(".")
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
			local ok, region = pcall(vim.fn.getregion, start_pos, end_pos)
			if ok and type(region) == "table" and #region > 0 then
				query = table.concat(region, " ")
			end
		end
		if not query or query == "" then
			query = vim.fn.expand("<cword>")
		end
		require("fff").live_grep({ query = query })
	end

	vim.keymap.set(
		{ "n", "x" },
		"<F5><F5>",
		grep_current_word_or_selection,
		{ desc = "Search current word / selection", silent = true }
	)
	vim.keymap.set("n", "<leader>ff", function()
		require("fff").find_files()
	end, { desc = "[F]ind [F]iles" })
	vim.keymap.set("n", "<leader>fg", function()
		local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("%s+$", "")
		if git_root == "" then
			vim.notify("Not in a git repository", vim.log.levels.WARN)
			return
		end
		require("fff").find_files({ cwd = git_root, title = "Grep (Git Root)" })
	end, {})
	vim.keymap.set("n", "<leader>/", function()
		require("fff").live_grep()
	end, { desc = "[S]earch by [G]rep" })
	vim.keymap.set("n", "<leader>//", function()
		local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("%s+$", "")
		if git_root == "" then
			vim.notify("Not in a git repository", vim.log.levels.WARN)
			return
		end
		require("fff").live_grep({ cwd = git_root, title = "Grep (Git Root)" })
	end, { desc = "[G]rep from [G]it [R]oot" })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("mini-lsp-attach", { clear = true }),
		callback = function(event)
			local buf = event.buf
			vim.keymap.set("n", "gr", builtin_lsp("references"), { buffer = buf, desc = "[G]oto [R]eferences" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "[G]oto [D]efinition" })
		end,
	})
end
