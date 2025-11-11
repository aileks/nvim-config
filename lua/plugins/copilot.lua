return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.keymap.set("i", "<C-y>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false, desc = "Copilot Accept" })
      vim.keymap.set("i", "<C-n>", "<Plug>(copilot-next)", { desc = "Copilot Next" })
      vim.keymap.set("i", "<C-p>", "<Plug>(copilot-previous)", { desc = "Copilot Previous" })
      vim.keymap.set("i", "<C-o>", "<Plug>(copilot-dismiss)", { desc = "Copilot Dismiss" })
      vim.keymap.set("i", "<C-s>", "<Plug>(copilot-suggest)", { desc = "Copilot Suggest" })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("CopilotChat").setup({
        model = 'claude-sonnet-4.5',
        temperature = 0.1,
        window = {
          layout = 'vertical',
          width = 0.3,
        },
        auto_insert_mode = true, 
      })
    end,
    keys = {
      { "<leader>a", "<cmd>CopilotChat<cr>", desc = "Copilot Chat" },
      { "<leader>at", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat Toggle" },
      { "<leader>ax", "<cmd>CopilotChatReset<cr>", desc = "Copilot Chat Reset" },
      { "<leader>as", "<cmd>CopilotChatSave<cr>", desc = "Copilot Chat Save" },
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Copilot Explain" },
      { "<leader>af", "<cmd>CopilotChatFix<cr>", desc = "Copilot Fix" },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Copilot Review" },
      { "<leader>aT", "<cmd>CopilotChatTests<cr>", desc = "Copilot Tests" },
      { "<leader>ae", ":CopilotChatExplain<cr>", desc = "Copilot Explain", mode = "v" },
      { "<leader>af", ":CopilotChatFix<cr>", desc = "Copilot Fix", mode = "v" },
      { "<leader>ar", ":CopilotChatReview<cr>", desc = "Copilot Review", mode = "v" },
      { "<leader>ac", "<cmd>CopilotChatCommit<cr>", desc = "Copilot Commit" },
      { "<leader>aC", "<cmd>CopilotChatCommitStaged<cr>", desc = "Copilot Commit Staged" },
    },
  },
}

