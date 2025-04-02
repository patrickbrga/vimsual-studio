local B = require("config.bindings")

return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = { "lua-language-server", "netcoredbg" }
        },
        config = function(_, opts)
            require("mason").setup(opts)
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls" }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lsp.configs.lua_ls").setup()

            B.Lsp()
        end,
    }
}
