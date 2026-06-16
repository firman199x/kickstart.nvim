vim.pack.add { 'https://github.com/nvim-lualine/lualine.nvim' }
vim.pack.add { 'https://github.com/nvim-tree/nvim-web-devicons' }

local lualine = require 'lualine'

local colors = {
  blue = '#65D1FF',
  green = '#3EFFDC',
  violet = '#FF61EF',
  yellow = '#FFDA7B',
  red = '#FF4A4A',
  black = '#000000',
  fg = '#c3ccdc',
  bg = '#112638',
  inactive_bg = '#2c3043',
  semilightgray = '#808080',
}

local my_lualine_theme = {
  normal = {
    a = { bg = colors.blue, fg = colors.bg, gui = 'bold' },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  insert = {
    a = { bg = colors.green, fg = colors.bg, gui = 'bold' },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  visual = {
    a = { bg = colors.violet, fg = colors.bg, gui = 'bold' },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  command = {
    a = { bg = colors.yellow, fg = colors.bg, gui = 'bold' },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  replace = {
    a = { bg = colors.red, fg = colors.bg, gui = 'bold' },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  inactive = {
    a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = 'bold' },
    b = { bg = colors.inactive_bg, fg = colors.semilightgray },
    c = { bg = colors.inactive_bg, fg = colors.semilightgray },
  },
}

local function modified()
  if vim.bo.modified then
    return 'UNSAVED'
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return '-'
  end
  return ''
end

lualine.setup {
  options = {
    theme = my_lualine_theme,
  },
  sections = {
    lualine_x = {
      { 'filename', file_status = false, path = 0, color = { bg = '#008700' } },
      { 'encoding' },
      { 'fileformat' },
      { 'filetype' },
    },
    lualine_b = {
      { 'branch', color = { fg = colors.blue } },
    },
    lualine_c = {
      { 'filename', file_status = true, path = 1 },
      { modified, color = { bg = colors.red, fg = colors.black } },
    },
  },
}

vim.pack.add { 'https://github.com/romgrk/barbar.nvim' }
vim.g.barbar_auto_setup = false

function SmartClose()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  local wins = vim.api.nvim_tabpage_list_wins(0)

  if #wins > 1 then
    for _, win in ipairs(wins) do
      if win ~= current_win and vim.api.nvim_win_get_buf(win) == current_buf then
        vim.api.nvim_command('noautocmd q')
        return
      end
    end
  end

  local buffers = vim.api.nvim_tabpage_list_wins(0)
  local tab_count = vim.fn.tabpagenr('$')
  local ls_output = vim.fn.execute('ls')
  local _, buff_count = string.gsub(ls_output, '\n', '')

  if #buffers == 1 and tab_count == 1 and buff_count == 0 then
    vim.api.nvim_command('noautocmd q')
  elseif vim.bo[0].buftype == 'nofile' then
    vim.api.nvim_command('noautocmd q')
  else
    vim.api.nvim_command('noautocmd bdelete')
  end
end

function CloseAllExceptCurrentWindow()
  local current_win = vim.api.nvim_get_current_win()
  local all_wins = vim.api.nvim_list_wins()
  for _, win in ipairs(all_wins) do
    if win ~= current_win then
      vim.api.nvim_win_close(win, true)
    end
  end
  vim.cmd 'noautocmd BufferCloseAllButCurrent'
end

vim.keymap.set('n', '<C-Down>', '<cmd>BufferMovePrevious<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<C-Up>', '<cmd>BufferMoveNext<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<C-Left>', '<cmd>BufferPrevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', '<cmd>BufferNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'ZZ', ':lua SmartClose()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<space>xc', ':lua CloseAllExceptCurrentWindow()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<space>sd', ':noautocmd BufferCloseAllButVisible<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<BS>j', ':BufferGoto 1<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<BS>k', ':BufferGoto 2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<BS>l', ':BufferGoto 3<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<BS>;', ':BufferGoto 4<CR>', { noremap = true, silent = true })

require('barbar').setup {
  auto_hide = false,
  clickable = true,
  icons = {
    buffer_index = false,
    buffer_number = false,
    button = '',
    current = { button = '♻️ ' },
    filetype = { enabled = true },
    separator = { left = '|' },
    modified = { button = '💢' },
  },
}
