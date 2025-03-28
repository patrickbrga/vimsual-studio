local B = require("config.bindings")

return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({ shell = "pwsh" })

    B.Terminal()
  end,
}
