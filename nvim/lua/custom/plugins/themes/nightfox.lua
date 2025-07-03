return {
  'EdenEast/nightfox.nvim',
  config = function()
    require('nightfox').setup {
      options = {
        styles = {
          comments = 'italic',
          keywords = 'italic',
          conditionals = 'italic',
        },
      },
    }
    -- vim.cmd 'colorscheme nightfox'
  end,
}
