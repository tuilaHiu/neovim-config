local M = {}

local tools = {
  "pylint",
  "pylyzer",
  "pyproject-fmt",
  "pyright",
  "python-lsp-server",
  "ruff",
}

function M.setup()
  local ok, mason_registry = pcall(require, "mason-registry")
  if not ok then
    vim.notify("mason-registry not available", vim.log.levels.ERROR)
    return
  }

  for _, name in ipairs(tools) do
    local pkg_ok, pkg = pcall(mason_registry.get_package, name)
    if pkg_ok and not pkg:is_installed() then
      pkg:install()
    end
  end
end

return M
