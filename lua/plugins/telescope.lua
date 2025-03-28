local U = require("config.ui")

return {
  {
    'nvim-telescope/telescope.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-lua/plenary.nvim', "nvim-lua/popup.nvim" },
    config = function()
      local telescope = require("telescope.builtin")

      vim.keymap.set("n", "<C-p>", telescope.find_files, { desc = 'Find Files', noremap = true, silent = true })
      vim.keymap.set("n", "<C-F>", telescope.live_grep, { desc = 'Search in files', noremap = true, silent = true })
    end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    event = "VeryLazy",
    config = function()
      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,

            }
          }
        },
        extensions_list = { "themes", "terms" },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      })
      require("telescope").load_extension("ui-select")

      U.Telescope()
    end
  }
}
