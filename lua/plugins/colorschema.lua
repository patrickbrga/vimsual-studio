return {
    { "folke/tokyonight.nvim",     priority = 1000 },
    { "tiagovla/tokyodark.nvim",   priority = 1000 },
    { "olimorris/onedarkpro.nvim", priority = 1000 },
    { "rebelot/kanagawa.nvim",     priority = 1000 },
    { "samharju/synthweave.nvim",  priority = 1000 },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({ background = { dark = "mocha" } })
        end
    },
    {
        "AlexvZyl/nordic.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require('nordic').load({
                cursorline = {
                    theme = "dark",
                },
                telescope = {
                    style = "classic",
                },
            })
        end
    },
}
