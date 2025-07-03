return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'buffers',
        numbers = 'none',
        close_command = 'bdelete! %d',
        right_mouse_command = 'bdelete! %d',
        tab_size = 18,
        diagnostics = false,
        show_close_icon = false,
        show_buffer_close_icons = false,
        enforce_regular_tabs = true,
        separator_style = 'slant',
      },
    }
    vim.keymap.set('n', '<Tab>', ':bnext<CR>', { silent = true })
    vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { silent = true })
  end,
}
