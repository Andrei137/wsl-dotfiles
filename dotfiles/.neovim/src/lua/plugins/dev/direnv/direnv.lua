return {
  'NotAShelf/direnv.nvim',
  lazy = false,
  config = function()
    require('direnv').setup {}
  end,
}
