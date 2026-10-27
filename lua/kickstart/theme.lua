-- ============================================================================
-- Plugins
-- ============================================================================

vim.pack.add({
    {
        src = "https://github.com/sainnhe/gruvbox-material",
    },
})


-- ============================================================================
-- Gruvbox Material
-- ============================================================================

vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_invert_selection = 0

function GodMod()
    vim.cmd("hi clear")

    local bg = "#000000"
    local fg = "#00ff00"

    for hl_group, attrs in pairs(vim.api.nvim_get_hl(0, {})) do
        if attrs.fg then
            attrs.fg = fg
        end

        if attrs.bg then
            attrs.bg = bg
        end

        vim.api.nvim_set_hl(0, hl_group, attrs)
    end

    vim.api.nvim_set_hl(0, "Visual", {
        bg = "#222222",
    })

    vim.api.nvim_set_hl(0, "CursorLine", {
        bg = "#002200",
    })

    vim.api.nvim_set_hl(0, "Search", {
        fg = "#00ffff",
        bg = "none",
    })

    vim.api.nvim_set_hl(0, "CurSearch", {
        fg = "#00ffff",
        bg = "none",
    })

    vim.api.nvim_set_hl(0, "IncSearch", {
        fg = "#00ffff",
        bg = "none",
    })
end


function MyGruv1()
    vim.cmd.colorscheme("gruvbox-material")

    vim.cmd([[
        highlight CurrentWord guifg=#51a0cf guibg=none
        hi Normal guibg=#121212
        hi NormalFloat guibg=none
        hi SnacksPickerMatch guifg=#00ffff guibg=none gui=bold
        hi MiniIndentscopeSymbol guifg=#7daea3 gui=bold

        hi NvimTreeCursorLine guibg=#003a00 gui=bold guifg=#ffffff
        hi NvimTreeNormal guibg=none
        hi NvimTreeNormalNr guibg=none
        hi NvimTreeNormalNC guibg=none
        hi NvimTreeEndOfBuffer guibg=none
        hi NvimTreeModifiedFileHL guibg=#ea6962 guifg=#ffffff

        hi FloatBorder guifg=#e18249 guibg=none
        hi SignColumn gui=NONE guibg=NONE
        hi GitGutterAdd gui=NONE
        hi GitGutterChange gui=NONE
        hi GitGutterDelete gui=NONE
        hi Pmenu guibg=none

        hi Search guifg=#00ffff guibg=none
        hi CurSearch guifg=#00ffff guibg=none
        hi IncSearch guifg=#00ffff guibg=none

        hi MatchParen guibg=none guifg=#00ffff

        hi HopCursor guibg=#002f84 guifg=#ffffff
        hi HopNextKey guibg=#002f84 guifg=#ffffff
        hi HopPreview guibg=#002f84 guifg=#ffffff
        hi HopNextKey1 guibg=#002f84 guifg=#ffffff
        hi HopNextKey2 guibg=#002f84 guifg=#ffffff
        hi HopUnMatched guifg=none gui=none

        hi NormalNC guibg=#1e1e1e
        hi Fg guibg=none

        hi CursorLineNr guibg=#2b3447 guifg=#ffaa2d
        hi CursorLine guibg=#2b3447
        hi ColorColumn guibg=#2b3447

        hi @keyword.operator.cpp guifg=#569cd6
        hi @function.cpp guifg=#a9b665
        hi @string.cpp guifg=#a9b665 gui=italic
        hi @type.builtin.cpp guifg=#ea6962
        hi @variable.builtin.cpp guifg=#ea6962
        hi @variable.bad guifg=#ea6962 guibg=#ffffff
        hi @boolean.cpp guifg=#ea6962
        hi @punctuation.bracket.cpp guifg=#e18249 gui=none
        hi @keyword.conditional.cpp guifg=#d8a0df
        hi @keyword.terminator.cpp guifg=#d8a0df
        hi @type.cpp guifg=#7daea3
        hi @qtclass guifg=#7daea3

        hi link @property.cpp Fg

        hi VimwikiCode guifg=#ffaa2d guibg=#0f0f0f
        hi ClapFuzzyMatches guifg=#00ffff guibg=none
        hi TelescopeMatching guifg=#00ffff guibg=none
        hi CmpItemAbbrMatchFuzzy guifg=#00ffff guibg=none

        hi OutlineCurrent guibg=#003a00 gui=bold guifg=#ffffff

        hi DiffText guibg=#002f84 guifg=#ffffff
        hi DiffDelete guifg=#4b0618 guibg=#4b0618
        hi DiffChange guibg=none guifg=none
        hi DiffAdd guibg=#002f84 gui=bold guifg=none

        hi BufferInActive guibg=#2b3447
        hi BufferVisible guibg=#002977 guifg=#ffffff
        hi BufferCurrent guibg=#002977 guifg=#ffaa2d
        hi BufferCurrentIcon guibg=#002977 guifg=#ffffff
        hi BufferCurrentMod guibg=#002977 guifg=#ffffff
        hi BufferInactiveMod guibg=#4e020f guifg=#ffffff

        hi Folded guifg=#006000 guibg=none
        hi FoldColumn guifg=#006000 guibg=none

        hi MiniPickMatchRanges guibg=none guifg=#00ffff
    ]])
end


-- Use MyGruv1
MyGruv1()

