local B = require("config.bindings")

return {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
        local dotnet = require("easy-dotnet")
        dotnet.setup({
            test_runner = {
                enable_buffer_test_execution = true,
                viewmode = "float",
            },
            auto_bootstrap_namespace = true,
            terminal = function(path, action, args)
                local commands = {
                    run = function()
                        return string.format("dotnet run --project %s %s", path, args)
                    end,
                    test = function()
                        return string.format("dotnet test %s %s", path, args)
                    end,
                    restore = function()
                        return string.format("dotnet restore %s %s", path, args)
                    end,
                    build = function()
                        return string.format("dotnet build %s %s", path, args)
                    end,
                }

                local command = commands[action]() .. "\r"
                require("toggleterm").exec(command, nil, nil, nil, "horizontal")
            end,
        })

        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                if dotnet.is_dotnet_project() then
                    B.Dotnet(dotnet)
                end
            end,
        })
    end,
}
