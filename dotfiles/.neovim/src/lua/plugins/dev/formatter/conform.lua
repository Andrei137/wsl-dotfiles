local u = require 'utils'

return {
  'stevearc/conform.nvim',
  config = function()
    local conform = require 'conform'
    conform.setup {
      formatters_by_ft = {
        cpp = { 'clang-format' },
        lua = { 'stylua' },
        json = { 'fixjson', 'jq' },
        html = { 'html_beautify' },
        css = { 'css_beautify' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
      },
      formatters = {
        ['clang-format'] = {
          args = { '--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}' },
        },
      },
    }

    u.command('Format', function()
      conform.format { async = false }
    end, 'Format buffer')

    u.command('ShowFormatters', function()
      local bufnr = vim.api.nvim_get_current_buf()
      local formatters = conform.list_formatters_for_buffer(bufnr)

      if formatters and #formatters > 0 then
        vim.notify(table.concat(formatters, '\n'), vim.log.levels.INFO, { title = 'Conform.nvim' })
      else
        vim.notify('No formatters active for this buffer', vim.log.levels.WARN, { title = 'Conform.nvim' })
      end
    end, 'Show active formatters for current buffer')
  end,
}
