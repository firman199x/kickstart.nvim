-- ============================================================
-- SECTION 2: KEYMAPS
-- basic keymaps
-- ============================================================
do
	-- [[ Basic Keymaps ]]
	--  See `:help vim.keymap.set()`
	vim.keymap.set("n", "zx", "zt")

	vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
	vim.keymap.set("n", "<C-q>", ":qa<CR>", { silent = true })
	vim.keymap.set("n", "<F4>", "<C-^>", { silent = true })
	vim.keymap.set("n", "<BS>u", "<C-^>", { silent = true })
	vim.keymap.set("n", "<BS>m", "<C-^>", { silent = true })
	vim.keymap.set("n", "<C-m>", "<C-^>", { silent = true })
	vim.keymap.set("n", "]]", "]czz", { silent = true })
	vim.keymap.set("n", "[[", "[czz", { silent = true })

	vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move focus to the left window" })
	vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move focus to the right window" })
	vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move focus to the lower window" })
	vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move focus to the upper window" })

	vim.keymap.set("n", "<space>H", "<C-w>H", { silent = true })
	vim.keymap.set("n", "<space>J", "<C-w>J", { silent = true })
	vim.keymap.set("n", "<space>K", "<C-w>K", { silent = true })
	vim.keymap.set("n", "<space>L", "<C-w>L", { silent = true })

	vim.keymap.set("n", "<space><space>l", "gt", { silent = true })
	vim.keymap.set("n", "<space><space>h", "gT", { silent = true })

	vim.keymap.set("n", "<A-h>", ":vertical resize +10<CR>", { silent = true })
	vim.keymap.set("n", "<A-l>", ":vertical resize -10<CR>", { silent = true })
	vim.keymap.set("n", "<A-k>", ":resize +10<CR>", { silent = true })
	vim.keymap.set("n", "<A-j>", ":resize -10<CR>", { silent = true })

	vim.keymap.set("n", "<C-o>", "<C-o>zz", { silent = true })
	vim.keymap.set("n", "<C-i>", "<C-i>zz", { silent = true })

	vim.keymap.set("i", "{<CR>", "{<CR>}<Esc>O", { silent = true })
	vim.keymap.set("i", "{}<CR>", "{<CR>}<Esc>O", { silent = true })
	vim.keymap.set("i", "[]<CR>", "[<CR>]<Esc>O", { silent = true })
	vim.keymap.set("i", "()<CR>", "()<CR>)<Esc>O", { silent = true })

	vim.keymap.set("i", "()", "()<Esc>i", { silent = true })
	vim.keymap.set("i", "{}", "{}<Esc>ha", { silent = true })
	vim.keymap.set("i", "<>", "<><Esc>ha", { silent = true })
	vim.keymap.set("i", "[]", "[]<Esc>ha", { silent = true })
	vim.keymap.set("i", '""', '""<Esc>ha', { silent = true })
	vim.keymap.set("i", '","', '","', { silent = true })
	vim.keymap.set("i", "''", "''<Esc>ha", { silent = true })
	vim.keymap.set("i", "','", "','", { silent = true })

	vim.keymap.set("n", ";;", "$a;<Esc>", { silent = true })
	vim.keymap.set("i", ";;", "<Esc>$a;<Esc>", { silent = true })
	vim.keymap.set("i", ",,", "<Esc>$a,<Esc>", { silent = true })
	vim.keymap.set("n", ",,", "$a,<Esc>", { silent = true })

	vim.keymap.set("i", "()<CR>", "()<CR>", { silent = true })
	vim.keymap.set("i", "();", "();", { silent = true })
	vim.keymap.set("i", "():", "():", { silent = true })
	vim.keymap.set("i", "().", "().", { silent = true })

	-- Delete Trailing Whitespace
	vim.keymap.set("n", "<Space><BS>", [[:%s/\s\+$//e<CR>]], { silent = true })

	vim.keymap.set("v", "<Down>", "5j", { silent = true })
	vim.keymap.set("v", "<Up>", "5k", { silent = true })
	vim.keymap.set("n", "<Down>", "5j", { silent = true })
	vim.keymap.set("n", "<Up>", "5k", { silent = true })
	vim.keymap.set("n", "<Right>", "W", { silent = true })
	vim.keymap.set("n", "<Left>", "B", { silent = true })

	vim.keymap.set("n", "<A-n>", "<C-w>jj<CR>zz", { silent = true })
	vim.keymap.set("n", "<A-m>", "<C-w>jk<CR>zz", { silent = true })

	-- Retain the clipboard data when pasting using V-Mode
	vim.keymap.set("x", "p", [["_dP]], { silent = true })

	vim.keymap.set("x", "<space>F", [[:'<,'>!jq --indent 4 .<CR>]], { silent = true })
	vim.keymap.set("n", "<F1><F1>", [[:set list!<CR>]], { silent = true })
	vim.keymap.set("n", "<space><space>zf", "va}zf", { silent = true })
	vim.keymap.set("x", "<space>sn", "}i$<esc>li:<esc>ih", { silent = true })
	vim.keymap.set("n", "zl", "40zl", { silent = true })
	vim.keymap.set("n", "zh", "40zh", { silent = true })
	vim.keymap.set("n", "json", ":set filetype=json<CR>", { silent = true })
	vim.keymap.set("n", "<Del>", "<Nop>", { silent = true })
	vim.keymap.set("n", "<space>Z", "vi}zf", { silent = true })

	vim.keymap.set("n", "<F5>", [[:let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>]], { silent = true })
	vim.keymap.set(
		"x",
		"<F5>",
		[[:<C-u>let @/=getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]-1]<CR>:set hls<CR>]],
		{ silent = true }
	)
	local function open_file_location()
		local system = vim.loop.os_uname().sysname
		if system == "Windows_NT" then
			vim.api.nvim_command("silent !start explorer /select,%:p")
		elseif system == "Linux" then
			vim.api.nvim_command('silent !explorer.exe "$(wslpath -w "$(realpath %:p:h)")"')
		end
	end
	vim.keymap.set(
		"n",
		"<space><space>n",
		open_file_location,
		{ silent = true, desc = "Open file location in explorer" }
	)

	local function append_current_word_to_search()
		local current_word = vim.fn.expand("<cword>")
		local search_pattern = vim.fn.getreg("/")

		if search_pattern == "" then
			search_pattern = current_word
		else
			search_pattern = search_pattern .. "\\|" .. current_word
		end

		vim.fn.setreg("/", search_pattern)
		vim.cmd("set hls")
	end
	vim.keymap.set(
		"n",
		"<F1>",
		append_current_word_to_search,
		{ noremap = true, silent = true, desc = "Append current word to search" }
	)

	-- Diagnostic Config & Keymaps
	--  See `:help vim.diagnostic.Opts`
	vim.diagnostic.config({
		update_in_insert = false,
		severity_sort = true,
		float = { border = "rounded", source = "if_many" },
		underline = { severity = { min = vim.diagnostic.severity.WARN } },

		-- Can switch between these as you prefer
		virtual_text = true, -- Text shows up at the end of the line
		virtual_lines = false, -- Text shows up underneath the line, with virtual lines

		-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
		jump = {
			on_jump = function(_, bufnr)
				vim.diagnostic.open_float({
					bufnr = bufnr,
					scope = "cursor",
					focus = false,
				})
			end,
		},
	})

	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

	-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
	-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
	-- is not what someone will guess without a bit more experience.
	--
	-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
	-- or just use <C-\><C-n> to exit terminal mode
	vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

	-- [[ Basic Autocommands ]]
	--  See `:help lua-guide-autocommands`

	-- Highlight when yanking (copying) text
	--  Try it with `yap` in normal mode
	--  See `:help vim.hl.on_yank()`
	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Highlight when yanking (copying) text",
		group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
		callback = function()
			vim.hl.on_yank({ higroup = "DiffAdd", timeout = 800 })
		end,
	})

	vim.api.nvim_create_autocmd("ModeChanged", {
		desc = "EnableRelativeLineNumbers",
		group = vim.api.nvim_create_augroup("EnableRelativeLineNumbers", { clear = true }),
		pattern = "*",
		callback = function()
			vim.wo.relativenumber = vim.fn.mode() ~= "n"
		end,
	})
end
