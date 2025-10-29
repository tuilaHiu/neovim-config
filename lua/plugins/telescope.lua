local M = {}
function M.setup()
  local t = require("telescope.builtin")
  vim.keymap.set("n", "<leader>ff", t.find_files, { desc = "Tìm file" })
  vim.keymap.set("n", "<leader>fg", t.live_grep, { desc = "Tìm nội dung" })
  vim.keymap.set("n", "<leader>fb", t.buffers, { desc = "Tìm buffer" })
end
return M
