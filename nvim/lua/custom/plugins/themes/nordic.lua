return {
  'AlexvZyl/nordic.nvim',
  lazy = false,
  enabled = false,
  priority = 1000,
  config = function()
    require('nordic').load()
    -- vim.o.cmd = 'colorscheme nordic'
  end,
}
