local m = (function(modes)
  local mod_table = {}

  local function helper(combo, start)
    for i = start, #modes do
      local new_combo = combo .. modes[i]
      local value = {}
      for c in new_combo:gmatch(".") do
        table.insert(value, c)
      end
      mod_table[new_combo] = (#value == 1) and value[1] or value
      helper(new_combo, i + 1)
    end
  end

  helper("", 1)
  return mod_table
end)({ "n", "v", "i", "t" })

local map = vim.keymap.set
local function mapn(mode, lhs, rhs, desc)
  -- non recursive silent map
  map(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Leader key
map(m.nv, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable keys
mapn(m.nvit, "<Left>", "<Nop>", "Left is disabled")
mapn(m.nvit, "<Down>", "<Nop>", "Down is disabled")
mapn(m.nvit, "<Up>", "<Nop>", "Up is disabled")
mapn(m.nvit, "<Right>", "<Nop>", "Right is disabled")
mapn(m.nvit, "<F1>", "<Nop>", "F1 is disabled")

-- Remaps
mapn(m.n, "x", "\"_x", "Delete without copy")
mapn(m.v, "p", "\"_dP", "Keep last yanked on paste")
mapn(m.v, "<", "<gv", "Shift left")
mapn(m.v, ">", ">gv", "Shift right")
mapn(m.i, "<C-h>", "<C-w>", "Delete word")


-- Save
map(m.n, "<C-s>", function()
  if #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) > 0 then
    vim.notify("Errors! Cannot save!", vim.log.levels.ERROR)
    return
  end
  vim.cmd("write")
end, { desc = "Save file (only if no errors)" })

mapn(m.n, "<leader>sn", "<cmd>noautocmd w <CR>", "Save without formatting")

-- Quit
mapn(m.ni, "<C-q>", "<cmd> q <CR>", "Quit file")
mapn(m.ni, "<C-Q>", "<cmd> q! <CR>", "Quit without saving")

-- Move in insert mode
mapn(m.i, "<C-h>", "<Left>", "Move left")
mapn(m.i, "<C-j>", "<Down>", "Move down")
mapn(m.i, "<C-k>", "<Up>", "Move up")
mapn(m.i, "<C-l>", "<Right>", "Move right")
mapn(m.i, "<C-e>", "<End>", "Move end of line")
mapn(m.i, "<C-b>", "<ESC>^i", "Move beginning of line")

-- Center on motion
mapn(m.n, "<C-d>", "<C-d>zz", "Center down")
mapn(m.n, "<C-u>", "<C-u>zz", "Center up")
mapn(m.n, "n", "nzzzv", "Center next search")
mapn(m.n, "N", "Nzzzv", "Center previous search")

-- Buffers
mapn(m.n, "<Tab>", ":bnext<CR>", "Next buffer")
mapn(m.n, "<S-Tab>", ":bprevious<CR>", "Previous buffer")
mapn(m.n, "<leader>x", ":bdelete!<CR>", "Close buffer")
mapn(m.n, "<leader>b", "<cmd> enew <CR>", "New buffer")

-- Windows
mapn(m.n, "<leader>v", "<C-w>v", "Split window vertically")
mapn(m.n, "<leader>h", "<C-w>s", "Split window horizontally")
mapn(m.n, "<leader>se", "<C-w>=", "Equalize windows")
mapn(m.n, "<leader>xs", ":close<CR>", "Close current window")

-- Splits
mapn(m.n, "<C-h>", ":wincmd h<CR>", "Focus left split")
mapn(m.n, "<C-j>", ":wincmd j<CR>" , "Focus lower split")
mapn(m.n, "<C-k>", ":wincmd k<CR>", "Focus upper split")
mapn(m.n, "<C-l>", ":wincmd l<CR>", "Focus right split")

-- Tabs
mapn(m.n, "<leader>to", ":tabnew<CR>", "New tab")
mapn(m.n, "<leader>tx", ":tabclose<CR>", "Close tab")
mapn(m.n, "<leader>tn", ":tabn<CR>", "Next tab")
mapn(m.n, "<leader>tp", ":tabp<CR>", "Previous tab")

-- Line wrapping
mapn(m.n, "<leader>lw", "<cmd>set wrap!<CR>", "Toggle wrapping")

-- Diagnostic keymap
map(m.n, "[d", function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = "Go to previous diagnostic message" })

map(m.n, "]d", function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = "Go to next diagnostic message" })

map(m.n, "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map(m.n, "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

map(m.n, "K", function()
  local windows = vim.api.nvim_list_wins()
  for _, win in ipairs(windows) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      vim.api.nvim_win_close(win, true)
      return
    end
  end
  vim.lsp.buf.hover()
end, { desc = "Toggle hover" })
