-- Copy files contents, but copies folders path  vim.keymap.set('n', '<leader>ducz', function()
vim.keymap.set('n', '<leader>ducz', function()
  local MiniFiles = require 'mini.files'
  local rawPath = vim.fn.expand '%:p'
  local filePath

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
    -- Zip folder to temp path
    local zip_path = '/tmp/zipped_folder_' .. os.time() .. '.zip'
    local zip_cmd = { 'zip', '-r', zip_path, filePath }
    vim.fn.jobstart(zip_cmd, {
      on_exit = function()
        vim.fn.setreg('+', zip_path)
        vim.notify('📦 Folder zipped & path copied: ' .. zip_path)
      end,
    })
  else
    -- Copy file contents
    vim.fn.jobstart({ 'cat', filePath }, {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data then
          vim.fn.setreg('+', table.concat(data, '\n'))
          vim.notify('📄 File contents copied: ' .. filePath)
        end
      end,
    })
  end
end, { desc = 'Copy file/folder content or zip' })
