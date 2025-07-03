return {
  'stevearc/oil.nvim',
  enabled = false,
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      -- vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' }),
      -- vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>', { desc = 'Open Oil Explorer' }),
    },
  },
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  config = function()
    require('oil').setup()

    -- Create keymap for 'q' inside Oil buffers only
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'oil',
      callback = function()
        vim.keymap.set('n', 'q', '<CMD>bd<CR>', {
          buffer = true,
          desc = 'Close Oil buffer',
        })
      end,
    })
  end,
  lazy = false,
}
