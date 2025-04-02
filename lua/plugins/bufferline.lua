local B = require("config.bindings")
local I = require("utils.icons")

local function is_ft(b, ft)
    return vim.bo[b].filetype == ft
end

local function custom_filter(buf, buf_nums)
    local logs = vim.tbl_filter(function(b)
        return is_ft(b, "log")
    end, buf_nums or {})
    if vim.tbl_isempty(logs) then
        return true
    end
    local tab_num = vim.fn.tabpagenr()
    local last_tab = vim.fn.tabpagenr "$"
    local is_log = is_ft(buf, "log")
    if last_tab == 1 then
        return true
    end

    return (tab_num == last_tab and is_log) or (tab_num ~= last_tab and not is_log)
end

local function diagnostics_indicator(_, _, diagnostics, _)
    local result = {}
    local symbols = {
        error = I.diagnostic.error,
        warning = I.diagnostic.warning,
        info = I.diagnostic.information,
    }

    for name, count in pairs(diagnostics) do
        if symbols[name] and count > 0 then
            table.insert(result, symbols[name] .. " " .. count)
        end
    end

    result = table.concat(result, " ")
    return #result > 0 and result or ""
end

return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers",
                themable = true,
                diagnostics = "nvim_lsp",
                diagnostics_indicator = diagnostics_indicator,
                custom_filter = custom_filter,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "   File Exporer",
                        text_align = "center",
                        separator = true
                    }
                },
                color_icons = true,
                show_buffer_icons = true,
                show_buffer_close_icons = true,
                show_close_icon = true,
                show_tab_indicators = true,
                groups = {
                    items = {
                        require("bufferline.groups").builtin.pinned:with({ icon = " " .. I.ui.Pin })
                    }
                }
            },
            highlights = {
                buffer_selected = {
                    bold = true,
                    italic = true,
                },
            }
        })

        B.Tabs();
    end
}
