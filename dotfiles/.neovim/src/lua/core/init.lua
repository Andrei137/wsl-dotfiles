local core_dir = vim.fn.stdpath("config") .. "/lua/core"

for _, file in ipairs(vim.fn.readdir(core_dir)) do
  if file:match("%.lua$") and file ~= "init.lua" then
    local module_name = "core." .. file:gsub("%.lua$", "")
    require(module_name)
  end
end
