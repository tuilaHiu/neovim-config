
-- =========================================================
-- 🧠 NEOVIM DUAL-MODE CONFIG  —  hoạt động tốt cả trong VSCode
-- =========================================================
-- Kiểm tra môi trường VSCode
local is_vscode = vim.g.vscode ~= nil

vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- -----------------------
-- CÀI ĐẶT CƠ BẢN
-- -----------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- -----------------------
-- KEYMAP CƠ BẢN
-- -----------------------
local map = vim.keymap.set
map("i", "jk", "<Esc>", { desc = "Thoát insert mode" })
map("n", "<leader>w", ":w<CR>", { desc = "Lưu file" })
map("n", "<leader>q", ":q<CR>", { desc = "Thoát" })
map("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear highlight" })

-- -----------------------
-- LAZY.NVIM PLUGIN MANAGER
-- -----------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- -----------------------
-- DANH SÁCH PLUGIN
-- -----------------------
require("lazy").setup({
  
{
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    vim.g.VM_leader = '\\'  -- optional: nếu bạn muốn leader riêng cho visual-multi
    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>",      -- select next occurrence
      ["Find Subword Under"] = "<C-n>",
      ["Select All"] = "<C-A>",      -- select all occurrences
      ["Skip"] = "<C-x>",            -- skip current occurrence
      ["Remove Region"] = "<C-p>",   -- remove current region
    }
  end,
}

  -- UI
  { "nvim-lualine/lualine.nvim", config = function()
      require("lualine").setup({ options = { theme = "auto", icons_enabled = true } })
    end },
  { "nvim-tree/nvim-web-devicons" },

  -- Treesitter: highlight, folding
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
    end },

  -- Telescope: fuzzy finder
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local t = require("telescope.builtin")
      map("n", "<leader>ff", t.find_files, { desc = "Tìm file" })
      map("n", "<leader>fg", t.live_grep, { desc = "Tìm nội dung" })
      map("n", "<leader>fb", t.buffers, { desc = "Tìm buffer" })
    end },

  -- Comment & Surround
  { "numToStr/Comment.nvim", config = function() require("Comment").setup() end },
  { "tpope/vim-surround" },

  -- Gitsigns (hiển thị thay đổi git bên lề)
  { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end },

  -- LSP & Completion
  { "williamboman/mason.nvim", build = ":MasonUpdate",
    config = function() require("mason").setup() end },
  { "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.pyright.setup({})
      lspconfig.lua_ls.setup({
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })
    end },
  { "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end },
})

-- -----------------------
-- CHỈ KÍCH HOẠT CÁC TÍNH NĂNG NÀY KHI KHÔNG Ở VSCode
-- -----------------------
if not is_vscode then
  -- File explorer nhanh
  map("n", "<leader>e", ":Ex<CR>", { desc = "Explorer" })
  -- Terminal bên trong Neovim
  map("n", "<leader>t", ":split | terminal<CR>", { desc = "Terminal" })
end

-- Thông báo load xong
vim.schedule(function()
  print("✅ Neovim dual-mode config loaded!")
end)
