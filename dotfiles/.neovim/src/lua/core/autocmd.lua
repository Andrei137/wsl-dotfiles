local u = require "utils"

u.autocmd({ "BufEnter", "WinEnter", "ModeChanged" }, function()
	local win = vim.api.nvim_get_current_win()
	local ft = vim.bo.filetype
	local bt = vim.bo.buftype

	if ft == "oil" then
		local path = vim.fn["luaeval"] "require('oil').get_current_dir()"
		path = vim.fn.substitute(path, "^" .. vim.env.HOME, "~", "")
		vim.api.nvim_set_option_value("winbar", "%#@attribute.builtin#" .. path, { scope = "local", win = win })
		return
	end

	local excluded_filetypes = { "toggleterm", "help", "lspinfo" }
	if bt ~= "" or vim.tbl_contains(excluded_filetypes, ft) then
		vim.api.nvim_set_option_value("winbar", nil, { scope = "local", win = win })
		return
	end

	local path = vim.fn.expand("%:p:h"):gsub(vim.fn.expand "$HOME", "~")
	local filename = vim.fn.expand "%:t"

	local winbar_text = string.format("%%#@attribute.builtin#%s/%s", path, filename)
	vim.api.nvim_set_option_value("winbar", winbar_text, { scope = "local", win = win })
end)
