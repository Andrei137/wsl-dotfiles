return {
  "leath-dub/snipe.nvim",
  keys = {
    {
      "<A-q>",
      function()
        require("snipe").open_buffer_menu()
      end,
      desc = "Open Snipe buffer menu",
    },
  },
  config = function()
    local snipe = require("snipe")
    snipe.setup({
      hints = {
        dictionary = "1234567890asfghl;wertyuiop",
      },
      navigate = {
        cancel_snipe = "<esc>",
        close_buffer = "d",
      },
      sort = "default",
    })
  end,
}