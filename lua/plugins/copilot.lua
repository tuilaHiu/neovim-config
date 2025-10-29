local M = {}
function M.setup()
  vim.g.copilot_no_tab_map = true
  vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
  vim.g.copilot_filetypes = {
    ["*"] = true,
    ["markdown"] = false,
    ["text"] = false,
  }
end
return M
