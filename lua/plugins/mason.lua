require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("mason-tool-installer").setup({
  ensure_installed = {
    "jdtls",
    "golangci-lint",
    "gopls",
    "staticcheck",
    "revive",
    "shellcheck",
    "shfmt",
    "lua_ls",
    "stylua",
    "tinymist",
    "tailwindcss",
    "cssls",
    "emmet_ls",
    "marksman",
    "jsonls",
    "ts_ls",
  },
  run_on_start = true,
  start_delay = 2000,
  debounce_hours = 8,
  integrations = {
    ["mason-lspconfig"] = true,
    ["mason-nvim-dap"] = true,
  },
})
