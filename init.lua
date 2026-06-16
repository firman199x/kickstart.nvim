-- Minimal Neovim config

-- ============================================================
-- SECTION 1: OPTIONS
-- Core Neovim settings, leaders, options, basic keymaps, basic autocmds
-- ============================================================
do
  vim.loader.enable()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  vim.g.have_nerd_font = false

  vim.o.number = true
  vim.o.mouse = 'a'
  vim.o.showmode = false
  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
  vim.o.breakindent = true
  vim.o.undofile = true
  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.signcolumn = 'yes'
  vim.o.updatetime = 250
  vim.o.timeoutlen = 300
  vim.o.splitright = true
  vim.o.splitbelow = true
  vim.o.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
  vim.o.inccommand = 'split'
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

  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
  vim.keymap.set('n', '<C-q>', ':qa<CR>', { silent = true })
  vim.keymap.set('n', '<F4>', '<C-^>', { silent = true })
  vim.keymap.set('n', '<BS>u', '<C-^>', { silent = true })
  vim.keymap.set('n', '<BS>m', '<C-^>', { silent = true })
  vim.keymap.set('n', '<C-m>', '<C-^>', { silent = true })
  vim.keymap.set('n', ']]', ']czz', { silent = true })
  vim.keymap.set('n', '[[', '[czz', { silent = true })

  vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })

  vim.keymap.set('n', '<space>H', '<C-w>H', { silent = true })
  vim.keymap.set('n', '<space>J', '<C-w>J', { silent = true })
  vim.keymap.set('n', '<space>K', '<C-w>K', { silent = true })
  vim.keymap.set('n', '<space>L', '<C-w>L', { silent = true })

  vim.keymap.set('n', '<space><space>l', 'gt', { silent = true })
  vim.keymap.set('n', '<space><space>h', 'gT', { silent = true })

  vim.keymap.set('n', '<A-h>', ':vertical resize +10<CR>', { silent = true })
  vim.keymap.set('n', '<A-l>', ':vertical resize -10<CR>', { silent = true })
  vim.keymap.set('n', '<A-k>', ':resize +10<CR>', { silent = true })
  vim.keymap.set('n', '<A-j>', ':resize -10<CR>', { silent = true })

  vim.keymap.set('n', '<C-o>', '<C-o>zz', { silent = true })
  vim.keymap.set('n', '<C-i>', '<C-i>zz', { silent = true })

  vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>O', { silent = true })
  vim.keymap.set('i', '{}<CR>', '{<CR>}<Esc>O', { silent = true })
  vim.keymap.set('i', '[]<CR>', '[<CR>]<Esc>O', { silent = true })
  vim.keymap.set('i', '()<CR>', '()<CR>)<Esc>O', { silent = true })

  vim.keymap.set('i', '()', '()<Space>', { silent = true })
  vim.keymap.set('i', '{}', '{}<Esc>ha', { silent = true })
  vim.keymap.set('i', '<>', '<><Esc>ha', { silent = true })
  vim.keymap.set('i', '[]', '[]<Esc>ha', { silent = true })
  vim.keymap.set('i', '""', '""<Esc>ha', { silent = true })
  vim.keymap.set('i', '","', '","', { silent = true })
  vim.keymap.set('i', "''", "''<Esc>ha", { silent = true })
  vim.keymap.set('i', "','", "','", { silent = true })

  vim.keymap.set('n', ';;', '$a;<Esc>', { silent = true })
  vim.keymap.set('i', ';;', '<Esc>$a;<Esc>', { silent = true })
  vim.keymap.set('i', ',,', '<Esc>$a,<Esc>', { silent = true })
  vim.keymap.set('n', ',,', '$a,<Esc>', { silent = true })

  vim.keymap.set('i', '()<CR>', '()<CR>', { silent = true })
  vim.keymap.set('i', '();', '();', { silent = true })
  vim.keymap.set('i', '():', '():', { silent = true })
  vim.keymap.set('i', '().', '().', { silent = true })

  vim.keymap.set('n', '<Space><BS>', [[:%s/\s\+$//e<CR>]], { silent = true })

  vim.keymap.set('v', '<Down>', '5j', { silent = true })
  vim.keymap.set('v', '<Up>', '5k', { silent = true })
  vim.keymap.set('n', '<Down>', '5j', { silent = true })
  vim.keymap.set('n', '<Up>', '5k', { silent = true })
  vim.keymap.set('n', '<Right>', 'W', { silent = true })
  vim.keymap.set('n', '<Left>', 'B', { silent = true })

  vim.keymap.set('n', '<A-n>', '<C-w>jj<CR>zz', { silent = true })
  vim.keymap.set('n', '<A-m>', '<C-w>jk<CR>zz', { silent = true })

  vim.keymap.set('x', 'p', [["_dP]], { silent = true })
  vim.keymap.set('x', '<space>F', [[:'<,'>!jq --indent 4 .<CR>]], { silent = true })
  vim.keymap.set('n', '<F1><F1>', [[:set list!<CR>]], { silent = true })
  vim.keymap.set('n', '<space><space>zf', 'va}zf', { silent = true })
  vim.keymap.set('x', '<space>sn', '}i$<esc>li:<esc>ih', { silent = true })
  vim.keymap.set('n', 'zl', '40zl', { silent = true })
  vim.keymap.set('n', 'zh', '40zh', { silent = true })
  vim.keymap.set('n', 'json', ':set filetype=json<CR>', { silent = true })
  vim.keymap.set('n', '<Del>', '<Nop>', { silent = true })
  vim.keymap.set('n', '<space>Z', 'vi}zf', { silent = true })

  vim.keymap.set('n', '<F5>', [[:let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>]], { silent = true })
  vim.keymap.set('x', '<F5>', [[:<C-u>let @/=getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]-1]<CR>:set hls<CR>]], { silent = true })
  vim.keymap.set('n', '<Space><Esc>', [[:set nohlsearch<CR>]], { silent = true })
  vim.keymap.set('n', '<Space><F5>', [[:set nohlsearch<CR>]], { silent = true })
  vim.keymap.set('n', '<Space><Space><Esc>', [[:match none | syntax off<CR>]], { silent = true })
  vim.keymap.set('x', '<C-f>', [[:silent! normal! gvy<CR>:lua require('telescope.builtin').grep_string { search = vim.fn.getreg('"') }<CR>]], { silent = true })
  function OpenFileLocation()
    local system = vim.loop.os_uname().sysname
    if system == 'Windows_NT' then
      vim.api.nvim_command 'silent !start explorer /select,%:p'
    elseif system == 'Linux' then
      vim.api.nvim_command 'silent !explorer.exe "$(wslpath -w "$(realpath %:p:h)")"'
    end
  end
  vim.keymap.set('n', '<space><space>n', ':lua OpenFileLocation()<cr>', { silent = true })

  -- Diagnostic Config & Keymaps
  --  See `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })
end

-- ============================================================
-- SECTION 3: PLUGIN MANAGER BUILD HOOKS
-- ============================================================
do

  local function run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
      local stderr = result.stderr or ''
      local stdout = result.stdout or ''
      local output = stderr ~= '' and stderr or stdout
      if output == '' then output = 'No output from build command.' end
      vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
    end
  end

  -- This autocommand runs after a plugin is installed or updated and
  --  runs the appropriate build command for that plugin if necessary.
  --
  -- See `:help vim.pack-events`
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
        run_build(name, { 'make' }, ev.data.path)
        return
      end

      if name == 'LuaSnip' then
        if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
        return
      end

      if name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
        vim.cmd 'TSUpdate'
        return
      end
    end,
  })
end

---Because most plugins are hosted on GitHub, you can use the helper
---function to have less repetition in the following sections.
---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

-- ============================================================
-- SECTION 4: UI / CORE UX PLUGINS
-- guess-indent, gitsigns, which-key, colorscheme, todo-comments, mini modules
-- ============================================================
do
  -- [[ Installing and Configuring Plugins ]]
  --
  -- To install a plugin simply call `vim.pack.add` with its git url.
  -- This will download the default branch of the plugin, which will usually be `main` or `master`
  -- You can also have more advanced specs, which we will talk about later.
  --
  -- For most plugins its not enough to install them, you also need to call their `.setup()` to start them.
  --
  -- Gitsigns: git signs in the gutter
  --
  -- See `:help gitsigns` to understand what each configuration key does.
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
  require('gitsigns').setup {
    signs = {
      add = { text = '+' }, ---@diagnostic disable-line: missing-fields
      change = { text = '~' }, ---@diagnostic disable-line: missing-fields
      delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
      topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
      changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    },
  }

  -- Useful plugin to show you pending keybinds.
  vim.pack.add { gh 'folke/which-key.nvim' }
  require('which-key').setup {
    -- Delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
      { 'gr', group = 'LSP Actions', mode = { 'n' } },
    },
  }

  -- [[ Colorscheme ]]
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command under that to load whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  vim.pack.add { gh 'folke/tokyonight.nvim' }
  ---@diagnostic disable-next-line: missing-fields
  require('tokyonight').setup {
    styles = {
      comments = { italic = false }, -- Disable italics in comments
    },
  }

  -- Load the colorscheme here.
  -- Like many other themes, this one has different styles, and you could load
  -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  vim.cmd.colorscheme 'tokyonight-night'
  -- [[ mini.nvim ]]
  --  A collection of various small independent plugins/modules
  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  -- If a nerd font is available, load the icons module for pretty icons in various plugins.
  if vim.g.have_nerd_font then
    require('mini.icons').setup()
    -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
    MiniIcons.mock_nvim_web_devicons()
  end

  -- Better Around/Inside textobjects
  --
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
  --  - ci'  - [C]hange [I]nside [']quote
  require('mini.ai').setup {
    -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  require('mini.surround').setup()

  -- Simple and easy statusline.
  --  You could remove this setup call if you don't like it,
  --  and try some other statusline plugin
  local statusline = require 'mini.statusline'
  -- Set `use_icons` to true if you have a Nerd Font
  statusline.setup { use_icons = vim.g.have_nerd_font }

  -- You can configure sections in the statusline by overriding their
  -- default behavior. For example, here we set the section for
  -- cursor location to LINE:COLUMN
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function() return '%2l:%-2v' end

  -- ... and there is more!
  --  Check out: https://github.com/nvim-mini/mini.nvim
end

-- ============================================================
-- SECTION 5: SEARCH & NAVIGATION
-- Telescope setup, keymaps, LSP picker mappings
-- ============================================================
do
  local telescope_plugins = {
    gh 'nvim-lua/plenary.nvim',
    gh 'nvim-telescope/telescope.nvim',
    gh 'nvim-telescope/telescope-ui-select.nvim',
  }
  if vim.fn.executable 'make' == 1 then table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim') end

  vim.pack.add(telescope_plugins)

  require('telescope').setup {
    extensions = {
      ['ui-select'] = { require('telescope.themes').get_dropdown() },
    },
  }
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')

  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = '[S]earch by [G]rep' })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
    callback = function(event)
      local buf = event.buf
      vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
      -- vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
      vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
      vim.keymap.set('n', 'K', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })
    end,
  })

  vim.keymap.set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
  end, { desc = '[S]earch [/] in Open Files' })

  vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config', follow = true } end, { desc = '[S]earch [N]eovim files' })
end

-- ============================================================
-- SECTION 6: LSP
-- ============================================================
do
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      local opts = { buffer = event.buf, silent = true }

      opts.desc = 'Smart rename'
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)

      opts.desc = 'Show line diagnostics'
      vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)

      opts.desc = 'Go to previous diagnostic'
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

      opts.desc = 'Go to next diagnostic'
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

      opts.desc = 'Show documentation for what is under cursor'
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

      opts.desc = 'Restart LSP'
      vim.keymap.set('n', '<space>rs', ':LspRestart<CR>', { buffer = event.buf, noremap = true })

      opts.desc = 'Fix Error'
      vim.keymap.set('n', '<space>fx', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

      opts.desc = 'Format the whole file'
      vim.keymap.set('n', '<space><space>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)

      opts.desc = 'Format selected text'
      vim.keymap.set('x', '<space>f', function()
        local data = {
          start = vim.fn.line("'<"),
          ["end"] = vim.fn.line("'>")
        }
        vim.lsp.buf.format { range = data, async = true }
      end, { buffer = event.buf, silent = true })

      vim.keymap.set('n', '<space>f', function()
        vim.cmd('normal vip')
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<space>f', true, false, true), 'x', false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
      end, { buffer = event.buf })

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method('textDocument/documentHighlight', event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- The following code creates a keymap to toggle inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client:supports_method('textDocument/inlayHint', event.buf) then
        map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --  See `:help lsp-config` for information about keys and how to configure
  local servers = {
    stylua = {},
    lua_ls = {
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
        end
        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = { version = 'LuaJIT', path = { 'lua/?.lua', 'lua/?/init.lua' } },
          workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file('', true) },
        })
      end,
      settings = { Lua = { format = { enable = false } } },
    },
  }

  vim.pack.add {
    gh 'neovim/nvim-lspconfig',
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  }

  require('mason').setup {}
  require('mason-tool-installer').setup { ensure_installed = vim.tbl_keys(servers) }

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

-- ============================================================
-- SECTION 7: FORMATTING
-- ============================================================
do
  vim.pack.add { gh 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = false,
    default_format_opts = { lsp_format = 'fallback' },
  }

  vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
end

-- ============================================================
-- SECTION 8: AUTOCOMPLETE & SNIPPETS
-- ============================================================
do
  vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
  require('luasnip').setup {}

  vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
  require('blink.cmp').setup {
    keymap = { preset = 'default' },
    appearance = { nerd_font_variant = 'mono' },
    completion = { documentation = { auto_show = false } },
    sources = { default = { 'lsp', 'path', 'snippets' } },
    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'lua' },
    signature = { enabled = true },
  }
end

-- ============================================================
-- SECTION 9: TREESITTER
-- Minimal setup: no auto-install, zero build errors
-- ============================================================
do
  vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match)
      if lang and pcall(vim.treesitter.start, args.buf, lang) then
        local ok, has_indent = pcall(vim.treesitter.query.get, lang, 'indents')
        if ok and has_indent then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end
    end,
  })
end
