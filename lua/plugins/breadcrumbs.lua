return {
  {
    'Bekaboo/dropbar.nvim',
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
    config = function()
      require("dropbar").setup({
        menu = {
          preview = false
        }
      })
    end
  },
}
