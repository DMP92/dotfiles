-- ~/.config/nvim/lua/plugins/dashboard.lua
return {
  'nvimdev/dashboard-nvim',
  enabled = false,
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local db = require 'dashboard'
    db.setup {
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          {
            desc = '󰊳 Update',
            group = '@property',
            action = 'Lazy update',
            key = 'u',
          },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Apps',
            group = 'DiagnosticHint',
            action = 'Telescope app', -- Make sure this exists!
            key = 'a',
          },
          {
            desc = ' Dotfiles',
            group = 'Number',
            action = 'TelescopeDotfiles', -- Registered below
            key = 'd',
          },
        },
        mru = {
          enable = true,
          limit = 10,
          label = 'test mru',
          indent = 2,
          padding = 1,
          width = 26,
        },
        project = { enable = true, limit = 8, label = 'Test Project' },
        sections = {
          { section = 'keys', title = 'keys', height = 6, padding = 1, random = 10 },
          { section = 'header', title = 'header', height = 6, padding = 1, random = 10 },
          { section = 'recent_files', title = 'recent files', height = 6, padding = 1, random = 10 },
          { section = 'keys', title = 'test', indent = 2, padding = 1 },
          { section = 'terminal', title = 'Git Status', height = 8, padding = 2, indent = 2 },
        },
      },
    }

    -- Custom Telescope command for dotfiles
    vim.api.nvim_create_user_command('TelescopeDotfiles', function()
      require('telescope.builtin').find_files {
        cwd = vim.fn.stdpath 'config', -- or your actual dotfiles path
      }
    end, {})
  end,
}
