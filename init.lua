-- Options
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.showmatch = true
vim.o.clipboard = "unnamedplus"
vim.o.timeout = true
vim.o.timeoutlen = 500
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.showtabline = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("data") .. "/undo"
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.cmdheight = 1
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.winborder = "rounded"

-- Plugins and setup
vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/aznhe21/actions-preview.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/mfussenegger/nvim-jdtls" },
	{ src = "https://github.com/pmizio/typescript-tools.nvim" },
})

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"cssls",
		"tinymist",
		"tailwindcss",
		"emmet_ls",
		"jdtls",
		"jsonls",
	},
})

vim.lsp.enable({
	"lua_ls",
	"cssls",
	"tinymist",
	"tailwindcss",
	"emmet_ls",
	"jdtls",
	"prettier",
	"google-java-format",
	"xmlformatter",
	"shfmt",
	"marksman",
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

local telescope = require("telescope")
telescope.setup({
	defaults = {
		preview = { treesitter = false },
		color_devicons = true,
		sorting_strategy = "ascending",
		borderchars = {
			"─", -- top
			"│", -- right
			"─", -- bottom
			"│", -- left
			"┌", -- top-left
			"┐", -- top-right
			"┘", -- bottom-right
			"└", -- bottom-left
		},
		path_displays = { "smart" },
		layout_config = {
			height = 100,
			width = 400,
			prompt_position = "top",
			preview_cutoff = 40,
		},
	},
})
telescope.load_extension("ui-select")

require("actions-preview").setup({
	backend = { "telescope" },
	telescope = vim.tbl_extend("force", require("telescope.themes").get_dropdown(), {}),
})

require("oil").setup({
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	},
	columns = {
		"permissions",
		"icon",
	},
	float = {
		max_width = 0.7,
		max_height = 0.6,
		border = "rounded",
	},
})

require("vague").setup({ transparent = true })
require("luasnip").setup({ enable_autosnippets = true })

local function pack_clean()
	local active_plugins = {}
	local unused_plugins = {}

	for _, plugin in ipairs(vim.pack.get()) do
		active_plugins[plugin.spec.name] = plugin.active
	end

	for _, plugin in ipairs(vim.pack.get()) do
		if not active_plugins[plugin.spec.name] then
			table.insert(unused_plugins, plugin.spec.name)
		end
	end

	if #unused_plugins == 0 then
		print("No unused plugins.")
		return
	end

	local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
	if choice == 1 then
		vim.pack.del(unused_plugins)
	end
end

-- Autocmds
local default_color = "vague"
local color_group = vim.api.nvim_create_augroup("colors", { clear = true })

vim.api.nvim_create_autocmd("TabEnter", {
	group = color_group,
	callback = function(_args)
		if vim.t.color then
			vim.cmd("colorscheme " .. vim.t.color)
		else
			vim.cmd("colorscheme " .. default_color)
		end
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	group = color_group,
	callback = function(_args)
		if vim.t.color then
			vim.cmd("colorscheme " .. vim.t.color)
		else
			vim.cmd("colorscheme " .. default_color)
		end
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		vim.lsp.buf.format({ bufnr = args.buf })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

-- Keybinds
local builtin = require("telescope.builtin")
local actions = require("actions-preview")
local ls = require("luasnip")

function all_files()
	builtin.find_files({ no_ignore = true })
end

vim.g.mapleader = " "
vim.keymap.set("n", "<Esc>", ":nohl<CR>", { silent = true })
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":quit<CR>", { silent = true })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>e", ":Oil<CR>", { silent = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>pc", pack_clean)
vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>h", builtin.help_tags)
vim.keymap.set("n", "<leader>g", builtin.live_grep)
vim.keymap.set("n", "<leader>b", builtin.buffers)
vim.keymap.set("n", "<leader>d", builtin.diagnostics)
vim.keymap.set("n", "<leader>F", all_files)
vim.keymap.set("n", "<leader>ca", actions.code_actions)
vim.keymap.set("n", "<C-f>", ":Open .<CR>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set({ "n", "t" }, "<leader>t", ":tabnew<CR>")
vim.keymap.set({ "n", "t" }, "<leader>x", ":tabclose<CR>")
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>")
vim.keymap.set("n", "<leader>sh", ":split<CR>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set({ "i", "s" }, "<C-e>", function()
	ls.expand_or_jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
	ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-K>", function()
	ls.jump(-1)
end, { silent = true })
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Easy tab switching
for i = 1, 8 do
	vim.keymap.set({ "n", "t" }, "<Leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>")
end

-- Cmd settings
vim.cmd("colorscheme " .. default_color)
vim.cmd(":hi statusline guibg=NONE")
vim.cmd("hi TabLineFill guibg=NONE")
vim.cmd("set completeopt+=menuone,noselect,popup")
