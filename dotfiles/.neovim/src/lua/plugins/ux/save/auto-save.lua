return {
    "pocco81/auto-save.nvim",
    config = function()
        require("auto-save").setup({
            execution_message = {
                message = function()
                    return ("Saved at " .. vim.fn.strftime("%H:%M"))
                end,
                dim = 0.18,
                cleaning_interval = 1250,
            },
            condition = function()
                local errors = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                return #errors == 0
            end,
        })
    end,
}
