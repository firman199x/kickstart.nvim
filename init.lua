-- Minimal Neovim config

-- ============================================================
-- SECTION 1: OPTIONS
-- Core Neovim settings, leaders, options, basic keymaps, basic autocmds
-- ============================================================
do
	vim.loader.enable()
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "
	vim.g.have_nerd_font = false

	vim.o.number = true
	vim.o.mouse = "a"
	vim.o.showmode = false
	vim.schedule(function()
		vim.o.clipboard = "unnamedplus"
	end)
	vim.o.breakindent = true
	vim.o.undofile = true
	vim.o.ignorecase = true
	vim.o.smartcase = true
	vim.o.signcolumn = "yes"
	vim.o.updatetime = 250
	vim.o.timeoutlen = 300
	vim.o.splitright = true
	vim.o.splitbelow = true
	vim.o.list = true
	vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
	vim.o.inccommand = "split"
	vim.o.cursorline = true
	vim.o.scrolloff = 10
	vim.o.confirm = true
end

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
	function OpenFileLocation()
		local system = vim.loop.os_uname().sysname
		if system == "Windows_NT" then
			vim.api.nvim_command("silent !start explorer /select,%:p")
		elseif system == "Linux" then
			vim.api.nvim_command('silent !explorer.exe "$(wslpath -w "$(realpath %:p:h)")"')
		end
	end
	vim.keymap.set("n", "<space><space>n", ":lua OpenFileLocation()<cr>", { silent = true })

	function AppendCurrentWordToSearch()
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
	vim.keymap.set("n", "<F1>", [[:lua AppendCurrentWordToSearch()<CR>]], { noremap = true })

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
			vim.hl.on_yank()
		end,
	})
end

local function gh(repo)
	return "https://github.com/" .. repo
end

local function gitbrowse()
	local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("%s+$", "")
	if git_root == "" then return vim.notify("Not in a git repo", vim.log.levels.WARN) end

	local file = vim.fn.expand("%:p")
	local rel = file:sub(#git_root + 2)
	local line = vim.fn.line(".")
	local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null"):gsub("%s+$", "")
	if branch == "" then branch = "HEAD" end

	local remote = vim.fn.system("git remote get-url origin 2>/dev/null"):gsub("%s+$", "")
	local repo_path = remote:gsub("^git@github%.com:", ""):gsub("^https://github%.com/", ""):gsub("%.git$", "")
	if repo_path == "" or repo_path == remote then
		return vim.notify("Could not parse GitHub remote", vim.log.levels.WARN)
	end

	local url = string.format("https://github.com/%s/blob/%s/%s#L%d", repo_path, branch, rel, line)
	vim.fn.setreg("+", url)
	vim.notify("Copied: " .. url, vim.log.levels.INFO)
end
vim.keymap.set("n", "<leader>gh", gitbrowse, { desc = "Open on [G]it[H]ub" })
vim.api.nvim_create_user_command("GitBrowse", gitbrowse, {})


vim.cmd.colorscheme("default")

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
	vim.keymap.set("n", "<leader>/", function() require("fff").live_grep() end, { desc = "[S]earch by [G]rep" })
	vim.keymap.set("n", "<leader>//", function()
		local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("%s+$", "")
		if git_root == "" then
			vim.notify("Not in a git repository", vim.log.levels.WARN)
			return
		end
		require("fff").live_grep({ cwd = git_root })
	end, { desc = "[G]rep from [G]it [R]oot" })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
		callback = function(event)
			local buf = event.buf
			vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = buf, desc = "[G]oto [R]eferences" })
			-- vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
			vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = buf, desc = "[G]oto [D]efinition" })
			vim.keymap.set("n", "K", builtin.lsp_document_symbols, { buffer = buf, desc = "Open Document Symbols" })
		end,
	})
end

