local u = require 'utils'

u.autocmd({ 'BufEnter', 'ModeChanged' }, function()
  local excluded_filetypes = { 'oil', 'toggleterm', 'help', 'lspinfo' }
  local win = vim.api.nvim_get_current_win()

  if vim.tbl_contains(excluded_filetypes, vim.bo.filetype) or vim.bo.buftype ~= '' then
    vim.api.nvim_set_option_value('winbar', nil, { scope = 'local', win = win })
    return
  end

  vim.api.nvim_set_option_value(
    'winbar',
    vim.fn.expand('%:p:h'):gsub(vim.fn.expand '$HOME', '~') .. '%#WinBar3#/' .. vim.fn.expand '%:t',
    { scope = 'local', win = win }
  )
end)
