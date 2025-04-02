local B = require("config.bindings")
local U = require("config.ui")
local S = require("utils.state")

local function open_debug(dapui)
    require('nvim-tree.api').tree.close()
    S.ToggleDebbuging()
    dapui.open()
end

local function close_debug(dapui)
    S.ToggleDebbuging()
    dapui.close()
end

return {
    "mfussenegger/nvim-dap",
    enabled = true,
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dap.set_log_level("TRACE")

        dap.listeners.before.attach.dapui_config = function() open_debug(dapui) end
        dap.listeners.before.launch.dapui_config = function() open_debug(dapui) end
        dap.listeners.before.event_terminated.dapui_config = function() close_debug(dapui) end
        dap.listeners.before.event_exited.dapui_config = function() close_debug(dapui) end

        B.Debug(dap, dapui)

        require("dap.lua").register_lua_dap()
        require("dap.netcore").register_net_dap()

        U.Dap()
    end,
    dependencies = {
        { "jbyuki/one-small-step-for-vimkind" },
        { "nvim-neotest/nvim-nio" },
        {
            "rcarriga/nvim-dap-ui",
            config = function()
                require("dapui").setup({
                    icons = { expanded = "", collapsed = "", current_frame = "" },
                    mappings = {
                        expand = { "<CR>", "<2-LeftMouse>" },
                        open = "o",
                        remove = "d",
                        edit = "e",
                        repl = "r",
                        toggle = "t",
                    },
                    element_mappings = {},
                    expand_lines = true,
                    force_buffers = true,
                    layouts = {
                        {
                            elements = {
                                "scopes",
                                "breakpoints",
                                "stacks",
                                "watches",
                            },
                            size = 45,
                            position = "right",
                        },
                        {
                            elements = {
                                "repl"
                            },
                            size = 1,
                            position = "bottom",
                        },
                    },
                    floating = {
                        border = "single",
                        mappings = {
                            ["close"] = { "q", "<Esc>" },
                        },
                    },
                    controls = {
                        enabled = true,
                        element = "repl",
                        icons = {
                            pause = "",
                            play = "",
                            step_into = "",
                            step_over = "",
                            step_out = "",
                            step_back = "",
                            run_last = "",
                            terminate = "",
                            disconnect = "",
                        },
                    },
                    render = {
                        max_type_length = nil,
                        max_value_lines = 100,
                        indent = 1,
                    },
                })
            end
        },
        {
            "theHamsta/nvim-dap-virtual-text",
            config = function()
                require("nvim-dap-virtual-text").setup({
                    enabled = true,
                    enabled_commands = true,
                    highlight_changed_variables = true,
                    highlight_new_as_changed = false,
                    show_stop_reason = true,
                    commented = false,
                    only_first_definition = true,
                    all_references = false,
                    clear_on_continue = false,
                    display_callback = function(variable, buf, stackframe, node, options)
                        if options.virt_text_pos == 'inline' then
                            return ' = ' .. variable.value
                        else
                            return variable.name .. ' = ' .. variable.value
                        end
                    end,
                    virt_text_pos = 'eol',
                    all_frames = false,
                    virt_lines = false,
                    virt_text_win_col = nil,
                })
            end

        }
    }
}
