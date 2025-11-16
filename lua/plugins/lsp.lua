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
  lsp_on_attach = function(_, bufnr)
    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    local function nmap(lhs, rhs, opts)
      map("n", lhs, rhs, opts)
    end

    nmap("K", vim.lsp.buf.hover, { desc = "Hover" })
    nmap("gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
    nmap("gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
    nmap("gi", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
    nmap("gr", vim.lsp.buf.references, { desc = "References" })
    nmap("<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
    nmap("<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
    nmap("<leader>e", ":Oil<CR>", { silent = true, desc = "Oil" })
  end,
  dap_debug = true,
  dap_debug_gui = true,
  test_runner = "go",
  run_in_floaterm = false,
  verbose = false,
})
