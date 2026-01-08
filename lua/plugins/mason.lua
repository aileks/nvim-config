return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    event = { "BufReadPre", "BufNewFile" },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "clang-format",
        "prettier",
        "stylua",
        "shfmt",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      log_level = vim.log.levels.INFO,
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = true,
    opts = {
      ensure_installed = {
        "lua_ls",
        "tinymist",
        "marksman",
        "jsonls",
        "copilot",
        "rust_analyzer",
        "clangd",
        "zls",
      },
      automatic_installation = true,
    },
  },
}
