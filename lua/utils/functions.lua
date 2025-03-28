local F = {}

function F.CurrentBufferFilename()
    local bufname = vim.api.nvim_buf_get_name(0)
    return bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or ""
end

function F.CurrentBufferLsp()
  local buf_ft = F.CurrentBufferFilename()
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then return "" end
    local current_clients = ""

    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            current_clients = current_clients .. client.name .. " "
        end
    end

    return current_clients
end

function F.RefreshStatusLine()
  require("lualine").refresh({ statusline = true })
end

return F
