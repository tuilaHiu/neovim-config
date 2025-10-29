-- =========================================
-- 🚀 Neovim AI IDE (Copilot + Codex Agent)
-- =========================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core
require("core.options")
require("core.keymaps")

-- Lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("plugins")

