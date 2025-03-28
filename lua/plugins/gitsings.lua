return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  enabled = not vim.g.is_perf,
  ft = { "gitcommit", "diff" },
  init = function()
    vim.api.nvim_create_autocmd({ "BufRead" }, {
      group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
      callback = function()
        vim.fn.jobstart({ "git", "-C", vim.loop.cwd(), "rev-parse" }, {
          on_exit = function(_, return_code)
            if return_code == 0 then
              vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
              vim.schedule(function()
                require("lazy").load { plugins = { "gitsigns.nvim" } }
              end)
            end
          end,
        })
      end,
    })
  end,
  config = function(_, _)
    require("gitsigns").setup({
      signs                        = {
        add          = { text = ' │' },
        change       = { text = ' │' },
        delete       = { text = ' _' },
        topdelete    = { text = ' ‾' },
        changedelete = { text = ' │' },
        untracked    = { text = ' ┆' },
      },
      signcolumn                   = true,
      numhl                        = false,
      linehl                       = false,
      word_diff                    = false,
      watch_gitdir                 = {
        follow_files = true
      },
      auto_attach                  = true,
      attach_to_untracked          = false,
      current_line_blame           = true,
      current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority                = 6,
      update_debounce              = 100,
      status_formatter             = nil,
      max_file_length              = 40000,
      preview_config               = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
    })
  end,
}
