local U = require("config.ui")

local cmdline = {
  enabled = true,
  view = "cmdline_popup",
  opts = {},
  format = {
    cmdline = { pattern = "^:", icon = "", lang = "vim" },
    search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
    search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
    filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
    lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
    help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
    input = {},
  },
}

local views = {
  cmdline_popup = {
    border = {
      style = { "", " ", "", "", "", "", "", "" },
      padding = { top = 0, left = 2, rigth = 2, bottom = 1 },
    },
    win_options = {
      winhighlight = { "Normal:Normal,FloatBorder:NoiceCmdlinePopupBorder,FloatTitle:NoiceCmdlinePopupTitle" }
    }
  },
}

local messages = {
  enabled = true,
  view = "notify",
  view_error = "notify",
  view_warn = "notify",
  view_history = "messages",
  view_search = "virtualtext",
}

local popupmenu = {
  enabled = true,
  backend = "cmp",
  kind_icons = {},
}

local lsp = {
  progress = {
    enabled = true,
    format = "lsp_progress",
    format_done = "lsp_progress_done",
    throttle = 1000 / 30,
    view = "mini",
  },
  override = {
    ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
    ["vim.lsp.util.stylize_markdown"] = false,
    ["cmp.entry.get_documentation"] = false,
  },
  hover = {
    enabled = true,
    silent = false,
    view = nil,
    opts = {},
  },
  signature = {
    enabled = true,
    auto_open = {
      enabled = true,
      trigger = true,
      luasnip = true,
      throttle = 50,
    },
    view = nil,
    opts = {},
  },
  message = {
    enabled = true,
    view = "notify",
    opts = {},
  },
  documentation = {
    view = "hover",
    opts = {
      lang = "markdown",
      replace = true,
      render = "plain",
      format = { "{message}" },
      win_options = { concealcursor = "n", conceallevel = 3 },
    },
  },
}

return {
  "folke/noice.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  enabled = not vim.g.is_perf,
  event = "VeryLazy",
  opts = {},
  config = function()
    local noice = require("noice")

    noice.setup({
      debug = nil,
      cmdline = cmdline,
      messages = messages,
      popupmenu = popupmenu,
      redirect = {
        view = "popup",
        filter = { event = "msg_show" },
      },
      commands = {
        history = {
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp",      kind = "message" },
            },
          },
        },
        last = {
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp",      kind = "message" },
            },
          },
          filter_opts = { count = 1 },
        },
        errors = {
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = { error = true },
          filter_opts = { reverse = true },
        },
      },
      notify = {
        enabled = true,
        view = "notify",
      },
      lsp = lsp,
      markdown = {
        hover = {
          ["|(%S-)|"] = vim.cmd.help,
          ["%[.-%]%((%S-)%)"] = require("noice.util").open,
        },
        highlights = {
          ["|%S-|"] = "@text.reference",
          ["@%S+"] = "@parameter",
          ["^%s*(Parameters:)"] = "@text.title",
          ["^%s*(Return:)"] = "@text.title",
          ["^%s*(See also:)"] = "@text.title",
          ["{%S-}"] = "@parameter",
        },
      },
      health = {
        checker = true,
      },
      smart_move = {
        enabled = true,
        excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
      },
      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      throttle = 1000 / 30,
      views = views,
      routes = {},
      status = {},
      format = {},
      log = {},
      log_max_size = 1024 * 1024 * 2
    })

    U.Noice()
  end,
}
