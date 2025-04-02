return {
    {
        "nvzone/menu",
        dependencies = { "nvzone/volt" },
        config = function()
            vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
                require('menu.utils').delete_old_menus()

                vim.cmd.exec '"normal! \\<RightMouse>"'

                local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
                local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

                -- TODO: Criar menus personalizados
                -- TODO: Conseguir identificar se é da Lib do Bufferline

                require("menu").open(options, { mouse = true })
            end, {})
        end
    },
}
