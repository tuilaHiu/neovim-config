local M = {}

function M.setup_tree()
  require("nvim-tree").setup({
    view = { width = 32 },
    renderer = {
      highlight_git = true,
      icons = { show = { file = true, folder = true, git = true } },
    },
  })
end

function M.setup_lualine()
  require("lualine").setup({ options = { theme = "auto" } })
end

return M
