vim.lsp.enable({
  "lua_ls",
  "cssls",
  "tinymist",
  "tailwindcss",
  "emmet_ls",
  "marksman",
  "gopls",
  "jsonls",
})

vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
    source = "always",
  },
})

require("typescript-tools").setup({
  settings = {
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  },
})

require("go").setup({
  goimports = "gopls",
  gofmt = "gopls",
  lsp_cfg = true,
  lsp_gofumpt = true,
  lsp_on_attach = true,
  dap_debug = true,
  dap_debug_gui = true,
  test_runner = "go",
  run_in_floaterm = false,
  verbose = false,
})
