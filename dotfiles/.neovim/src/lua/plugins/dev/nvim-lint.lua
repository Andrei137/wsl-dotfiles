return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason-tool-installer").setup {
			ensure_installed = {
				"eslint_d",
				"hadolint",
				"htmlhint",
				"jsonlint",
				-- "markdownlint-cli2",
				"ruff",
				"shellcheck",
				"yamllint",
			},
			auto_update = false,
			run_on_start = true,
		}

		local lint = require "lint"
		lint.linters_by_ft = {
			sh = { "shellcheck" },
			dockerfile = { "hadolint" },
			cpp = { "cppcheck", "clangtidy" },
			html = { "tidy", "htmlhint" },
			css = { "stylelint" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			python = { "ruff" },
			-- markdown = { "markdownlint-cli2" },
			json = { "jsonlint" },
			yaml = { "yamllint" },
			["*"] = { "codespell" },
		}

		lint.linters["markdownlint-cli2"].args = {
			"--fix",
			"--disable",
			"MD013",
			"--",
		}

		local function safe_try_lint()
			local ft = vim.bo.filetype
			local linters = lint.linters_by_ft[ft]
			if not linters then
				return
			end

			local available = vim.tbl_filter(function(linter)
				local l = lint.linters[linter]
				if not l then
					return false
				end
				local cmd = l.cmd
				if type(cmd) == "string" then
					return vim.fn.executable(cmd) == 1
				elseif type(cmd) == "function" then
					return true
				end
				return false
			end, linters)

			if #available > 0 then
				lint.try_lint(available)
			end
		end

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = safe_try_lint,
		})

		vim.keymap.set("n", "<leader>l", safe_try_lint, { desc = "Trigger linting for current file" })
	end,
}
