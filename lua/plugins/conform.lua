return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup {
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                -- cs = { "csharpier" },
            },
        }
        vim.keymap.set("n", "<leader>fm", require("conform").format, {})
    end,
}
