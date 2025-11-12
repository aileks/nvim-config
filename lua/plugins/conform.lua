return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre", "BufNewFile" },
		cmd = { "ConformInfo" },
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			-- Ensure formatters are installed via Mason
			local mason_registry = require("mason-registry")
			local formatters = { "stylua", "shfmt", "prettier", "google-java-format" }
			for _, formatter in ipairs(formatters) do
				local p = mason_registry.get_package(formatter)
				if not p:is_installed() then
					p:install()
				end
			end

			require("conform").setup({
				formatters = {
					["google-java-format"] = {
						prepend_args = { "--aosp" },
						args = { "--replace", "$FILENAME" },
						stdin = false,
						require_cwd = true,
					},
				},
				formatters_by_ft = {
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },
					lua = { "stylua" },
					sh = { "shfmt" },
					bash = { "shfmt" },
					zsh = { "shfmt" },
					java = { "google-java-format" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	},
}
