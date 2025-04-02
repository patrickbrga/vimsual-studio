return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        enabled = not vim.g.is_perf,
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            }
        },
    },
    {
        "Bilal2453/luvit-meta",
        enabled = not vim.g.is_perf,
        lazy = true
    },
}
