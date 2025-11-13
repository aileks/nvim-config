require("lazy").setup({
	{ import = "plugins.ui" },
	{ import = "plugins.lsp" },
	{ import = "plugins.conform" },
	{ import = "plugins.nvim-lint" },
	{ import = "plugins.completion" },
	{ import = "plugins.telescope" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.git" },
	{ import = "plugins.comments" },
	{ import = "plugins.nvim-tree" },
	{ import = "plugins.copilot" },
	{ import = "plugins.navigation" },
	{ import = "plugins.nvim-dap" },
}, {
	install = {
		colorscheme = { "vague" },
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
