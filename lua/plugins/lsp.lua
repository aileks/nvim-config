vim.lsp.config.rust_analyzer = {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json" },
}

vim.lsp.enable({
  "lua_ls",
  "cssls",
  "tinymist",
  "tailwindcss",
  "emmet_ls",
  "marksman",
  "gopls",
  "jsonls",
  "postgres-language-server",
  "pyright",
  "rust_analyzer",
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
  lsp_gofumpt = false,
  lsp_cfg = {
    settings = {
      gopls = {
        staticcheck = true,
        analyses = {
          unusedparams = true,
          nilness = true,
          shadow = true,
        },
        gofumpt = false,
        usePlaceholders = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  dap_debug = true,
  dap_debug_gui = true,
  test_runner = "go",
  run_in_floaterm = false,
  linters = {
    enable = true,
    golangci_lint = {
      enable = true,
    },
  },
  lsp_on_attach = function(_, bufnr)
    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    map("n", "<leader>li", "<cmd>GoImport<CR>")
    map("n", "<leader>la", "<cmd>GoCodeAction<CR>")
    map("n", "<leader>lf", function()
      require("go.format").goimports()
    end)
    map("n", "<leader>gt", "<cmd>GoTest<CR>")
    map("n", "<leader>gr", "<cmd>GoRun<CR>")
    map("n", "<leader>ge", "<cmd>GoIfErr<CR>")

    map("n", "<leader>e", function()
      require("snacks").explorer()
    end, { silent = true })
  end,
  verbose = false,
})
