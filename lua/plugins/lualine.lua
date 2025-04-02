local I = require("utils.icons")
local F = require("utils.functions")
local S = require("utils.state")
local colors = require("catppuccin.palettes").get_palette()

local function fmt_mode(s)
    local mode_map = {
        ["COMMAND"] = "COMMND",
        ["V-BLOCK"] = "V-BLCK",
        ["TERMINAL"] = "TERMNL",
        ["V-REPLACE"] = "V-RPLC",
        ["O-PENDING"] = "0PNDNG",
    }
    return mode_map[s] or s
end

local text_hl = { fg = colors.text }
local icon_hl = { fg = colors.subtext0 }

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

local default_z = {
    {
        "location",
        icon = { "", align = "left" },
        fmt = function(str)
            local fixed_width = 7
            return string.format("%" .. fixed_width .. "s", str)
        end,
    },
    {
        "progress",
        icon = { "", align = "left" },
        separator = { right = "", left = "" },
    },
}

local tree = {
    sections = {
        lualine_a = {
            {
                "mode",
                fmt = fmt_mode,
                icon = { "" },
                separator = { right = " ", left = "" },
            },
        },
        lualine_b = {},
        lualine_c = {
            {
                vim.fn.fnamemodify(vim.fn.getcwd(), ":~"),
                padding = 0,
                icon = { "   ", color = icon_hl },
                color = text_hl,
            },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = default_z,
    },
    filetypes = { "NvimTree" },
}

local telescope = {
    sections = {
        lualine_a = {
            {
                "mode",
                fmt = fmt_mode,
                icon = { "" },
                separator = { right = " ", left = "" },
            },
        },
        lualine_b = {},
        lualine_c = {
            {
                function() return "Telescope" end,
                color = text_hl,
                icon = { "  ", color = icon_hl },
            },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = default_z,
    },
    filetypes = { "TelescopePrompt" },
}

return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = { "VeryLazy" },
    config = function()
        require("lualine").setup({
            sections = {
                lualine_a = {
                    {
                        "mode",
                        fmt = fmt_mode,
                        icon = { "" },
                        separator = { right = " ", left = "" },
                    },
                },
                lualine_b = {},
                lualine_c = {
                    {
                        "branch",
                        color = text_hl,
                        icon = { " ", color = icon_hl },
                        separator = "",
                        padding = 0,
                    },
                    {
                        "diff",
                        color = text_hl,
                        icon = { "  ", color = text_hl },
                        source = diff_source,
                        symbols = {
                            added = " ",
                            modified = " ",
                            removed = " ",
                        },
                        diff_color = {
                            added = icon_hl,
                            modified = icon_hl,
                            removed = icon_hl,
                        },
                        padding = 0,
                    },
                },
                lualine_x = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = {
                            error = I.diagnostic.error,
                            warn = I.diagnostic.warn,
                            info = I.diagnostic.info,
                            hint = I.diagnostic.hint,
                            other = I.diagnostic.other,
                        },
                        colored = true,
                        padding = 2,
                    },
                    {
                        F.CurrentBufferLsp,
                        padding = 1,
                        color = text_hl,
                        icon = { " ", color = icon_hl },
                    },
                    {
                        function() return " " end,
                        color = function()
                            if S.IsDebbuging then
                                return { fg = colors.red }
                            end
                            return icon_hl
                        end,
                        separator = { " ", "" },
                    },
                    {
                        function() return "󰉼  " end,
                        color = icon_hl,
                        padding = 0,
                    },
                },
                lualine_y = {},
                lualine_z = default_z,
            },
            options = {
                icons_enabled = true,
                disabled_filetypes = { "dashboard" },
                globalstatus = true,
                section_separators = { left = " ", right = " " },
                component_separators = { left = "", right = "" },
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            inactive_winbar = {},
            extensions = {
                telescope,
                ["nvim-tree"] = tree,
            },
        })

        vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
            callback = function(_) require("lualine").setup({}) end,
            pattern = { "*.*" },
            once = true,
        })

        vim.defer_fn(function() require("lualine").setup({}) end, 1)
    end,
}
