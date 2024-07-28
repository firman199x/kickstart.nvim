return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    ------------------------------------------------------------------------------

    require('mini.indentscope').setup {
      symbol = '│',
      draw = {
        animation = require('mini.indentscope').gen_animation.linear(),
      },
    }
    vim.cmd [[hi MiniIndentscopeSymbol guifg=#ffaa2d gui=bold]]

    ------------------------------------------------------------------------------

    require('mini.move').setup {
      mappings = {
        left = 'H',
        right = 'L',
        down = 'J',
        up = 'K',

        line_left = '<S-left>',
        line_right = '<S-right>',
        line_down = '<S-down>',
        line_up = '<S-up>',
      },
    }

    ------------------------------------------------------------------------------

    ------------------------------------------------------------------------------

    require('mini.cursorword').setup {
      delay = 250,
    }

    vim.cmd [[highlight MiniCursorword guifg=#00AFFF gui=bold]]
    vim.cmd [[highlight MiniCursorwordCurrent guifg=#00afff gui=bold]]

    ------------------------------------------------------------------------------

    require('mini.surround').setup()
    vim.keymap.set('n', 'si', 'sai', { silent = true, remap = true })
    vim.keymap.set('x', 'q', "sa'", { silent = true, remap = true })
    vim.keymap.set('x', 'Q', 'sa"', { silent = true, remap = true })
    vim.keymap.set('x', "'", "sa'", { silent = true, remap = true })
    vim.keymap.set('x', '"', 'sa"', { silent = true, remap = true })
    vim.keymap.set('x', '(', 'sa)', { silent = true, remap = true })
    vim.keymap.set('x', ')', 'sa)', { silent = true, remap = true })
    vim.keymap.set('x', '}', 'sa}', { silent = true, remap = true })
    vim.keymap.set('x', '{', 'sa}', { silent = true, remap = true })
    vim.keymap.set('x', ']', 'sa]', { silent = true, remap = true })
    vim.keymap.set('x', '[', 'sa]', { silent = true, remap = true })
    vim.keymap.set('x', '`', 'sa`', { silent = true, remap = true })

    ------------------------------------------------------------------------------
    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
