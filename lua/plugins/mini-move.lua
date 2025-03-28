return {
  'echasnovski/mini.move',
  version = false,
  event = "BufRead",
  config = function()
    require("mini.move").setup({
      mappings = {
        down = '<A-Down>',
        up = '<A-Up>',
        line_down = '<A-Down>',
        line_up = '<A-Up>',
        line_left = '',
      },
    })
  end
}
