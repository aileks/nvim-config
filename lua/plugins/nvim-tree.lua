return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
          git_ignored = true,
          custom = { "^\\.git$" },
        },
        git = {
          enable = true,
          ignore = false,
          show_on_dirs = true,
          show_on_open_dirs = true,
          timeout = 400,
        },
      })
      
      vim.keymap.set("n", "<leader>eg", function()
        require("nvim-tree.api").tree.toggle_gitignore_filter()
      end, { desc = "Toggle gitignored files" })
    end,
  },
}

