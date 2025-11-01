local u = require "utils"

u.command("Q", "q!", "Force quit")
u.command("Cwd", function()
	local buffer_path = vim.fn.expand "%:p:h"
	if buffer_path and buffer_path ~= "" then
		vim.api.nvim_set_current_dir(buffer_path)
		vim.notify(string.format("New cwd: %s", buffer_path))

		local envrc_path = buffer_path .. "/.envrc"
		local stat = vim.loop.fs_stat(envrc_path)
		if stat then
			vim.cmd "Direnv allow"
		end
	end
end, "Set buffer path as current working directory")
