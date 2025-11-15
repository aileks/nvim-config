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

local config = {
  cmd = { "jdtls" },
  root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw" }),
  capabilities = require("blink.cmp").get_lsp_capabilities(),
  settings = {
    java = {
      signatureHelp = { enabled = true },
    },
  },
}
require("jdtls").start_or_attach(config)
local jdtls_config = {
  bundles = {},
}
vim.list_extend(jdtls_config.bundles, require("spring_boot").java_extensions())

-- Fixes lua_ls warnings in nvim config files
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
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

