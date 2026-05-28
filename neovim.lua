local M = {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = function()
                vim.cmd("set termguicolors")

local colors = {
    bg        = "#11111b",
    fg        = "#cdd6f4",
    border    = "#cba6f7",
    primary   = "#cba6f7",
    secondary = "#c4a0f0",
    accent    = "#cba6f7",
    purple    = "#cba6f7",
    danger    = "#f5c2e7",
    warning   = "#c4a0f0",
    info      = "#b4befe",
    muted     = "#6c7086",
    dark      = "#0b0b12",
    selection = "#313244",
    subtle    = "#181825",
}

                vim.cmd("highlight clear")

                local function set_hl(group, opts)
                    vim.api.nvim_set_hl(0, group, opts)
                end

                -- Main UI
                set_hl("Normal", { fg = colors.fg, bg = colors.bg })
                set_hl("NormalNC", { fg = colors.fg, bg = colors.bg }) -- UPDATED: Prevents inactive windows (left panel) from dimming into the dark
                set_hl("NormalFloat", { fg = colors.fg, bg = colors.dark })
                set_hl("FloatBorder", { fg = colors.border, bg = colors.bg })
                set_hl("WinSeparator", { fg = colors.border }) -- Orange split lines
                set_hl("CursorLine", { bg = colors.subtle })   -- Uses subtle for a faint highlight
                set_hl("LineNr", { fg = colors.muted })
                set_hl("CursorLineNr", { fg = colors.accent, bold = true }) -- Pink current line
                set_hl("Visual", { bg = colors.selection })
                set_hl("Search", { fg = colors.bg, bg = colors.primary }) -- Blue search
                set_hl("Directory", { fg = colors.primary, bold = true }) -- Standard folders

                -- File Explorers (Neo-tree / NvimTree fixes for the circled area)
                set_hl("NeoTreeNormal", { fg = colors.fg, bg = colors.bg })
                set_hl("NeoTreeNormalNC", { fg = colors.fg, bg = colors.bg })
                set_hl("NeoTreeFileName", { fg = colors.fg })
                set_hl("NeoTreeDirectoryName", { fg = colors.primary, bold = true })
                set_hl("NeoTreeGitUntracked", { fg = colors.info })
                set_hl("NeoTreeGitModified", { fg = colors.warning })
                
                set_hl("NvimTreeNormal", { fg = colors.fg, bg = colors.bg })
                set_hl("NvimTreeNormalNC", { fg = colors.fg, bg = colors.bg })
                set_hl("NvimTreeNormalFile", { fg = colors.fg })
                set_hl("NvimTreeFolderName", { fg = colors.primary, bold = true })
                set_hl("NvimTreeOpenedFolderName", { fg = colors.primary, bold = true })

                -- Syntax (Matched to Omarchy Colors)
                set_hl("Comment", { fg = colors.muted, italic = true })
                set_hl("Keyword", { fg = colors.accent, bold = true }) -- Pink Keywords
                set_hl("Function", { fg = colors.primary, bold = true }) -- Blue Functions
                set_hl("String", { fg = colors.secondary }) -- Green Strings
                set_hl("Constant", { fg = colors.purple })
                set_hl("Number", { fg = colors.warning })
                set_hl("Type", { fg = colors.warning })
                set_hl("Operator", { fg = colors.info })
                set_hl("Identifier", { fg = colors.fg })
                set_hl("Statement", { fg = colors.accent })

                -- Pmenu (Completions)
                set_hl("Pmenu", { fg = colors.fg, bg = colors.dark })
                set_hl("PmenuSel", { fg = colors.bg, bg = colors.accent }) -- Purple selection

                -- Diagnostics
                set_hl("DiagnosticError", { fg = colors.danger })
                set_hl("DiagnosticWarn", { fg = colors.warning })
                set_hl("DiagnosticInfo", { fg = colors.info })
                set_hl("DiagnosticHint", { fg = colors.muted })

                -- Treesitter Links
                set_hl("@variable", { fg = colors.fg })
                set_hl("@property", { fg = colors.info })
                set_hl("@parameter", { fg = colors.warning, italic = true })
                set_hl("@constructor", { fg = colors.primary })
                set_hl("@tag", { fg = colors.accent })
                set_hl("@tag.delimiter", { fg = colors.muted })

                vim.g.colors_name = "omarchy"
            end,
        },
    },
}

return M
