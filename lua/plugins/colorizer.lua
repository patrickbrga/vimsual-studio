return {
  "norcalli/nvim-colorizer.lua",
  enabled = not vim.g.is_perf,
  event = "BufRead",
  config = function()
    require("colorizer").setup({ "*" }, {
      names = false,
      mode  = 'background',
    })
  end
}
