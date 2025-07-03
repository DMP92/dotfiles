-- Telescope builtin
local builtin = require 'telescope.builtin'

-- Mini.Files
local files = require 'mini.files'

-- WhichKey
local wk = require 'which-key'

local MiniFiles = require 'mini.files'

-- NOTE: Functions

-- Visual Multi function
local function visual_cursors_with_delay()
  -- Execute the vm-visual-cursors command.
  vim.cmd 'silent! execute "normal! \\<Plug>(VM-Visual-Cursors)"'
  -- Introduce delay via VimScript's 'sleep' (set to 500 milliseconds here).
  vim.cmd 'sleep 200m'
  -- Press 'A' in normal mode after the delay.
  vim.cmd 'silent! execute "normal! A"'
end

function _G.markdown_foldexpr()
  local lnum = vim.v.lnum
  local line = vim.fn.getline(lnum)
  local heading = line:match '^(#+)%s'
  if heading then
    local level = #heading
    if level == 1 then
      if lnum == 1 then
        return '>1'
      else
        local frontmatter_end = vim.b.frontmatter_end
        if frontmatter_end and (lnum == frontmatter_end + 1) then
          return '>1'
        end
      end
    elseif level >= 2 and level <= 6 then
      return '>' .. level
    end
  end
  return '='
end

local function set_markdown_folding()
  vim.opt_local.foldmethod = 'expr'
  vim.opt_local.foldexpr = 'v:lua.markdown_foldexpr()'
  vim.opt_local.foldlevel = 99

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local found_first = false
  local frontmatter_end = nil
  for i, line in ipairs(lines) do
    if line == '---' then
      if not found_first then
        found_first = true
      else
        frontmatter_end = i
        break
      end
    end
  end
  vim.b.frontmatter_end = frontmatter_end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = set_markdown_folding,
})

local function fold_headings_of_level(level)
  vim.cmd 'keepjumps normal! gg'
  local total_lines = vim.fn.line '$'
  for line = 1, total_lines do
    local line_content = vim.fn.getline(line)
    if line_content:match('^' .. string.rep('#', level) .. '%s') then
      vim.cmd(string.format('keepjumps call cursor(%d, 1)', line))
      local current_foldlevel = vim.fn.foldlevel(line)
      if current_foldlevel > 0 then
        if vim.fn.foldclosed(line) == -1 then
          vim.cmd 'normal! za'
        end
      end
    end
  end
end

local function fold_markdown_headings(levels)
  local saved_view = vim.fn.winsaveview()
  for _, level in ipairs(levels) do
    fold_headings_of_level(level)
  end
  vim.cmd 'nohlsearch'
  vim.fn.winrestview(saved_view)
end

-- Usage:
-- preview_image("/full/path/to/image.png")

-- NOTE: Keymaps Start

