local context_char = "│"
local char = "┆"

return {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    main = "ibl",
    config = function()
        require("ibl").setup({
            exclude = {
                filetypes = { "NvimTree", "startify", "dashboard", "help", "markdown" },
            },
            scope = {
                enabled = true,
                show_start = false,
                show_end = false,
                char = { context_char },
            },
            indent = {
                char = { char },
            },
        })
    end
}
