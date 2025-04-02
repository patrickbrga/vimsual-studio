local colors = require("catppuccin.palettes").get_palette()

local Ui = {}

local function Apply(mappings)
    for hl, col in pairs(mappings) do
        vim.api.nvim_set_hl(0, hl, col)
    end
end

local CreateSign = vim.fn.sign_define

function Ui.Telescope()
    Apply({
        TelescopeMatching = { fg = colors.flamingo },
        TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
        TelescopePromptPrefix = { bg = colors.surface0 },
        TelescopePromptNormal = { bg = colors.surface0 },
        TelescopeResultsNormal = { bg = colors.mantle },
        TelescopePreviewNormal = { bg = colors.mantle },
        TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
        TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
        TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
        TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
        TelescopeResultsTitle = { fg = colors.mantle },
        TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
    })
end

function Ui.Noice()
    Apply({
        NoiceCmdlinePopup = { bg = colors.surface0 },
        NoiceCmdlinePopupTitle = { bg = colors.red, fg = colors.mantle },
    })
end

function Ui.Dap()
    CreateSign('DapBreakpoint',
        { text = ' ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    CreateSign('DapBreakpointCondition',
        {
            text = ' ',
            texthl = 'DapBreakpointCondition',
            linehl = 'DapBreakpointCondition',
            numhl =
            'DapBreakpointCondition'
        })
    CreateSign('DapBreakpointRejected',
        {
            text = ' ',
            texthl = 'DapBreakpointRejected',
            linehl = 'DapBreakpointRejected',
            numhl =
            'DapBreakpointRejected'
        })
    CreateSign('DapStopped', { text = '󰳟 ', texthl = 'DapStopped', linehl = "DapStopped", numhl = 'DapStopped' })

    Apply({
        DapStopped = { ctermbg = 0, bg = colors.yellow, fg = colors.mantle },
        DapBreakpoint = { ctermbg = 0, bg = colors.red, fg = colors.text },
        DapBreakpointCondition = { ctermbg = 0, bg = colors.red, fg = colors.text },
        DapBreakpointRejected = { ctermbg = 0, bg = colors.red, fg = colors.text }
    })
end

return Ui
