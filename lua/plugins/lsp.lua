return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "mfussenegger/nvim-jdtls",
      "pmizio/typescript-tools.nvim",
    },
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if cmp_nvim_lsp_ok then
        capabilities = cmp_nvim_lsp.default_capabilities()
      end

      local on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", bufopts, { desc = "LSP Declaration" }))
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", bufopts, { desc = "LSP Definition" }))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "LSP Hover" }))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", bufopts, { desc = "LSP Implementation" }))
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", bufopts, { desc = "LSP Signature Help" }))
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", bufopts, { desc = "LSP Add Workspace Folder" }))
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", bufopts, { desc = "LSP Remove Workspace Folder" }))
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, vim.tbl_extend("force", bufopts, { desc = "LSP List Workspace Folders" }))
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, vim.tbl_extend("force", bufopts, { desc = "LSP Type Definition" }))
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "LSP Rename" }))
        vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", bufopts, { desc = "LSP References" }))
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, vim.tbl_extend("force", bufopts, { desc = "LSP Format" }))
      end

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "jdtls",
          "ts_ls",
          "eslint",
          "jsonls",
        },
        automatic_installation = true,
        handlers = {
          function(server_name)
            local lspconfig = require("lspconfig")
            lspconfig[server_name].setup({
              capabilities = capabilities,
              on_attach = on_attach,
            })
          end,
          ["ts_ls"] = function()
            local lspconfig = require("lspconfig")
            local util = require("lspconfig.util")
            lspconfig.ts_ls.setup({
              capabilities = capabilities,
              on_attach = on_attach,
              root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
            })
          end,
          ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            local runtime_path = vim.split(package.path, ";")
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")
            
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              on_attach = on_attach,
              settings = {
                Lua = {
                  runtime = {
                    version = "LuaJIT",
                    path = runtime_path,
                  },
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
          end,
          ["jsonls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.jsonls.setup({
              capabilities = capabilities,
              on_attach = on_attach,
              settings = {
                json = {
                  validate = { enable = true },
                },
              },
            })
          end,
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local function setup_jdtls()
        local jdtls = require("jdtls")
        local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
        local workspace_dir = vim.fn.stdpath("data") .. "/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if cmp_nvim_lsp_ok then
          capabilities = cmp_nvim_lsp.default_capabilities()
        end

        local on_attach = function(client, bufnr)
          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", bufopts, { desc = "LSP Declaration" }))
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", bufopts, { desc = "LSP Definition" }))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "LSP Hover" }))
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", bufopts, { desc = "LSP Implementation" }))
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", bufopts, { desc = "LSP Signature Help" }))
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", bufopts, { desc = "LSP Add Workspace Folder" }))
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", bufopts, { desc = "LSP Remove Workspace Folder" }))
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, vim.tbl_extend("force", bufopts, { desc = "LSP List Workspace Folders" }))
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, vim.tbl_extend("force", bufopts, { desc = "LSP Type Definition" }))
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "LSP Rename" }))
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", bufopts, { desc = "LSP Code Action" }))
          vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", bufopts, { desc = "LSP References" }))
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, vim.tbl_extend("force", bufopts, { desc = "LSP Format" }))
        end

        local config = {
          cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",
            "-jar",
            vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
            "-configuration",
            jdtls_path .. "/config_mac",
            "-data",
            workspace_dir,
          },
          root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
          settings = {
            java = {
              eclipse = {
                downloadSources = true,
              },
              maven = {
                downloadSources = true,
              },
              implementationsCodeLens = {
                enabled = true,
              },
              referencesCodeLens = {
                enabled = true,
              },
              references = {
                includeDecompiledSources = true,
              },
              format = {
                enabled = true,
              },
            },
          },
          init_options = {
            bundles = {},
          },
          on_attach = on_attach,
          capabilities = capabilities,
        }

        jdtls.start_or_attach(config)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = setup_jdtls,
      })
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if cmp_nvim_lsp_ok then
        capabilities = cmp_nvim_lsp.default_capabilities()
      end

      local on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", bufopts, { desc = "LSP Declaration" }))
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", bufopts, { desc = "LSP Definition" }))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "LSP Hover" }))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", bufopts, { desc = "LSP Implementation" }))
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", bufopts, { desc = "LSP Signature Help" }))
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", bufopts, { desc = "LSP Add Workspace Folder" }))
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", bufopts, { desc = "LSP Remove Workspace Folder" }))
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, vim.tbl_extend("force", bufopts, { desc = "LSP List Workspace Folders" }))
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, vim.tbl_extend("force", bufopts, { desc = "LSP Type Definition" }))
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "LSP Rename" }))
        vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", bufopts, { desc = "LSP References" }))
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, vim.tbl_extend("force", bufopts, { desc = "LSP Format" }))
      end

      require("typescript-tools").setup({
        on_attach = on_attach,
        capabilities = capabilities,
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
    end,
  },
}
