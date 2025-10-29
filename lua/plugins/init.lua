require("lazy").setup({
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-tree/nvim-tree.lua", config = require("plugins.ui").setup_tree },
  { "nvim-lualine/lualine.nvim", config = require("plugins.ui").setup_lualine },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = require("plugins.telescope").setup },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = require("plugins.treesitter").setup },
  { "lewis6991/gitsigns.nvim", config = require("plugins.git").setup },
  { "folke/which-key.nvim", config = true },
  { "williamboman/mason.nvim", config = require("plugins.mason").setup },
  { "neovim/nvim-lspconfig", config = require("plugins.lsp").setup },
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip" }, config = require("plugins.cmp").setup },
  { "github/copilot.vim", config = require("plugins.copilot").setup },
  { "johnseth97/codex.nvim", config = require("plugins.codex").setup },
})

