return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local show_gitignored = false
      
      local function setup_tree()
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
            git_clean = not show_gitignored,
          },
          git = {
            enable = true,
            ignore = false,
            show_on_dirs = true,
            show_on_open_dirs = true,
            timeout = 400,
          },
        })
      end
      
      setup_tree()
      
      vim.keymap.set("n", "<leader>eg", function()
        local api = require("nvim-tree.api")
        local view = require("nvim-tree.view")

        show_gitignored = not show_gitignored

        setup_tree()
        
        if view.is_visible() then
          api.tree.reload()
        end
      end, { desc = "Toggle gitignored files" })
    end,
  },
}

