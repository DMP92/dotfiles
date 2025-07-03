return {
  -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()
    require('mini.move').setup {
      mappings = {
        left = 'H',
        right = 'L',
        down = 'J',
        up = 'K',
      },
    }
    require('mini.icons').setup()
    --
    require('mini.misc').setup()
    MiniMisc.setup_auto_root()

    vim.keymap.set('n', '<leader>e', ':lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', { desc = 'Open MiniFiles' })
    vim.keymap.set('n', '<leader>z', ':lua MiniMisc.zoom()<CR>', { desc = '[z]oom in window' })
    vim.keymap.set('n', '<M-h>', ':lua MiniMove.move_selection("left")<CR>', { desc = 'Move selection left' })
    vim.keymap.set('n', '<M-j>', ':lua MiniMove.move_selection("down")<CR>', { desc = 'Move selection down' })
    vim.keymap.set('n', '<M-k>', ':lua MiniMove.move_selection("up")<CR>', { desc = 'Move selection up' })
    vim.keymap.set('n', '<M-l>', ':lua MiniMove.move_selection("right")<CR>', { desc = 'Move selection right' })

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
