return {
  'williamboman/mason.nvim',
  dependencies = { 'williamboman/mason-lspconfig.nvim' },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = { 'tsserver', 'html', 'cssls', 'lua_ls', 'jsonls', 'jestls' }, -- your LSPs here
    }

    -- vim.lsp.handlers['textDocument/definition'] = vim.lsp.with(vim.lsp.handlers['textDocument/definition'], { split = 'below' })
  end,
}
