return {
  'ahmedkhalf/project.nvim',
  enabled = false,
  event = 'VeryLazy',
  config = function()
    require('project_nvim').setup {
      manual_mode = false,
      silent_chdir = true,
      detection_methods = { 'lsp', 'pattern' },
      patterns = { '.git', 'Makefile', 'package.json' },
    }
    require('telescope').load_extension 'projects'
  end,
}
