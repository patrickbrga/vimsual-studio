return {
    {
        'Bekaboo/dropbar.nvim',
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
        event = "VeryLazy",
        config = function()
            require("dropbar").setup({
                menu = {
                    preview = false
                }
            })
        end
    },
}
