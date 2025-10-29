local M = {}
function M.setup()
  local lspconfig = require("lspconfig")
  local servers = { "pyright", "lua_ls" }
  for _, s in ipairs(servers) do
    lspconfig[s].setup({})
  end
end
return M
