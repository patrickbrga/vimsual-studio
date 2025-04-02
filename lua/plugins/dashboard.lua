local I = require("utils.icons")

-- TODO: Crir menu bonitinho do Vimsual Studio 😂

return {
    "goolord/alpha-nvim",
    enabled = not vim.g.is_perf,
    event = "VimEnter", -- load plugin after all configuration is set
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                     ]],
            [[       ████ ██████           █████      ██                     ]],
            [[      ███████████             █████                             ]],
            [[      █████████ ███████████████████ ███   ███████████   ]],
            [[     █████████  ███    █████████████ █████ ██████████████   ]],
            [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
            [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
            [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
        }

        _Gopts = {
            position = "center",
            hl = "Type",
        }

        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("e", "   File Explorer", ":NvimTreeToggle<CR>"),
            -- dashboard.button("c", "   Config", ":e $MYVIMRC <CR>"),
            dashboard.button("m", "󱌣   Mason", ":Mason<CR>"),
            dashboard.button("l", "󰒲   Lazy", ":Lazy<CR>"),
            dashboard.button("u", "󰂖   Update plugins", "<cmd>lua require('lazy').sync()<CR>"),
            dashboard.button("q", "󰩈   Quit NVIM", ":qa<CR>")
        }

        dashboard.opts.opts.noautocmd = true
        alpha.setup(dashboard.opts)

        require('alpha').setup(dashboard.opts)

        vim.api.nvim_create_autocmd('User', {
            pattern = 'LazyVimStarted',
            callback = function()
                local stats = require('lazy').stats()
                local count = (math.floor(stats.startuptime * 100) / 100)

                dashboard.section.footer.val = {
                    "󱐌 " .. stats.count .. " plugins loaded in " .. count .. " ms",
                }
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}
