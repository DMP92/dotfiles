return {
  'karb94/neoscroll.nvim',
  event = 'WinScrolled',
  config = function()
    require('neoscroll').setup {
      -- You can adjust timing, easing, etc. here
      easing_function = 'sine', -- "circular", "quadratic", etc.
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = true,
    }
  end,
}
