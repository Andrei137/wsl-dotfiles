return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      cpp = { 'cppcheck', 'clangtidy' },
    }

    lint.linters.markdownlint.args = {
      '--fix',
      '--disable',
      'MD013',
      '--',
    }

    local function safe_try_lint()
      local ft = vim.bo.filetype
      local linters = lint.linters_by_ft[ft]
      if not linters then
        return
      end

      local available = {}
      for _, linter in ipairs(linters) do
        local cmd = lint.linters[linter] and lint.linters[linter].cmd or linter
        if vim.fn.executable(cmd) == 1 then
          table.insert(available, linter)
        end
      end

      if #available > 0 then
        lint.try_lint(available)
      end
    end

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged', 'TextChangedI' }, {
      group = lint_augroup,
      callback = function()
        vim.diagnostic.reset(nil, 0)
        safe_try_lint()
      end,
    })
  end,
}
