-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  require 'custom.plugins.themes.nightfly',
  require 'custom.plugins.mini',
  {
    'b0o/schemastore.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require 'schemastore'
    end,
  },
}
