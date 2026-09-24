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
    muted     = "#a6adc8",
    muted_dim = "#939ab7",
    dark      = "#0b0b12",
    selection = "#313244",
    subtle    = "#1e1e2e",
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
                set_hl("LineNr", { fg = colors.muted_dim })
                set_hl("CursorLineNr", { fg = colors.accent, bold = true })
                set_hl("Visual", { bg = colors.selection })
                set_hl("Search", { fg = colors.bg, bg = colors.primary })
                set_hl("Directory", { fg = colors.primary, bold = true })

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

                -- Syntax — high contrast for coders, no dim gray
                set_hl("Comment", { fg = "#a6adc8", italic = false })
                set_hl("Keyword", { fg = colors.accent, bold = true })
                set_hl("Function", { fg = "#89b4fa", bold = true })
                set_hl("String", { fg = "#a6e3a1" })
                set_hl("Constant", { fg = "#f9e2af" })
                set_hl("Number", { fg = "#fab387" })
                set_hl("Type", { fg = "#89b4fa", bold = true })
                set_hl("Operator", { fg = "#94e2d5" })
                set_hl("Identifier", { fg = "#cdd6f4" })
                set_hl("Statement", { fg = "#cba6f7", bold = true })

                -- Pmenu (Completions)
                set_hl("Pmenu", { fg = colors.fg, bg = colors.dark })
                set_hl("PmenuSel", { fg = colors.bg, bg = colors.accent }) -- Purple selection

                -- Diagnostics — bright, not gray
                set_hl("DiagnosticError", { fg = "#f38ba8", bold = true })
                set_hl("DiagnosticWarn", { fg = "#f9e2af", bold = true })
                set_hl("DiagnosticInfo", { fg = "#89b4fa" })
                set_hl("DiagnosticHint", { fg = "#94e2d5" })

                -- Treesitter — vivid
                set_hl("@variable", { fg = "#cdd6f4" })
                set_hl("@property", { fg = "#89b4fa" })
                set_hl("@parameter", { fg = "#fab387", italic = false })
                set_hl("@constructor", { fg = "#cba6f7", bold = true })
                set_hl("@tag", { fg = "#cba6f7", bold = true })
                set_hl("@tag.delimiter", { fg = "#a6adc8" })
                set_hl("@comment", { fg = "#a6adc8" })
                set_hl("NonText", { fg = "#939ab7" })

                vim.g.colors_name = "omarchy"
            end,
        },
    },
}

return M
