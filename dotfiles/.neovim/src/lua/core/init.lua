for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/core")) do
  if file:match("%.lua$") and file ~= "init.lua" then
    local module_name = "core." .. file:gsub("%.lua$", "")
    require(module_name)
  end
end
