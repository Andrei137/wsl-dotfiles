return {
	"pocco81/auto-save.nvim",
	opts = {
		execution_message = {
			message = function()
				return ("Saved at " .. vim.fn.strftime "%H:%M")
			end,
			dim = 0.18,
			cleaning_interval = 750,
		},
		callback = function()
			vim.api.nvim_buf_call(0, function()
				vim.cmd "noautocmd write"
			end)
		end,
	},
}
