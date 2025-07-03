return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    local map = vim.keymap.set
    map('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon: Add file' })
    map('n', '<leader>h', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon: Toggle menu' })
    map('n', '<leader>1', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon: Go to file 1' })
    map('n', '<leader>2', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon: Go to file 2' })
    map('n', '<leader>3', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon: Go to file 3' })
    map('n', '<leader>4', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon: Go to file 4' })
    map('n', '<leader>5', function()
      harpoon:list():select(5)
    end, { desc = 'Harpoon: Go to file 5' })
    map('n', '<C-e>', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon: Previous file' })
    map('n', '<C-p>', function()
      harpoon:list():next()
    end, { desc = 'Harpoon: Next file' })
  end,
}
