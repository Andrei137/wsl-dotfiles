return {
  'junnplus/lsp-setup.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
  },
  opts = {
    servers = {},
  },
  config = function()
    require('lazydev').setup()
    require('lsp-setup').setup {
      default_mappings = true,
      on_attach = function(client, bufnr) end,
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              hint = {
                enable = true,
              },
              completion = {
                callSnippet = 'Replace',
              },
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                  '${3rd}/luv/library',
                },
              },
              diagnostics = {
                globals = { 'vim' },
                disable = { 'missing-fields' },
              },
              format = {
                enable = false,
              },
            },
          },
        },
      },
      formatting = {
        on_save = false,
      },
    }
  end,
}

