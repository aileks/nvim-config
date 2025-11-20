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
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/mbbill/undotree" },
  { src = "https://github.com/aznhe21/actions-preview.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/pmizio/typescript-tools.nvim" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/mfussenegger/nvim-lint" },
  { src = "https://github.com/saghen/blink.cmp", build = "cargo build --release" },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/rcarriga/nvim-dap-ui" },
  { src = "https://github.com/OXY2DEV/markview.nvim" },
  { src = "https://github.com/ray-x/go.nvim" },
  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/folke/zen-mode.nvim" },
})

require("vague").setup({ transparent = true })
require("plugins.treesitter")
require("plugins.lualine")
require("plugins.indent-blankline")
require("plugins.mason")
require("plugins.lsp")
require("plugins.blink-cmp")
require("plugins.snacks")
require("plugins.zen-mode")
require("plugins.actions-preview")
require("plugins.conform")
require("plugins.lint")
require("plugins.autopairs")
require("plugins.luasnip")
require("plugins.dap")
require("keybinds")

-- Autocmds
local default_color = "vague"
local color_group = vim.api.nvim_create_augroup("colors", { clear = true })

vim.api.nvim_create_autocmd("TabEnter", {
  group = color_group,
  callback = function()
    if vim.t.color then
      vim.cmd("colorscheme " .. vim.t.color)
    else
      vim.cmd("colorscheme " .. default_color)
    end
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = color_group,
  callback = function()
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

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
  callback = function()
    ---@diagnostic disable-next-line: different-requires
    require("lint").try_lint()
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "MasonToolsStartingInstall",
  callback = function()
    vim.schedule(function()
      print("mason-tool-installer is starting")
    end)
  end,
})

-- Cmd settings
vim.cmd("colorscheme " .. default_color)
vim.cmd("hi statusline guibg=NONE")
vim.cmd("hi TabLineFill guibg=NONE")
