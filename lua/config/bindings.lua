local noremap_opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", noremap_opts)
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>", noremap_opts)
vim.api.nvim_set_keymap('v', '<C-c>', 'y', noremap_opts)

local B = {}

function B.Lsp()
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

  vim.keymap.set("n", "<C-F12>", vim.lsp.buf.implementation, {})
  vim.keymap.set("n", "<F12>", vim.lsp.buf.definition, {})
  vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {})
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
  vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, {})
  vim.keymap.set("n", "<A-F>", vim.lsp.buf.format, {})
end

function B.Tabs()
  vim.keymap.set({ "n", "v" }, "<leader>tp", "<cmd>BufferLineTogglePin<CR>", { desc = "Pin Tab" })
end

function B.Debug(dap, dapui)
  vim.keymap.set("n", "<F5>", dap.continue, {})

  vim.keymap.set("n", "q", function()
    dap.close()
    dapui.close()
  end, {})

  vim.keymap.set("n", "<F10>", dap.step_over, {})
  vim.keymap.set("n", "<leader>dO", dap.step_over, {})
  vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, {})
  vim.keymap.set("n", "<leader>dr", dap.repl.toggle, {})
  vim.keymap.set("n", "<leader>dj", dap.down, {})
  vim.keymap.set("n", "<leader>dk", dap.up, {})
  vim.keymap.set("n", "<F11>", dap.step_into, {})
  vim.keymap.set("n", "<F12>", dap.step_out, {})
  vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, {})
  vim.keymap.set("n", "<F2>", require("dap.ui.widgets").hover, {})
end

function B.Explorer()
  vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { silent = true })
end

function B.Dotnet(dotnet)
  vim.api.nvim_create_user_command("Secrets", function() dotnet.secrets() end, {})

  vim.keymap.set("n", "<A-t>", function() vim.cmd("Dotnet testrunner") end, { nowait = true })
  vim.keymap.set("n", "<C-F5>", function() dotnet.run_with_profile(true) end, { nowait = true })
  vim.keymap.set("n", "<C-b>", function() dotnet.build_default_quickfix() end, { nowait = true })
end

function B.Terminal()
  local function open_terminal(id, type)
    require("toggleterm").toggle(id, nil, nil, type)
  end

  vim.keymap.set({ 'n', 't' }, '<A-2>', function() open_terminal(2, "horizontal") end, noremap_opts)
  vim.keymap.set({ 'n', 't' }, '<A-3>', function() open_terminal(3, "float") end, noremap_opts)

  function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
  end

  vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
end

return B
