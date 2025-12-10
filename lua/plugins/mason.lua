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

require("mason-registry").update()

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "cssls",
    "tinymist",
    "tailwindcss",
    "emmet_ls",
    "marksman",
    "gopls",
    "jsonls",
    " postgres_lsp",
    "pyright",
    "rust_analyzer",
    "clangd",
  },
  automatic_installation = false,
  automatic_enable = false,
})

require("mason-nvim-dap").setup({
  ensure_installed = {
    "delve",
    "codelldb",
  },
  automatic_installation = true,
})
