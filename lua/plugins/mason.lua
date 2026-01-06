require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  log_level = vim.log.levels.INFO,
})

require("mason-lspconfig").setup({
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
  automatic_installation = false,
})
