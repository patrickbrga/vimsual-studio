return {
  "RRethy/vim-illuminate",
  enabled = not vim.g.is_perf,
  config = function()
    require('illuminate').configure({
      providers = {
        'lsp',
        'treesitter',
        'regex',
      },
      delay = 100,
      filetype_overrides = {},
      filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
        "NvimTree",
        "alpha",
        "markdown",
        "TelescopePrompt",
        "DressingInput",
        "octo",
        "terminal"
      },
      filetypes_allowlist = {},
      modes_denylist = {},
      modes_allowlist = {},
      providers_regex_syntax_denylist = {},
      providers_regex_syntax_allowlist = {},
      under_cursor = true,
      large_file_cutoff = 1000,
      large_file_overrides = nil,
      min_count_to_highlight = 2,
      should_enable = function() return true end,
      case_insensitive_regex = false,
    })
  end
}
