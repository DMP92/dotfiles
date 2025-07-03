return {
  {
    'olimorris/onedarkpro.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('onedarkpro').setup {
        colors = {},
        highlights = {},
        styles = {
          types = 'NONE',
          -- other styles here
        },
        filetypes = {
          lua = true,
          -- other filetypes here
        },
        plugins = {
          nvim_cmp = true,
          treesitter = true,
          -- etc.
        },
        options = {
          transparency = false,
          terminal_colors = true,
          highlight_inactive_windows = false,
        },
      }

      -- 👇 colorscheme must be inside the config function
      --      vim.cmd 'colorscheme onedark'
    end,
  },
}
