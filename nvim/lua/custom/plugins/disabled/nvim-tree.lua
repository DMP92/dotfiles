return {
  'nvim-tree/nvim-tree.lua',
  enabled = false,
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      filters = {
        dotfiles = false,
        custom = {},
      },
      git = {
        enabled = true,
        ignore = false,
      },
    }

    -- Keymaps
    local map = vim.keymap.set
    map('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
    map('n', '<leader>o', ':NvimTreeFocus<CR>', { desc = 'Focus file tree' })
  end,
}
