return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
        require("tiny-inline-diagnostic").setup({
            preset = "powerline",
            options = {
                show_source = true,
                enable_on_insert = true,
                multilines = {
                    enabled = true,
                    always_show = true,
                },
                overflow = {
                    mode = "wrap",
                    padding = 0,
                },
                break_line = { enabled = true },
                virt_texts = {
                    priority = 2048,
                },
                severity = {
                    vim.diagnostic.severity.ERROR,
                    vim.diagnostic.severity.WARN,
                    vim.diagnostic.severity.INFO,
                    vim.diagnostic.severity.HINT,
                },
                overwrite_events = nil,
            },
            disabled_ft = {},
        })
    end
}
