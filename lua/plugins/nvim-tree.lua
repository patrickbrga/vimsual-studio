local B = require("config.bindings")
local I = require("utils.icons")

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 'A', function()
    local node = api.tree.get_node_under_cursor()
    local path = node.type == "directory" and node.absolute_path or vim.fs.dirname(node.absolute_path)
    require("easy-dotnet").create_new_item(path)
  end, opts('Create file from dotnet template'))
end

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      diagnostics = {
        enable = true,
        show_on_dirs = true
      },
      filters = {
        enable = true,
        git_ignored = true,
        dotfiles = true,
        exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
      },
      live_filter = {
        prefix = I.ui.Search .. ": ",
        always_show_folders = false
      },
      on_attach = on_attach,
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = true,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        adaptive_size = true,
        side = "left",
        width = 30,
        preserve_window_proportions = true,
      },
      git = {
        enable = not vim.g.is_perf,
        ignore = false,
      },
      filesystem_watchers = {
        enable = not vim.g.is_perf,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        highlight_opened_files = "all",
        indent_markers = { enable = false },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "󰈚",
            symlink = I.ui.FileSymlink,
            folder = {
              default = I.ui.Folder,
              empty = I.ui.EmptyFolder,
              empty_open = I.ui.EmptyFolderOpen,
              open = I.ui.FolderOpen,
              symlink = I.ui.FolderSymlink,
              symlink_open = I.ui.FolderSymlink,
              arrow_open = I.ui.ChevronShortDown,
              arrow_closed = I.ui.ChevronShortRight,
            },
            git = {
              unstaged = I.git.FileUnstaged,
              staged = I.git.FileStaged,
              unmerged = I.git.FileUnmerged,
              renamed = I.git.FileRenamed,
              untracked = I.git.FileUntracked,
              deleted = I.git.FileDeleted,
              ignored = I.git.FileIgnored,
            },
          },
        },
      },
    })

    B.Explorer()
  end,
}
