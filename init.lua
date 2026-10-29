-- Minimal Neovim config

-- ============================================================
-- SECTION 1: OPTIONS
-- Core Neovim settings, leaders, options, basic keymaps, basic autocmds
-- ============================================================
-- Disable a few unused built-in plugins to keep startup lean.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_tutor = 1

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

-- Consistent diagnostics presentation.
vim.diagnostic.config({
	virtual_text = { spacing = 2, prefix = "●" },
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = true },
})

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

require("kickstart.search")

require("kickstart.lsp")

require("kickstart.completion")

vim.pack.add({ gh("echasnovski/mini.nvim") })

-- Load filetype-specific modules lazily to keep startup lean.
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
	once = true,
	callback = function()
		require("kickstart.cpp_lsp")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	once = true,
	callback = function()
		require("kickstart.markdown")
	end,
})

require("kickstart.hop")
require("kickstart.statusline")
require("kickstart.mini")

-- Lazy-load heavier UI modules on first use.
vim.keymap.set("n", "<F3>", function()
	require("kickstart.outline")
	vim.cmd("Outline")
end, { desc = "Toggle Outline" })

vim.keymap.set("n", "<C-n>", function()
	require("kickstart.file-tree")
	vim.cmd("NvimTreeToggle")
end, { desc = "Toggle NvimTree" })

local load_terminal = function()
	require("kickstart.terminal")
end
vim.keymap.set("n", "<F10>", function()
	load_terminal()
	vim.cmd("ToggleTerm direction=horizontal size=15")
end, { desc = "Horizontal terminal" })
vim.keymap.set("n", "<C-b>", function()
	load_terminal()
	vim.cmd('TermExec cmd="wcompile"')
end, { desc = "Run wcompile" })
vim.api.nvim_create_user_command("VTerm", function()
	load_terminal()
	vim.cmd("ToggleTerm direction=vertical size=80")
end, {})
vim.api.nvim_create_user_command("HTerm", function()
	load_terminal()
	vim.cmd("ToggleTerm direction=horizontal size=80")
end, {})

require("kickstart.theme")