-- ============================================================
-- SECTION 6: LSP
-- ============================================================
do
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = function(event)
			local opts = { buffer = event.buf, silent = true }

			opts.desc = "Smart rename"
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Show line diagnostics"
			vim.keymap.set("n", "<space>d", vim.diagnostic.open_float, opts)

			opts.desc = "Go to previous diagnostic"
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

			opts.desc = "Go to next diagnostic"
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

			opts.desc = "Show documentation for what is under cursor"
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

			opts.desc = "Restart LSP"
			vim.keymap.set("n", "<space>rs", ":LspRestart<CR>", { buffer = event.buf, noremap = true })

			opts.desc = "Fix Error"
			vim.keymap.set("n", "<space>fx", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

			opts.desc = "Format the whole file"
			vim.keymap.set("n", "<space><space>f", function()
				vim.lsp.buf.format({ async = true })
			end, opts)

			opts.desc = "Format selected text"
			vim.keymap.set("x", "<space>f", function()
				local data = {
					start = vim.fn.line("'<"),
					["end"] = vim.fn.line("'>"),
				}
				vim.lsp.buf.format({ range = data, async = true })
			end, { buffer = event.buf, silent = true })

			vim.keymap.set("n", "<space>f", function()
				vim.cmd("normal vip")
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<space>f", true, false, true), "x", false)
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
			end, { buffer = event.buf })

			-- The following two autocommands are used to highlight references of the
			-- word under your cursor when your cursor rests there for a little while.
			--    See `:help CursorHold` for information about when this is executed
			--
			-- When you move your cursor, the highlights will be cleared (the second autocommand).
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client:supports_method("textDocument/documentHighlight", event.buf) then
				local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
					end,
				})
			end

			-- The following code creates a keymap to toggle inlay hints in your
			-- code, if the language server you are using supports them
			--
			-- This may be unwanted, since they displace some of your code
			if client and client:supports_method("textDocument/inlayHint", event.buf) then
				vim.keymap.set("n", "<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
				end, { buffer = event.buf, desc = "[T]oggle Inlay [H]ints" })
			end
		end,
	})

	-- Enable the following language servers
	--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
	--  See `:help lsp-config` for information about keys and how to configure
	local servers = {
		clangd = {
			cmd = { "clangd" },
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			handlers = {
				["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
					if result.diagnostics then
						result.diagnostics = vim.tbl_filter(function(d)
							return d.severity == vim.diagnostic.severity.ERROR
						end, result.diagnostics)
					end
					vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
				end,
			},
		},
		stylua = {},
		lua_ls = {
			on_init = function(client)
				client.server_capabilities.documentFormattingProvider = false
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end
				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
					workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
				})
			end,
			settings = { Lua = { format = { enable = false } } },
		},
	}

	vim.pack.add({
		gh("neovim/nvim-lspconfig"),
		gh("mason-org/mason.nvim"),
		gh("mason-org/mason-lspconfig.nvim"),
		gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
	})

	require("mason").setup({})
	require("mason-tool-installer").setup({ ensure_installed = vim.tbl_keys(servers) })

	for name, server in pairs(servers) do
		vim.lsp.config(name, server)
		vim.lsp.enable(name)
	end
end

vim.pack.add({ { src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("2.*") } })

vim.pack.add({ gh("rafamadriz/friendly-snippets") })

local ls = require("luasnip")
ls.setup({})

require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "cpp", "vue" } })
require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/.lua_snippet" })

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
	snippetDir = "~/.config/nvim/.lua_snippet",
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

require("kickstart.cpp_lsp")
require("kickstart.outline")
require("kickstart.file-tree")
require("kickstart.hop")
require("kickstart.statusline")
require("kickstart.terminal")

vim.pack.add({ "https://github.com/tpope/vim-fugitive" })
vim.keymap.set("n", "<tab><tab>l", "3X", { noremap = true, silent = true })
vim.keymap.set("n", "<tab><tab>h", "2X", { noremap = true, silent = true })
vim.api.nvim_create_autocmd("CmdlineEnter", {
	pattern = ":Git",
	callback = function()
		vim.cmd("silent! LspStop")
	end,
})

--------------------- MINI -------------------

vim.pack.add({ gh("echasnovski/mini.nvim") })

require("mini.indentscope").setup({
	-- symbol = '│',
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
vim.keymap.set("n", "si", "sai", { silent = true, remap = true })
vim.keymap.set("x", "q", "sa'", { silent = true, remap = true })
vim.keymap.set("x", "Q", 'sa"', { silent = true, remap = true })
vim.keymap.set("x", "'", "sa'", { silent = true, remap = true })
vim.keymap.set("x", '"', 'sa"', { silent = true, remap = true })
vim.keymap.set("x", "(", "sa)", { silent = true, remap = true })
vim.keymap.set("x", ")", "sa)", { silent = true, remap = true })
vim.keymap.set("x", "}", "sa}", { silent = true, remap = true })
vim.keymap.set("x", "{", "sa}", { silent = true, remap = true })
vim.keymap.set("x", "]", "sa]", { silent = true, remap = true })
vim.keymap.set("x", "[", "sa]", { silent = true, remap = true })
vim.keymap.set("x", "`", "sa`", { silent = true, remap = true })

require("mini.move").setup({
	mappings = {
		line_left = "<S-left>",
		line_right = "<S-right>",
		line_down = "<S-down>",
		line_up = "<S-up>",
	},
})
