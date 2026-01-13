return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason.nvim",
    "mason-lspconfig.nvim",
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, blink = pcall(require, "blink.cmp")
    if ok then
      capabilities = blink.get_lsp_capabilities(capabilities)
    end

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    })

    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = { command = "clippy" },
          cargo = { allFeatures = true },
          procMacro = { enable = true },
          inlayHints = {
            bindingModeHints = { enable = true },
            chainingHints = { enable = true },
            closingBraceHints = { enable = true },
            closureReturnTypeHints = { enable = "always" },
            lifetimeElisionHints = { enable = "always" },
            parameterHints = { enable = true },
            typeHints = { enable = true },
          },
        },
      },
    })

    vim.lsp.config("zls", {
      settings = {
        zls = {
          enable_inlay_hints = true,
          inlay_hints_exclude_single_argument = true,
          enable_snippets = true,
          warn_style = true,
        },
      },
    })

    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--offset-encoding=utf-16",
      },
    })

    vim.lsp.enable({
      "lua_ls",
      "tinymist",
      "marksman",
      "jsonls",
      "rust_analyzer",
      "clangd",
      "zls",
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

    vim.diagnostic.config({
      virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN },
        source = "always",
      },
      float = { border = "rounded" },
    })
  end,
}
