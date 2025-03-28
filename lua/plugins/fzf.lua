return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require "fzf-lua"
    local actions = require "fzf-lua.actions"
    fzf.setup {
      winopts = {
        height = 0.85, -- window height
        width = 0.80,  -- window width
        row = 0.35,    -- window row position (0=top, 1=bottom)
        col = 0.50,    -- window col position (0=left, 1=right)
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        -- Backdrop opacity, 0 is fully opaque, 100 is fully transparent (i.e. disabled)
        backdrop = 60,
        fullscreen = true,
        preview = {
          default = "bat",          -- override the default previewer?
          -- default uses the 'builtin' previewer
          border = "border",        -- border|noborder, applies only to
          -- native fzf previewers (bat/cat/git/etc)
          wrap = "nowrap",          -- wrap|nowrap
          hidden = "nohidden",      -- hidden|nohidden
          vertical = "down:45%",    -- up|down:size
          horizontal = "right:60%", -- right|left:size
          layout = "flex",          -- horizontal|vertical|flex
          flip_columns = 120,       -- #cols to switch to horizontal on flex
          -- Only used with the builtin previewer:
          title = true,             -- preview border title (file/buf)?
          title_pos = "center",     -- left|center|right, title alignment
          scrollbar = "float",      -- `false` or string:'float|border'
          -- float:  in-window floating border
          -- border: in-border chars (see below)
          scrolloff = "-2", -- float scrollbar offset from right
          -- applies only when scrollbar = 'float'
          scrollchars = { "█", "" }, -- scrollbar chars ({ <full>, <empty> }
          -- applies only when scrollbar = 'border'
          delay = 100, -- delay(ms) displaying the preview
          -- prevents lag on fast scrolling
          winopts = { -- builtin previewer window options
            number = true,
            relativenumber = false,
            cursorline = true,
            cursorlineopt = "both",
            cursorcolumn = false,
            signcolumn = "no",
            list = false,
            foldenable = false,
            foldmethod = "manual",
          },
        },
        -- called once _after_ the fzf interface is closed
        -- on_close = function() ... end
      },
      keymap = {
        -- Below are the default binds, setting any value in these tables will override
        -- the defaults, to inherit from the defaults change [1] from `false` to `true`
        builtin = {
          false,                -- do not inherit from defaults
          -- neovim `:tmap` mappings for the fzf win
          ["<M-Esc>"] = "hide", -- hide fzf-lua, `:FzfLua resume` to continue
          ["<F1>"] = "toggle-help",
          ["<F2>"] = "toggle-fullscreen",
          -- Only valid with the 'builtin' previewer
          ["<F3>"] = "toggle-preview-wrap",
          ["<F4>"] = "toggle-preview",
          -- Rotate preview clockwise/counter-clockwise
          ["<F5>"] = "toggle-preview-ccw",
          ["<F6>"] = "toggle-preview-cw",
          ["<S-down>"] = "preview-page-down",
          ["<S-up>"] = "preview-page-up",
          ["<M-S-down>"] = "preview-down",
          ["<M-S-up>"] = "preview-up",
        },
        fzf = {
          false, -- do not inherit from defaults
          ["ctrl-z"] = "abort",
          ["ctrl-d"] = "half-page-down",
          ["ctrl-u"] = "half-page-up",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
          ["alt-a"] = "toggle-all",
          ["alt-g"] = "last",
          ["alt-G"] = "first",
          ["f3"] = "toggle-preview-wrap",
          ["f4"] = "toggle-preview",
          ["shift-down"] = "preview-page-down",
          ["shift-up"] = "preview-page-up",
        },
      },
      actions = {
        files = {
          false, -- do not inherit from defaults
          ["enter"] = actions.file_edit_or_qf,
          ["ctrl-s"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
          ["ctrl-t"] = actions.file_tabedit,
          ["alt-q"] = actions.file_sel_to_qf,
          ["alt-Q"] = actions.file_sel_to_ll,
        },
      },
      fzf_opts = {
        ["--ansi"] = true,
        ["--info"] = "inline-right", -- fzf < v0.42 = "inline"
        ["--height"] = "100%",
        ["--layout"] = "reverse",
        ["--border"] = "none",
        ["--highlight-line"] = true, -- fzf >= v0.53
      },
      fzf_tmux_opts = { ["-p"] = "80%,80%", ["--margin"] = "0,0" },
      previewers = {
        cat = {
          cmd = "cat",
          args = "-n",
        },
        bat = {
          cmd = "bat",
          args = "--color=always --style=numbers,changes",
          -- uncomment to set a bat theme, `bat --list-themes`
          -- theme           = 'Coldark-Dark',
        },
        head = {
          cmd = "head",
          args = nil,
        },
        git_diff = {
          cmd_deleted = "git diff --color HEAD --",
          cmd_modified = "git diff --color HEAD",
          cmd_untracked = "git diff --color --no-index /dev/null",
        },
        man = {
          cmd = "man -c %s | col -bx",
        },
        builtin = {
          syntax = true,                -- preview syntax highlight?
          syntax_limit_l = 0,           -- syntax limit (lines), 0=nolimit
          syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
          limit_b = 1024 * 1024 * 10,   -- preview limit (bytes), 0=nolimit
          treesitter = { enabled = true, disabled = {} },
          toggle_behavior = "default",
          extensions = {
            ["png"] = { "viu", "-b" },
            ["svg"] = { "chafa", "{file}" },
            ["jpg"] = { "ueberzug" },
          },
          ueberzug_scaler = "cover",
        },
        codeaction = {
          diff_opts = { ctxlen = 3 },
        },
        codeaction_native = {
          diff_opts = { ctxlen = 3 },
        },
      },
      files = {
        prompt = "Files❯ ",
        multiprocess = true,           -- run command in a separate process
        git_icons = not vim.g.is_perf, -- show git icons?
        file_icons = true,             -- show file icons (true|"devicons"|"mini")?
        color_icons = true,            -- colorize file|git icons
        find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts = [[--color=never --files --hidden --follow -g "!.git"]],
        fd_opts = [[--color=never --type f --hidden --follow --exclude .git]],
        cwd_prompt = true,
        cwd_prompt_shorten_len = 32,        -- shorten prompt beyond this length
        cwd_prompt_shorten_val = 1,         -- shortened path parts length
        toggle_ignore_flag = "--no-ignore", -- flag toggled in `actions.toggle_ignore`
        toggle_hidden_flag = "--hidden",    -- flag toggled in `actions.toggle_hidden`
        actions = {
          ["ctrl-g"] = { actions.toggle_ignore },
        },
      },
      git = {
        files = {
          prompt = "GitFiles❯ ",
          cmd = "git ls-files --exclude-standard",
          multiprocess = true,           -- run command in a separate process
          git_icons = not vim.g.is_perf, -- show git icons?
          file_icons = true,             -- show file icons (true|"devicons"|"mini")?
          color_icons = true,            -- colorize file|git icons
        },
        status = {
          prompt = "GitStatus❯ ",
          cmd = "git -c color.status=false --no-optional-locks status --porcelain=v1 -u",
          multiprocess = true, -- run command in a separate process
          file_icons = true,
          git_icons = not vim.g.is_perf,
          color_icons = true,
          previewer = "git_diff",
          actions = {
            ["right"] = { fn = actions.git_unstage, reload = true },
            ["left"] = { fn = actions.git_stage, reload = true },
            ["ctrl-x"] = { fn = actions.git_reset, reload = true },
          },
        },
        commits = {
          prompt = "Commits❯ ",
          cmd = [[git log --color --pretty=format:"%C(yellow)%h%Creset ]]
              .. [[%Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset"]],
          preview = "git show --color {1}",
          actions = {
            ["enter"] = actions.git_checkout,
            ["ctrl-y"] = { fn = actions.git_yank_commit, exec_silent = true },
          },
        },
        bcommits = {
          prompt = "BCommits❯ ",
          cmd = [[git log --color --pretty=format:"%C(yellow)%h%Creset ]]
              .. [[%Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset" {file}]],
          preview = "git show --color {1} -- {file}",
          actions = {
            ["enter"] = actions.git_buf_edit,
            ["ctrl-s"] = actions.git_buf_split,
            ["ctrl-v"] = actions.git_buf_vsplit,
            ["ctrl-t"] = actions.git_buf_tabedit,
            ["ctrl-y"] = { fn = actions.git_yank_commit, exec_silent = true },
          },
        },
        branches = {
          prompt = "Branches❯ ",
          cmd = "git branch --all --color",
          preview = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
          actions = {
            ["enter"] = actions.git_switch,
            ["ctrl-x"] = { fn = actions.git_branch_del, reload = true },
            ["ctrl-a"] = { fn = actions.git_branch_add, field_index = "{q}", reload = true },
          },
          cmd_add = { "git", "branch" },
          cmd_del = { "git", "branch", "--delete" },
        },
        tags = {
          prompt = "Tags> ",
          cmd = [[git for-each-ref --color --sort="-taggerdate" --format ]]
              .. [["%(color:yellow)%(refname:short)%(color:reset) ]]
              .. [[%(color:green)(%(taggerdate:relative))%(color:reset)]]
              .. [[ %(subject) %(color:blue)%(taggername)%(color:reset)" refs/tags]],
          preview = [[git log --graph --color --pretty=format:"%C(yellow)%h%Creset ]]
              .. [[%Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset" {1}]],
          actions = { ["enter"] = actions.git_checkout },
        },
        stash = {
          prompt = "Stash> ",
          cmd = "git --no-pager stash list",
          preview = "git --no-pager stash show --patch --color {1}",
          actions = {
            ["enter"] = actions.git_stash_apply,
            ["ctrl-x"] = { fn = actions.git_stash_drop, reload = true },
          },
        },
        icons = {
          ["M"] = { icon = "M", color = "yellow" },
          ["D"] = { icon = "D", color = "red" },
          ["A"] = { icon = "A", color = "green" },
          ["R"] = { icon = "R", color = "yellow" },
          ["C"] = { icon = "C", color = "yellow" },
          ["T"] = { icon = "T", color = "magenta" },
          ["?"] = { icon = "?", color = "magenta" },
        },
      },
      grep = {
        prompt = "Rg❯ ",
        input_prompt = "Grep For❯ ",
        multiprocess = true, -- run command in a separate process
        git_icons = not vim.g.is_perf,
        file_icons = true,   -- show file icons (true|"devicons"|"mini")?
        color_icons = true,  -- colorize file|git icons
        grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
        rg_glob = false,           -- default to glob parsing?
        glob_flag = "--iglob",     -- for case sensitive globs use '--glob'
        glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
        actions = {
          -- actions inherit from 'actions.files' and merge
          -- this action toggles between 'grep' and 'live_grep'
          ["ctrl-g"] = { actions.grep_lgrep },
          -- uncomment to enable '.gitignore' toggle for grep
          -- ["ctrl-r"]   = { actions.toggle_ignore }
        },
        no_header = false,   -- hide grep|cwd header?
        no_header_i = false, -- hide interactive header?
      },
      args = {
        prompt = "Args❯ ",
        files_only = true,
        -- actions inherit from 'actions.files' and merge
        actions = { ["ctrl-x"] = { fn = actions.arg_del, reload = true } },
      },
      oldfiles = {
        prompt = "History❯ ",
        cwd_only = false,
        stat_file = true, -- verify files exist on disk
        -- can also be a lua function, for example:
        -- stat_file = require("fzf-lua").utils.file_is_readable,
        -- stat_file = function() return true end,
        include_current_session = false, -- include bufs from current session
      },
      buffers = {
        prompt = "Buffers❯ ",
        file_icons = true,    -- show file icons (true|"devicons"|"mini")?
        color_icons = true,   -- colorize file|git icons
        sort_lastused = true, -- sort buffers() by last used
        show_unloaded = true, -- show unloaded buffers
        cwd_only = false,     -- buffers for the cwd only
        cwd = nil,            -- buffers list for a given dir
        actions = {
          -- actions inherit from 'actions.files' and merge
          -- by supplying a table of functions we're telling
          -- fzf-lua to not close the fzf window, this way we
          -- can resume the buffers picker on the same window
          -- eliminating an otherwise unaesthetic win "flash"
          ["ctrl-x"] = { fn = actions.buf_del, reload = true },
        },
      },
      tabs = {
        prompt = "Tabs❯ ",
        tab_title = "Tab",
        tab_marker = "<<",
        file_icons = true,  -- show file icons (true|"devicons"|"mini")?
        color_icons = true, -- colorize file|git icons
        actions = {
          -- actions inherit from 'actions.files' and merge
          ["enter"] = actions.buf_switch,
          ["ctrl-x"] = { fn = actions.buf_del, reload = true },
        },
        fzf_opts = {
          -- hide tabnr
          ["--delimiter"] = "[\\):]",
          ["--with-nth"] = "2..",
        },
      },
      lines = {
        previewer = "builtin",  -- set to 'false' to disable
        prompt = "Lines❯ ",
        show_unloaded = true,   -- show unloaded buffers
        show_unlisted = false,  -- exclude 'help' buffers
        no_term_buffers = true, -- exclude 'term' buffers
        fzf_opts = {
          -- do not include bufnr in fuzzy matching
          -- tiebreak by line no.
          ["--delimiter"] = "[\\]:]",
          ["--nth"] = "2..",
          ["--tiebreak"] = "index",
          ["--tabstop"] = "1",
        },
        -- actions inherit from 'actions.files' and merge
        actions = {
          ["enter"] = actions.buf_edit_or_qf,
          ["alt-q"] = actions.buf_sel_to_qf,
          ["alt-l"] = actions.buf_sel_to_ll,
        },
      },
      blines = {
        previewer = "builtin",   -- set to 'false' to disable
        prompt = "BLines❯ ",
        show_unlisted = true,    -- include 'help' buffers
        no_term_buffers = false, -- include 'term' buffers
        -- start          = "cursor"      -- start display from cursor?
        fzf_opts = {
          -- hide filename, tiebreak by line no.
          ["--delimiter"] = "[:]",
          ["--with-nth"] = "2..",
          ["--tiebreak"] = "index",
          ["--tabstop"] = "1",
        },
        -- actions inherit from 'actions.files' and merge
        actions = {
          ["enter"] = actions.buf_edit_or_qf,
          ["alt-q"] = actions.buf_sel_to_qf,
          ["alt-l"] = actions.buf_sel_to_ll,
        },
      },
      tags = {
        prompt = "Tags❯ ",
        ctags_file = nil, -- auto-detect from tags-option
        multiprocess = true,
        file_icons = true,
        git_icons = not vim.g.is_perf, -- show git icons?
        color_icons = true,
        -- 'tags_live_grep' options, `rg` prioritizes over `grep`
        rg_opts = "--no-heading --color=always --smart-case",
        grep_opts = "--color=auto --perl-regexp",
        fzf_opts = { ["--tiebreak"] = "begin" },
        actions = {
          -- actions inherit from 'actions.files' and merge
          -- this action toggles between 'grep' and 'live_grep'
          ["ctrl-g"] = { actions.grep_lgrep },
        },
        no_header = false,   -- hide grep|cwd header?
        no_header_i = false, -- hide interactive header?
      },
      btags = {
        prompt = "BTags❯ ",
        ctags_file = nil,     -- auto-detect from tags-option
        ctags_autogen = true, -- dynamically generate ctags each call
        multiprocess = true,
        file_icons = false,
        git_icons = false,
        rg_opts = "--color=never --no-heading",
        grep_opts = "--color=never --perl-regexp",
        fzf_opts = { ["--tiebreak"] = "begin" },
      },
      colorschemes = {
        prompt = "Colorschemes❯ ",
        live_preview = true,
        actions = { ["enter"] = actions.colorscheme },
        winopts = { height = 0.55, width = 0.30 },
      },
      awesome_colorschemes = {
        prompt = "Colorschemes❯ ",
        live_preview = true,
        max_threads = 5,
        winopts = { row = 0, col = 0.99, width = 0.50 },
        fzf_opts = {
          ["--multi"] = true,
          ["--delimiter"] = "[:]",
          ["--with-nth"] = "3..",
          ["--tiebreak"] = "index",
        },
        actions = {
          ["enter"] = actions.colorscheme,
          ["ctrl-g"] = { fn = actions.toggle_bg, exec_silent = true },
          ["ctrl-r"] = { fn = actions.cs_update, reload = true },
          ["ctrl-x"] = { fn = actions.cs_delete, reload = true },
        },
      },
      keymaps = {
        prompt = "Keymaps> ",
        winopts = { preview = { layout = "vertical" } },
        fzf_opts = { ["--tiebreak"] = "index" },

        ignore_patterns = { "^<SNR>", "^<Plug>" },
        show_details = true,
        actions = {
          ["enter"] = actions.keymap_apply,
          ["ctrl-s"] = actions.keymap_split,
          ["ctrl-v"] = actions.keymap_vsplit,
          ["ctrl-t"] = actions.keymap_tabedit,
        },
      },
      quickfix = {
        file_icons = true,
        git_icons = not vim.g.is_perf,
        only_valid = false,
      },
      quickfix_stack = {
        prompt = "Quickfix Stack> ",
        marker = ">",
      },
      lsp = {
        prompt_postfix = "❯ ",
        cwd_only = false,
        async_or_timeout = 5000,
        file_icons = true,
        git_icons = false,
        includeDeclaration = true,
        symbols = {
          async_or_timeout = true,
          symbol_style = 1,
          symbol_icons = {
            File = "󰈙",
            Module = "",
            Namespace = "󰦮",
            Package = "",
            Class = "󰆧",
            Method = "󰊕",
            Property = "",
            Field = "",
            Constructor = "",
            Enum = "",
            Interface = "",
            Function = "󰊕",
            Variable = "󰀫",
            Constant = "󰏿",
            String = "",
            Number = "󰎠",
            Boolean = "󰨙",
            Array = "󱡠",
            Object = "",
            Key = "󰌋",
            Null = "󰟢",
            EnumMember = "",
            Struct = "󰆼",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰗴",
          },
          symbol_hl = function(s)
            return "@" .. s:lower()
          end,
          symbol_fmt = function(s, opts)
            return "[" .. s .. "]"
          end,
          child_prefix = true,
          fzf_opts = { ["--tiebreak"] = "begin" },
        },
        code_actions = {
          prompt = "Code Actions> ",
          async_or_timeout = 5000,
          previewer = "codeaction",
        },
        finder = {
          prompt = "LSP Finder> ",
          file_icons = true,
          color_icons = true,
          git_icons = false,
          async = true,
          silent = true,
          separator = "| ",
          includeDeclaration = true,
          providers = {
            { "references",      prefix = require("fzf-lua").utils.ansi_codes.blue "ref " },
            { "definitions",     prefix = require("fzf-lua").utils.ansi_codes.green "def " },
            { "declarations",    prefix = require("fzf-lua").utils.ansi_codes.magenta "decl" },
            { "typedefs",        prefix = require("fzf-lua").utils.ansi_codes.red "tdef" },
            { "implementations", prefix = require("fzf-lua").utils.ansi_codes.green "impl" },
            { "incoming_calls",  prefix = require("fzf-lua").utils.ansi_codes.cyan "in  " },
            { "outgoing_calls",  prefix = require("fzf-lua").utils.ansi_codes.yellow "out " },
          },
        },
      },
      diagnostics = {
        prompt = "Diagnostics❯ ",
        cwd_only = false,
        file_icons = true,
        git_icons = false,
        diag_icons = true,
        diag_source = true,
        icon_padding = "",
        multiline = true,
      },
      marks = {
        marks = "",
      },
      complete_path = {
        cmd = nil,
        complete = { ["enter"] = actions.complete },
      },
      complete_file = {
        cmd = nil,
        file_icons = true,
        color_icons = true,
        git_icons = false,
        actions = { ["enter"] = actions.complete },
        winopts = { preview = { hidden = "hidden" } },
      },
      file_icon_padding = "",
    }
    vim.cmd "FzfLua setup_fzfvim_cmds"

    vim.keymap.set("n", "<leader>fw", function()
      fzf.grep { search = "" }
    end, { nowait = true })

    vim.keymap.set("n", "<leader><leader>", function()
      fzf.files()
    end, { nowait = true })
  end,
}
