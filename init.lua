-- Minimal Neovim config

-- ============================================================
-- SECTION 1: OPTIONS
-- Core Neovim settings, leaders, options, basic keymaps, basic autocmds
-- ============================================================
do
	vim.loader.enable()
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "
	vim.g.have_nerd_font = true

    vim.o.termguicolors = true
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
	vim.o.confirm = true

	vim.o.wrap = false

  vim.opt.tabstop = 4      -- Number of spaces that a <Tab> in the file counts for
  vim.opt.shiftwidth = 4   -- Size of an indent
  vim.opt.softtabstop = 4  -- Number of spaces that a <Tab> counts for while performing editing operations
  vim.opt.expandtab = true -- Convert tabs to spaces
end

require("kickstart.keymaps")


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

vim.pack.add({ gh("echasnovski/mini.nvim") })

require("kickstart.cpp_lsp")
require("kickstart.outline")
require("kickstart.file-tree")
require("kickstart.hop")
require("kickstart.statusline")
require("kickstart.terminal")
require("kickstart.markdown")

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

require("kickstart.theme")
