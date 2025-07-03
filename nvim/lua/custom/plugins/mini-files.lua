return {
  'echasnovski/mini.files',
  config = function()
    require('mini.files').setup {
      mappings = {
        close = '<esc>',
        go_in = 'l',
        go_in_plus = 'L',
        go_out = 'h',
        go_out_plus = 'H',
        mark_goto = "'",
        mark_set = 'm',
        reset = ',',
        reveal_cwd = '.',
        show_help = 'g?',
        synchronize = 's',
        trim_left = '<',
        trim_right = '>',
      },

      options = {
        permanent_delete = false,
        use_as_default_explorer = true,
      },
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 80,
      },
    }
    keys = {
      {
        -- Open the directory of the file currently being edited
        -- If the file doesn't exist because you maybe switched to a new git branch
        -- open the current working directory
        '<leader>e',
        function()
          local buf_name = vim.api.nvim_buf_get_name(0)
          local dir_name = vim.fn.fnamemodify(buf_name, ':p:h')
          if vim.fn.filereadable(buf_name) == 1 then
            -- Pass the full file path to highlight the file
            require('mini.files').open(buf_name, true)
          elseif vim.fn.isdirectory(dir_name) == 1 then
            -- If the directory exists but the file doesn't, open the directory
            -- u
            require('mini.files').open(dir_name, true)
          else
            -- If neither exists, fallback to the current working directory
            require('mini.files').open(vim.uv.cwd(), true)
          end
        end,
        desc = 'Open mini.files (Directory of Current File or CWD if not exists)',
      },
      -- Open the current working directory
      {
        '<leader>E',
        function()
          require('mini.files').open(vim.uv.cwd(), true)
        end,
        desc = 'Open mini.files (cwd)',
      },
    }
  end,
}
