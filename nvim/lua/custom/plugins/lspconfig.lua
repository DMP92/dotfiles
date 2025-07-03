return {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require 'lspconfig'
    local schemastore = require 'schemastore'

    -- Example for Lua
    lspconfig.lua_ls.setup {}

    -- Example for TypeScript
    lspconfig.tsserver.setup {}

    -- Example for HTML
    lspconfig.html.setup {}

    -- Example for CSS
    lspconfig.cssls.setup {}
    -- lspconfig.htmlx.setup {}
    --

    lspconfig.jsonls.setup {
      settings = {
        json = {
          schemas = {
            {
              fileMatch = { 'package.json' },
              url = 'https://json.schemastore.org/package.json',
            },
          },
          validate = { enable = true },
        },
      },
    }
  end,
}
