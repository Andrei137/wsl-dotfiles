require 'core.keymaps'
require 'core.options'

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require('lazy').setup((function()
  local plugins = {}
  local plugins_dir = vim.fn.stdpath 'config' .. '/lua/plugins/'

  for _, file in ipairs(vim.fn.glob(plugins_dir .. '**/*.lua', false, true)) do
    local relative_path = file:sub(#plugins_dir + 1, -5)
    local ok, plugin = pcall(require, 'plugins.' .. relative_path:gsub('/', '.'))
    if ok then
      table.insert(plugins, plugin)
    end
  end
  return plugins
end)())