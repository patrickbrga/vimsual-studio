local I = require("utils.icons")

-- Set leader to <space>
vim.g.mapleader = " "

-- Enable mouse
vim.opt.mouse = "a"

-- Enable smart indenting
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.breakindent = true
vim.opt.showtabline = 4

-- Set tabs to 2 spaces
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.fillchars = {
  eob = " ",
  diff = "-",
  fold = " ",
  foldopen = I.ui.ChevronShortDown,
  foldsep = " ",
  foldclose = I.ui.ChevronShortRight
}

-- Show relative numbers
vim.opt.relativenumber = false
vim.opt.number = true

-- Highlight current line
vim.opt.cursorline = true

-- Define Shell
vim.opt.shell = "pwsh"
vim.o.shellcmdflag =
"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"

-- Setting shell redirection
vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'

-- Setting shell pipe
vim.o.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'

-- Setting shell quote options
vim.o.shellquote = ""
vim.o.shellxquote = ""

-- Fold options
vim.o.foldcolumn = 'auto'
-- vim.o.foldlevel = 1
-- vim.o.foldlevelstart = 99
-- vim.o.foldenable = true

-- Diagnostics
vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
})

vim.opt.termguicolors = true

vim.opt.background = "dark"
