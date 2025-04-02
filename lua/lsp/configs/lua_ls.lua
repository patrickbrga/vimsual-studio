local lua_ls = {}

function lua_ls.setup()
    local lspconfig = require("lspconfig")
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local runtime_path = vim.split(package.path, ';')

    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    lspconfig.lua_ls.setup({
        cmd = { "lua-language-server.cmd", "--stdio" },
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = runtime_path
                },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = {
                        vim.env.VIMRUNTIME,
                        vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "easy-dotnet.nvim"),
                        vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "code-playground.nvim"),
                        vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "telescope.nvim"),
                    },
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })
end

return lua_ls
