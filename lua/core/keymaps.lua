local map = vim.keymap.set
map("i", "jk", "<Esc>", { desc = "Thoát insert mode" })
map("n", "<leader>w", ":w<CR>", { desc = "Lưu file" })
map("n", "<leader>q", ":q<CR>", { desc = "Thoát" })
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "File explorer" })
map("n", "<leader>t", ":split | terminal<CR>", { desc = "Terminal" })
map("v", "<Tab>", ">gv", { desc = "Indent selection" })
map("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })

