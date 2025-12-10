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

require("mason-nvim-dap").setup({
  ensure_installed = {
    "delve",
    "codelldb",
  },
  automatic_installation = true,
})

require("mason-tool-installer").setup({
  ensure_installed = {
    "golangci-lint",
    "gopls",
    "gofumpt",
    "revive",
    "shellcheck",
    "shfmt",
    "lua-language-server",
    "stylua",
    "tinymist",
    "tailwindcss-language-server",
    "css-lsp",
    "emmet-ls",
    "marksman",
    "json-lsp",
    "typescript-language-server",
    "rust-analyzer",
    "clangd",
    "clang-format",
  },
  run_on_start = true,
  start_delay = 3000,
  debounce_hours = 8,
  auto_update = true,
  integrations = {
    ["mason-lspconfig"] = true,
    ["mason-nvim-dap"] = true,
  },
})
