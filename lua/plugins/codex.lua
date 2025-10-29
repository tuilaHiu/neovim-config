local M = {}

function M.setup()
  require("codex").setup({
    model = "gpt-4o-mini",
    temperature = 0.2,
    max_tokens = 2000,
    enable_popup = true,
    keymaps = {
      ask = "<leader>qa",
      edit = "<leader>qe",
      chat = "<leader>qc",
    },
    system_prompt = [[
      You are Codex, an expert AI code agent running inside Neovim.
      You can refactor, explain, or rewrite code when requested.
      Always preserve comments and improve clarity.
    ]],
  })
end

return M