return {
  -- NOTE: General Keymaps
  --
  vim.keymap.set('n', '<leader>q', ':bd<CR>', { desc = 'Close current buffer' }),
  -- vim.keymap.set('n', '<leader>6', preview_image '/Users/devinpfromm/Documents/archive/achive-april-17-2025/hero_image.png', { des = 'Preview Image' }),
  -- NOTE: WhichKey Keymaps
  --
  wk.add {
    { '<leader>d', icon = '', group = '+Change Directory' },
    { '<leader>dg', group = '+Google Drive' },
    { '<leader>do', group = '+Open' },
    { '<leader>du', group = '+Utilities' },
    { '<leader>duc', group = '+Copy' },
    { '<leader>l', group = 'Vim Visual Multi' },
    { '<leader>f', group = 'Snacks File Search' },
    { '<leader>t', group = '.md -> .docx templates' },
    { '<leader>o', group = '+Obsidian' },
    { '<leader>oi', group = 'Insert' },
    { '<leader>oo', group = 'Open' },
    { '<leader>os', group = 'Search' },
    { '<leader>u', group = '+Utilities' },
    { '<leader>ui', group = '+Image' },
    { '<leader>m', group = '+Mini Files' },
    { '<leader>mu', group = '+Utilities' },
    { '<leader>b', group = '+Buffer' },
    { '<leader>oa', group = 'Cycle List Types' },
    { '<leader>g', group = '+Git' },
    { '<leader>om', group = '+Folding Headings' },
  },

  -- NOTE: 'U' Keymap Group
  --

  vim.keymap.set('n', '<leader>uiy', function()
    local snacks = require 'snacks'
    local path = Snacks.get_current_path()
    if path then
      vim.fn.system { 'osascript', '-e', 'set the clipboard to POSIX file "' .. path .. '"' }
      print('Copied image path to clipboard: ' .. path)
    end
  end, { desc = 'Copy image path (Snacks)' }),

  -- NOTE: 'F' Keymap Group
  --
  -- Telescope keymaps
  -- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' }),
  -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' }),
  -- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' }),
  -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' }),
  -- vim.keymap.set('n', '<leader>fd', ':Telescope dotfiles<CR>', { desc = 'Find Dotfiles' }),
  -- vim.keymap.set('n', '<leader>fe', ':edit<CR>', { desc = '' }),

  --  :NOTE: 'M' Keymap Group
  vim.keymap.set('n', '<leader>mo', ':belowright Outline<CR>', { desc = 'Show Markdown Outline' }),

  -- NOTE: 'L' Keymap Group
  --
  -- Visual Multi keymaps
  vim.keymap.set('n', '<leader>la', '<Plug>(VM-Select-All)', { desc = 'Select All' }),
  vim.keymap.set('n', '<leader>lo', '<Plug>(VM-Toggle-Mappings)', { desc = 'Toggle Mapping' }),
  vim.keymap.set('n', '<leader>lp', '<Plug>(VM-Add-Cursor-At-Pos)', { desc = 'Add Cursor At Pos' }),
  vim.keymap.set('n', '<leader>lr', '<Plug>(VM-Start-Regex-Search)', { desc = 'Start Regex Search' }),
  vim.keymap.set('v', '<leader>lv', '<Plug>(VM-Visual-Cursors)', { desc = 'Visual Cursors' }),

  -- NOTE: 'D' Keymap Group
  --
  -- NOTE: Change Directories

  -- Change directory to selected
  vim.keymap.set('n', '<leader>dd', function()
    vim.cmd 'cd ~/Documents'
    files.open('~/Documents', false)
  end, { desc = 'Documents' }),

  vim.keymap.set('n', '<leader>dgp', function()
    vim.cmd 'cd ~/Library/CloudStorage/GoogleDrive-devin@spirradigital.com/My Drive/01-sdd/01-spirra/02-projects/'
    files.open('~/Library/CloudStorage/GoogleDrive-devin@spirradigital.com/My Drive/01-sdd/01-spirra/02-projects/', false)
  end, { desc = 'Projects' }),

  vim.keymap.set('n', '<leader>dgd', function()
    vim.cmd 'cd ~/Library/CloudStorage/GoogleDrive-devin@spirradigital.com/My Drive/'
    files.open('~/Library/CloudStorage/GoogleDrive-devin@spirradigital.com/My Drive/', false)
  end, { desc = 'Google Drive Main' }),

  vim.keymap.set('n', '<leader>dn', function()
    vim.cmd 'cd ~/Downloads'
    files.open('~/Downloads', false)
  end, { desc = 'Downloads' }),

  vim.keymap.set('n', '<leader>dv', function()
    vim.cmd 'cd ~/Documents/education/resources/obsidian-vault-container/SD/'
    files.open('~/Documents/education/resources/obsidian-vault-container/SD/', false)
  end, { desc = ' SD Vault' }),

  vim.keymap.set('n', '<leader>dc', function()
    vim.cmd 'cd $HOME/.config'
    files.open('.', false)
  end, { desc = ' Config Folder' }),

  vim.keymap.set('n', '<leader>dl', function()
    vim.cmd 'cd $HOME/.config/nvim/lua/'
    files.open('.', false)
  end, { desc = ' Config Folder' }),

  vim.keymap.set('n', '<leader>dp', function()
    vim.cmd 'cd $HOME/.config/vault/'
    files.open('.', false)
  end, { desc = 'Security Folder' }),

  vim.keymap.set('n', '<leader>dt', function()
    vim.cmd 'cd ~/Documents/work/tools/custom/os/'
    files.open('.', false)
  end, { desc = 'Security Folder' }),

  -- NOTE: Snacks

  -- Open Snacks Dashboard
  vim.keymap.set('n', '<leader>da', function()
    Snacks.dashboard.update()
    Snacks.dashboard.open()
  end, { desc = 'Open Snacks Dashboard' }),

  -- NOTE: Mini.nvim
  -- NOTE: Copy -----------------------------------------------------------------

  -- Copy file path to clipboard (MiniFiles or normal buffer)
  vim.keymap.set({ 'n', 'v' }, '<leader>dup', function()
    local rawPath = vim.fn.expand '%:~'
    local filePath
    if string.find(rawPath, 'minifiles://') then
      local buf_id = vim.api.nvim_get_current_buf()
      local fs_entry = MiniFiles.get_fs_entry(buf_id)
      filePath = fs_entry.path
    else
      filePath = vim.fn.expand '%:~' -- Gets file path relative to ~
    end
    vim.fn.setreg('+', filePath) -- Copy to system clipboard
    vim.notify('Path copied to clipboard: ' .. filePath, vim.log.levels.INFO)
  end, { desc = 'Copy File Path to clipboard' }),

  -- If highlighted is a file - copy it to clipboard
  -- If highlighted is a folder - zip it and copy the zip path to clipboard
  vim.keymap.set({ 'n', 'v' }, '<leader>duf', function()
    local MiniFiles = require 'mini.files'
    local rawPath = vim.fn.expand '%:p'
    local filePath

    -- Detect if MiniFiles is active
    if string.find(rawPath, 'minifiles://') then
      local buf_id = vim.api.nvim_get_current_buf()
      local ok, fs_entry = pcall(MiniFiles.get_fs_entry, buf_id)
      if not ok or not fs_entry then
        vim.notify('⚠️ No file selected in MiniFiles', vim.log.levels.WARN)
        return
      end
      filePath = fs_entry.path
    else
      filePath = rawPath
    end

    local is_dir = vim.fn.isdirectory(filePath) == 1

    if is_dir then
      -- Folder: zip and copy zip path
      -- local zip_path = '/tmp/zipped_folder_' .. os.time() .. '.zip'
      local zip_name = vim.fn.fnamemodify(filePath, ':t') .. '.zip'
      local zip_path = '/tmp/' .. zip_name
      -- local zip_cmd = { 'zip', '-r', zip_path, filePath }
      local zip_cmd = {
        'sh',
        '-c',
        'cd "' .. vim.fn.fnamemodify(filePath, ':h') .. '" && zip -r "' .. zip_path .. '" "' .. vim.fn.fnamemodify(filePath, ':t') .. '"',
      }
      vim.fn.jobstart(zip_cmd, {
        on_exit = function()
          local script = 'set the clipboard to POSIX file "' .. zip_path .. '"'
          vim.fn.system { 'osascript', '-e', script }
          vim.notify('📦 Folder zipped & copied: ' .. zip_path)
        end,
      })
    else
      -- File: copy actual file to clipboard
      local script = 'set the clipboard to POSIX file "' .. filePath .. '"'
      vim.fn.system { 'osascript', '-e', script }
      vim.notify('📄 File copied to clipboard: ' .. filePath)
    end
  end, { desc = 'Copy File/Folders to Clipboard (zip folders)' }),

  -- NOTE: Open -----------------------------------------------------------------

  -- Open file in Finder
  vim.keymap.set('n', '<leader>dof', ':!open %:p:h<CR>', { desc = 'Open current buffer in Finder' }),

  -- Open file being hovered over in Mini.Files
  vim.keymap.set('n', '<leader>dom', function()
    local cur = require('mini.files').get_fs_entry()
    if cur then
      vim.fn.jobstart({ 'open', cur.path }, { detach = true })
      vim.notify('📂 Opened: ' .. cur.path)
    else
      vim.notify('❌ No file selected in mini.files', vim.log.levels.WARN)
    end
  end, { desc = 'Open hovered file' }),

  -- NOTE: Pandocs
  vim.keymap.set('n', '<leader>dux', function()
    local input
    -- Check if current buffer is a mini.files buffer
    local ok, mini = pcall(require, 'mini.files')
    if ok and mini.get_fs_entry then
      local buf_name = vim.api.nvim_buf_get_name(0)
      if buf_name:match '^minifiles://' then
        local entry = mini.get_fs_entry()
        if entry and entry.path then
          input = entry.path
        end
      end
    end
    -- Fallback to current buffer
    if not input then
      local buf_path = vim.fn.expand '%:p'
      if vim.fn.filereadable(buf_path) == 1 then
        input = buf_path
      else
        vim.notify('❌ No valid file found in mini.files or buffer', vim.log.levels.ERROR)
        return
      end
    end
    local output = input:gsub('%.md$', '.docx')
    local template = vim.fn.expand '~/Documents/work/resources/templates/quote-template.docx'
    if vim.fn.filereadable(template) ~= 1 then
      vim.notify('❌ Missing template file:\n' .. template, vim.log.levels.ERROR)
      return
    end
    local result = vim.fn.system {
      'pandoc',
      input,
      '-o',
      output,
      '--reference-doc=' .. template,
    }
    if vim.v.shell_error == 0 then
      vim.notify('✅ Converted: ' .. output)
      vim.fn.jobstart({ 'open', output }, { detach = true })
    else
      vim.notify('❌ Pandoc error:\n' .. result, vim.log.levels.ERROR)
    end
  end, { desc = 'md -> docx' }),

  -------------------------------------------------------------------------------
  --                           Folding section
  -------------------------------------------------------------------------------

  -- Keymaps for custom folding (under <leader>om)
  vim.keymap.set('n', '<leader>om1', function()
    vim.cmd 'silent update'
    vim.cmd 'edit!'
    vim.cmd 'normal! zR'
    fold_markdown_headings { 6, 5, 4, 3, 2, 1 }
    vim.cmd 'normal! zz'
  end, { desc = '[OM] Fold all headings level 1+' }),

  vim.keymap.set('n', '<leader>om2', function()
    vim.cmd 'silent update'
    vim.cmd 'edit!'
    vim.cmd 'normal! zR'
    fold_markdown_headings { 6, 5, 4, 3, 2 }
    vim.cmd 'normal! zz'
  end, { desc = '[OM] Fold all headings level 2+' }),

  vim.keymap.set('n', '<leader>om3', function()
    vim.cmd 'silent update'
    vim.cmd 'edit!'
    vim.cmd 'normal! zR'
    fold_markdown_headings { 6, 5, 4, 3 }
    vim.cmd 'normal! zz'
  end, { desc = '[OM] Fold all headings level 3+' }),

  vim.keymap.set('n', '<leader>om4', function()
    vim.cmd 'silent update'
    vim.cmd 'edit!'
    vim.cmd 'normal! zR'
    fold_markdown_headings { 6, 5, 4 }
    vim.cmd 'normal! zz'
  end, { desc = '[OM] Fold all headings level 4+' }),

  vim.keymap.set('n', '<leader>omu', function()
    vim.cmd 'silent update'
    vim.cmd 'edit!'
    vim.cmd 'normal! zR'
    vim.cmd 'normal! zz'
  end, { desc = '[OM] Unfold all headings' }),

  vim.keymap.set('n', '<leader>omt', function()
    local line = vim.fn.line '.'
    if vim.fn.foldlevel(line) == 0 then
      vim.notify('No fold found', vim.log.levels.INFO)
    else
      vim.cmd 'normal! za'
      vim.cmd 'normal! zz'
    end
  end, { desc = '[OM] Toggle fold under cursor' }),

  vim.keymap.set('n', '<leader>omp', function()
    vim.cmd 'silent update'
    vim.cmd 'normal gk'
    vim.cmd 'normal! za'
    vim.cmd 'normal! zz'
  end, { desc = '[OM] Fold previous heading' }),

  -------------------------------------------------------------------------------
  --                         End Folding section
  -------------------------------------------------------------------------------
}
