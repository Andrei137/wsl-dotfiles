vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.have_nerd_font = true
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.showmode = false
vim.wo.signcolumn = "yes"

vim.o.wrap = false
vim.o.linebreak = true
vim.o.whichwrap = "bs<>[]hl"

vim.o.autoindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.breakindent = true

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.o.scrolloff = 4
vim.o.sidescrolloff = 8

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.pumheight = 10
vim.o.conceallevel = 0

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.completeopt = "menuone"
vim.opt.shortmess:append "c"
vim.opt.iskeyword:append "-"
vim.opt.formatoptions:remove { "c", "r", "o" }
vim.opt.runtimepath:remove "/usr/share/vim/vimfiles"
vim.diagnostic.config {
  virtual_text = true,
  virtual_lines = { current_line = true },
  underline = false,
  update_in_insert = false,
}

vim.o.showtabline = 0
vim.api.nvim_create_autocmd({ "BufEnter", "ModeChanged" }, {
  callback = function()
    local excluded_filetypes = { "neo-tree", "NvimTree", "toggleterm", "help", "lspinfo" }
    local win = vim.api.nvim_get_current_win()
    local ft = vim.bo.filetype

    if vim.tbl_contains(excluded_filetypes, ft) or vim.bo.buftype ~= "" then
      vim.api.nvim_win_set_option(win, "winbar", nil)
      return
    end

    local path = vim.fn.expand("%:p:h"):gsub(vim.fn.expand("$HOME"), "~")
    local filename = vim.fn.expand("%:t")
    local bufcount = vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))

    vim.api.nvim_win_set_option(win, "winbar",
      "%#WinBar1#%m "
      .. "%#WinBar1#(" .. bufcount .. ") "
      .. "%#WinBar2#" .. path
      .. "%#WinBar3#/" .. filename
    )
  end,
})
