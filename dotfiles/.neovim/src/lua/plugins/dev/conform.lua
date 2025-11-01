local u = require "utils"

return {
	"stevearc/conform.nvim",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason-tool-installer").setup {
			ensure_installed = {
				"clang-format",
				"codespell",
				"eslint_d",
				"fixjson",
				"jq",
				-- "markdownlint-cli2",
				"mdformat",
				"prettierd",
				"ruff",
				"shellcheck",
				"stylua",
				"tombi",
			},
			auto_update = false,
			run_on_start = true,
		}

		local conform = require "conform"
		conform.setup {
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shellcheck" },
				dockerfile = { "dockerfmt" },
				cpp = { "clang-format" },
				html = { "prettierd" },
				css = { "prettierd" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				markdown = { "mdformat" },
				json = { "fixjson", "jq" },
				yaml = { "prettierd" },
				toml = { "tombi" },
				["*"] = { "codespell" },
			},
			formatters = {
				["clang-format"] = {
					args = { "--style={BasedOnStyle:: 4, TabWidth: 4, UseTab: Never}" },
				},
			},
		}

		u.command("Format", function()
			conform.format { async = false }
		end, "Format buffer")

		u.command("ShowFormatters", function()
			local bufnr = vim.api.nvim_get_current_buf()
			local formatters = conform.list_formatters_for_buffer(bufnr)

			if formatters and #formatters > 0 then
				vim.notify(table.concat(formatters, "\n"), vim.log.levels.INFO, { title = "Conform.nvim" })
			else
				vim.notify("No formatters active for this buffer", vim.log.levels.WARN, { title = "Conform.nvim" })
			end
		end, "Show active formatters for current buffer")
	end,
}
