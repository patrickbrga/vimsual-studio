return {
    "GustavEikaas/code-playground.nvim",
    enabled = not vim.g.is_perf,
    config = function()
        local playground = require("code-playground")
        playground.setup({
            split_direction = "split",
        })
    end,
}
