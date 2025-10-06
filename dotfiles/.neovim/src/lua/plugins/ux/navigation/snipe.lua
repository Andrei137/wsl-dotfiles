return {
  'leath-dub/snipe.nvim',
  keys = {
    {
      "\\",
      function()
        require('snipe').open_buffer_menu()
      end,
      desc = 'Open Snipe buffer menu',
    },
  },
  config = function()
    local snipe = require 'snipe'
    snipe.setup {
      hints = {
        dictionary = 'asfghl;wertyuiop',
      },
      navigate = {
        cancel_snipe = "\\",
        close_buffer = 'd',
      },
      sort = 'default',
    }
  end,
}
