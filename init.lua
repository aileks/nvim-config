-- Leader must be set before lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
vim.o.tabstop = 2
vim.o.shiftwidth = 2
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
vim.opt.colorcolumn = "100"
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.termguicolors = true

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specs
require("lazy").setup({
  -- Theme
  {
    "ficd0/ashen.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
    config = function(_, opts)
      require("ashen").setup(opts)
      vim.cmd([[colorscheme ashen]])
    end,
  },

  -- Core dependencies
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- UI
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.lualine")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    config = function()
      require("plugins.indent-blankline")
    end,
  },
  { "mbbill/undotree", cmd = "UndotreeToggle" },
  {
    "folke/snacks.nvim",
    priority = 900,
    lazy = false,
    config = function()
      require("plugins.snacks")
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("plugins.treesitter")
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    config = function()
      require("plugins.lsp")
    end,
  },
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    event = { "BufReadPre", "BufNewFile" },
    build = ":MasonUpdate",
    config = function()
      require("plugins.mason")
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = true,
  },
  -- Completion
  {
    "saghen/blink.cmp",
    version = "*",
    build = "cargo build --release",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },
    config = function()
      require("plugins.blink-cmp")
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    lazy = true,
    config = function()
      require("plugins.luasnip")
    end,
  },
  { "rafamadriz/friendly-snippets", lazy = true },

  -- Formatting & Linting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("plugins.conform")
    end,
  },


  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Editing
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "nvim-mini/mini.surround",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("mini.surround").setup()
    end,
  },

  -- Actions preview
  {
    "aznhe21/actions-preview.nvim",
    lazy = true,
    config = function()
      require("plugins.actions-preview")
    end,
  },

  -- AI
  { "github/copilot.vim", event = "InsertEnter" },
  {
    "folke/sidekick.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<C-.>", function() require("sidekick.cli").toggle() end, desc = "Toggle AI CLI", mode = { "n", "t", "i", "x" } },
      { "<leader>ac", function() require("sidekick.cli").toggle() end, desc = "Toggle AI CLI" },
      { "<leader>as", function() require("sidekick.cli").select() end, desc = "Select AI Tool" },
      { "<leader>ax", function() require("sidekick.cli").close() end, desc = "Close AI Session" },
      { "<leader>ap", function() require("sidekick.cli").prompt() end, desc = "AI Prompts", mode = { "n", "x" } },
      { "<leader>ae", function() require("sidekick.cli").send({ msg = "Explain {this}" }) end, desc = "AI Explain", mode = { "n", "x" } },
      { "<leader>ar", function() require("sidekick.cli").send({ msg = "Review {file}" }) end, desc = "AI Review File" },
      { "<leader>af", function() require("sidekick.cli").send({ msg = "Fix {this}" }) end, desc = "AI Fix", mode = { "n", "x" } },
      { "<leader>at", function() require("sidekick.cli").send({ msg = "Write tests for {this}" }) end, desc = "AI Write Tests", mode = { "n", "x" } },
      { "<leader>ad", function() require("sidekick.cli").send({ msg = "Add documentation to {this}" }) end, desc = "AI Document", mode = { "n", "x" } },
      { "<leader>ao", function() require("sidekick.cli").send({ msg = "Optimize {this}" }) end, desc = "AI Optimize", mode = { "n", "x" } },
    },
  },
}, {
  install = { colorscheme = { "ashen" } },
  checker = { enabled = false },
  change_detection = { notify = false },
})

-- Load keybinds
require("keybinds")

-- Autocmds
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})
