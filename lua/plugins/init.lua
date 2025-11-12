require("lazy").setup({
	{ import = "plugins.lsp" },
	{ import = "plugins.conform" },
	{ import = "plugins.completion" },
	{ import = "plugins.telescope" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.git" },
	{ import = "plugins.comments" },
	{ import = "plugins.nvim-tree" },
	{ import = "plugins.ui" },
	{ import = "plugins.copilot" },
	{ import = "plugins.navigation" },
	{ import = "plugins.debugger" },
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
