local u = require 'utils'

return {
  'Shatur/neovim-ayu',
  lazy = false,
  priority = 1000,
  config = function()
    _G.transparent = true
    _G.update_colors = function()
      local main = '#0f141a'
      local panel = '#212733'

      if _G.transparent then
        main = 'NONE'
        panel = 'NONE'
      end

      require('ayu').setup {
        mirage = false,
        overrides = function()
          return {
            Normal = { fg = '#c8d3f5', bg = main },
            SpecialKey = { fg = '#497ce3', bg = main },
            Comment = { fg = '#888888', bg = main },
            NormalFloat = { bg = panel },
            LineNr = { fg = '#bbbbbb' },
            LineNrAbove = { fg = '#888888' },
            LineNrBelow = { fg = '#888888' },
            NeoTreeCursorLine = { bg = panel },
            SignColumn = { bg = main },
            TabLineSel = { bg = main },
            TabLineFill = { bg = main },
            CursorLineNr = { bg = main, bold = true },
            StatusLine = { bg = main },
            StatusLineNC = { bg = main },
          }
        end,
      }
      vim.cmd.colorscheme 'ayu'
      vim.o.fillchars = 'eob: '
    end

    _G.update_colors()

    u.map('n', '<leader>bg', '<cmd>lua _G.transparent = not _G.transparent; _G.update_colors()<CR>', u.opts 'Toogle background transparency')
  end,
}
