local u = require 'utils'

-- Leader key
u.map("nv", '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable keys
u.map("nvit", '<Left>', '<Nop>', u.opts 'Left is disabled')
u.map("nvit", '<Down>', '<Nop>', u.opts 'Down is disabled')
u.map("nvit", '<Up>', '<Nop>', u.opts 'Up is disabled')
u.map("nvit", '<Right>', '<Nop>', u.opts 'Right is disabled')
u.map("nvit", '<F1>', '<Nop>', u.opts 'F1 is disabled')

-- Remaps
u.map("n", 'x', '"_x', u.opts 'Delete without copy')
u.map("v", 'p', '"_dP', u.opts 'Keep last yanked on paste')
u.map("v", '>', '>gv', u.opts 'Shift right')
u.map("v", '<', '<gv', u.opts 'Shift left')
u.map("i", '<C-h>', '<C-w>', u.opts 'Delete word')
u.map("v", 'J', ":m '>+1<CR>gv=gv", { silent = true })
u.map("v", 'K', ":m '<-2<CR>gv=gv", { silent = true })

-- Save
u.map("n", '<C-s>', function()
  vim.cmd 'Format'
  vim.cmd 'write'
end, { desc = 'Save file)' })

-- Format
u.map("n", '<C-f>', ':Format <CR>', u.opts 'Format')

-- Quit
u.map("ni", '<C-q>', ':q <CR>', u.opts 'Quit file')
u.map("ni", '<C-Q>', ':q! <CR>', u.opts 'Quit without saving')

-- Move in insert mode
u.map("i", '<C-h>', '<Left>', u.opts 'Move left')
u.map("i", '<C-j>', '<Down>', u.opts 'Move down')
u.map("i", '<C-k>', '<Up>', u.opts 'Move up')
u.map("i", '<C-l>', '<Right>', u.opts 'Move right')
u.map("i", '<C-e>', '<End>', u.opts 'Move end of line')
u.map("i", '<C-b>', '<ESC>^i', u.opts 'Move beginning of line')

-- Center on motion
u.map("n", '<C-d>', '<C-d>zz', u.opts 'Center down')
u.map("n", '<C-u>', '<C-u>zz', u.opts 'Center up')
u.map("n", 'n', 'nzzzv', u.opts 'Center next search')
u.map("n", 'N', 'Nzzzv', u.opts 'Center previous search')

-- Buffers
u.map("n", '<Tab>', ':bnext<CR>', u.opts 'Next buffer')
u.map("n", '<S-Tab>', ':bprevious<CR>', u.opts 'Previous buffer')
u.map("n", '<leader>x', ':bdelete!<CR>', u.opts 'Close buffer')
u.map("n", '<leader>b', ':enew <CR>', u.opts 'New buffer')

-- Windows
u.map("n", '<leader>v', '<C-w>v', u.opts 'Split window vertically')
u.map("n", '<leader>h', '<C-w>s', u.opts 'Split window horizontally')
u.map("n", '<leader>se', '<C-w>=', u.opts 'Equalize windows')
u.map("n", '<leader>xs', ':close<CR>', u.opts 'Close current window')

-- Splits
u.map("n", '<C-h>', ':wincmd h<CR>', u.opts 'Focus left split')
u.map("n", '<C-j>', ':wincmd j<CR>', u.opts 'Focus lower split')
u.map("n", '<C-k>', ':wincmd k<CR>', u.opts 'Focus upper split')
u.map("n", '<C-l>', ':wincmd l<CR>', u.opts 'Focus right split')

-- Tabs
u.map("n", '<leader>to', ':tabnew<CR>', u.opts 'New tab')
u.map("n", '<leader>tx', ':tabclose<CR>', u.opts 'Close tab')
u.map("n", '<leader>tn', ':tabn<CR>', u.opts 'Next tab')
u.map("n", '<leader>tp', ':tabp<CR>', u.opts 'Previous tab')

-- Line wrapping
u.map("n", '<leader>lw', '<cmd>set wrap!<CR>', u.opts 'Toggle wrapping')

-- Diagnostic keymap
u.map("n", '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

u.map("n", ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

u.map("n", '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
u.map("n", '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

u.map("n", 'K', function()
  local windows = vim.api.nvim_list_wins()
  for _, win in ipairs(windows) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= '' then
      vim.api.nvim_win_close(win, true)
      return
    end
  end
  vim.lsp.buf.hover()
end, { desc = 'Toggle hover' })
