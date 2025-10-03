-- Make line numbers default
vim.wo.number = true

-- Set relative numbered lines
vim.o.relativenumber = true

-- Nerd Font installed
vim.g.have_nerd_font = true

-- Sync clipboard between OS and Neovim
vim.o.clipboard = 'unnamedplus'

-- Display lines as one long line
vim.o.wrap = false

-- Companion to wrap, don't split words
vim.o.linebreak = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Copy indent from current line when starting new one
vim.o.autoindent = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true

-- Smart case
vim.o.smartcase = true

-- The number of spaces inserted for each indentation
vim.o.shiftwidth = 4

-- Insert n spaces for a tab
vim.o.tabstop = 4

-- Number of spaces that a tab counts for while performing editing operations
vim.o.softtabstop = 4

-- Convert tabs to spaces
vim.o.expandtab = true

-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 4

-- Minimal number of screen columns either side of cursor if wrap is `false`
vim.o.sidescrolloff = 8

-- Only highlight the line number
vim.o.cursorline = true
vim.opt.cursorlineopt = 'number'

-- Force all horizontal splits to go below current window
vim.o.splitbelow = true

-- Force all vertical splits to go to the right of current window
vim.o.splitright = true

-- Set highlight on search
vim.o.hlsearch = false

-- We don't need to see things like -- INSERT -- anymore
vim.o.showmode = false

-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Which "horizontal" keys are allowed to travel to prev/next line
vim.o.whichwrap = 'bs<>[]hl'

-- Creates a swapfile
vim.o.swapfile = false

-- Make indenting smarter again
vim.o.smartindent = true

-- Always show tabs
vim.o.showtabline = 2

-- Pop up menu height
vim.o.pumheight = 10

-- So that `` is visible in markdown files
vim.o.conceallevel = 0

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Enable break indent
vim.o.breakindent = true

-- Decrease update time
vim.o.updatetime = 250

-- Time to wait for a mapped sequence to complete (in milliseconds)
vim.o.timeoutlen = 300

-- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.writebackup = false

-- Save undo history
vim.o.undofile = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Don't give |ins-completion-menu| messages
vim.opt.shortmess:append 'c'

-- Hyphenated words recognized by searches
vim.opt.iskeyword:append '-'

-- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.formatoptions:remove { 'c', 'r', 'o' }

-- Separate Vim plugins from Neovim in case Vim still in use
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles'

-- Diagnostic configuration
vim.diagnostic.config {
  virtual_text = true,
  virtual_lines = { current_line = true },
  underline = false,
  update_in_insert = false,
}
