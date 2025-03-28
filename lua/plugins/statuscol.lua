return {
  "luukvbaal/statuscol.nvim",
  lazy = false,
  config = function()
    local builtin = require("statuscol.builtin")

    require("statuscol").setup({
      segments = {
        {
          sign = { namespace = { "diagnostic" }, name = { "Dap*" }, maxwidth = 1, colwidth = 1, auto = true },
          click = "v:lua.ScSa"
        },
        { text = { builtin.lnumfunc },           click = "v:lua.ScLa" },
        { sign = { namespace = { "gitsign*" } }, click = "v:lua.ScSa" },
        { text = { builtin.foldfunc, " " },      click = "v:lua.ScFa" },
      }
    })
  end
}
