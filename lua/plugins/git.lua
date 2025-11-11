return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>",                  desc = "LazyGit" },
      { "<leader>gc", "<cmd>LazyGitCurrentFile<cr>",       desc = "LazyGit Current File" },
      { "<leader>gf", "<cmd>LazyGitFilter<cr>",            desc = "LazyGit Filter" },
      { "<leader>gF", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit Filter Current File" },
    },
  },
}
