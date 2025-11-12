return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre", "BufNewFile" },
		cmd = { "ConformInfo" },
		dependencies = {
			"williamboman/mason.nvim",
			"zapling/mason-conform.nvim",
		},
		config = function()
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
					xml = { "xmlformatter" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				notify_on_error = true,
				notify_no_formatters = true,
			})
			require("mason-conform").setup({
				ensure_installed = {
					"stylua",
					"shfmt",
					"prettier",
					"google-java-format",
					"xmlformatter",
				},
			})
		end,
	},
}
