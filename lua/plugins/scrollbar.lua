local colors = require("catppuccin.palettes").get_palette()

return {
    'petertriho/nvim-scrollbar',
    event = "BufRead",
    config = function()
        require('scrollbar').setup({
            show = true,
            show_in_active_only = true,
            set_highlights = true,
            handle = {
                text = " ",
                color = colors.overlay0,
                cterm = nil,
                highlight = "CursorColumn",
                hide_if_all_visible = true
            },
            autocmd = {
                render = {
                    "BufWinEnter",
                    "TabEnter",
                    "TermEnter",
                    "WinEnter",
                    "CmdwinLeave",
                    "VimResized",
                    "WinScrolled",
                },
            },
            handlers = {
                diagnostic = true,
                search = true
            },
        })
    end
}
