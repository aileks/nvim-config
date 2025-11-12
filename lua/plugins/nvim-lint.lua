return {
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            local lint = require("lint")
            local mason_registry = require("mason-registry")
            local linters = { "eslint_d", "checkstyle" }
            for _, linter in ipairs(linters) do
                local p = mason_registry.get_package(linter)
                if not p:is_installed() then
                    p:install()
                end
            end

            lint.linters_by_ft = {
                typescript = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                javascript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                java = { "checkstyle" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
}
