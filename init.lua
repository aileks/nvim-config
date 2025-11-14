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
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/mbbill/undotree" },
  { src = "https://github.com/aznhe21/actions-preview.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/pmizio/typescript-tools.nvim" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  {
    src = "https://github.com/saghen/blink.cmp",
    version = "v1.7.0",
    build = "cargo build --release",
  },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/rcarriga/nvim-dap-ui" },
  { src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },
  { src = "https://github.com/mfussenegger/nvim-jdtls" },
  { src = "https://github.com/JavaHello/spring-boot.nvim" },
})

require("nvim-treesitter").setup()
require("nvim-treesitter")
  .install({
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "lua",
    "java",
    "xml",
    "typst",
    "markdown",
    "markdown_inline",
    "vim",
    "vimdoc",
  }, { summary = false })
  :wait(30000)

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})

require("ibl").setup({
  indent = { char = "│" },
  scope = { enabled = false },
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
    "jsonls",
  },
})

require("mason-nvim-dap").setup({
  ensure_installed = { "java-debug-adapter" },
  automatic_installation = true,
})

vim.lsp.enable({
  "lua_ls",
  "cssls",
  "tinymist",
  "tailwindcss",
  "emmet_ls",
  "marksman",
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
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
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

require("blink.cmp").setup({
  completion = {
    menu = {
      border = "rounded",
    },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },
  keymap = {
    preset = "default",
  },
  sources = {
    default = { "lsp", "path", "buffer", "snippets" },
    providers = {
      snippets = {
        name = "snippets",
        enabled = true,
        max_items = 8,
        min_keyword_length = 2,
      },
    },
  },
})

local telescope = require("telescope")
telescope.setup({
  defaults = {
    preview = { treesitter = false },
    color_devicons = true,
    sorting_strategy = "ascending",
    path_displays = { "smart" },
    layout_config = {
      height = 100,
      width = 400,
      prompt_position = "bottom",
      preview_cutoff = 40,
    },
  },
})
telescope.load_extension("ui-select")
telescope.load_extension("fzf")

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

require("conform").setup({
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
    lua = { "stylua" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
    java = { "google-java-format" },
    xml = { "xmlformatter" },
  },
  formatters = {
    ["google-java-format"] = {
      prepend_args = { "--aosp" },
    },
    stylua = {
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    },
    prettier = {
      prepend_args = { "--tab-width", "2" },
    },
    shfmt = {
      prepend_args = { "--indent", "2" },
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  notify_on_error = true,
  notify_no_formatters = true,
})

require("nvim-autopairs").setup()
require("vague").setup({ transparent = true })
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").setup({
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
})

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

-- Keybinds
local builtin = require("telescope.builtin")
local actions = require("actions-preview")
local ls = require("luasnip")

function all_files()
  builtin.find_files({ no_ignore = true })
end

function format()
  require("conform").format({ async = true })
end

vim.g.mapleader = " "
vim.keymap.set("n", "<Esc>", ":nohl<CR>", { silent = true })
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", ":write<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":quit<CR>", { silent = true })
vim.keymap.set("n", "<leader>r", format)
vim.keymap.set("n", "<leader>e", ":Oil<CR>", { silent = true })
vim.keymap.set("n", "<leader>pc", pack_clean)
vim.keymap.set("n", "<leader>ps", vim.pack.update)
vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>h", builtin.help_tags)
vim.keymap.set("n", "<leader>g", builtin.live_grep)
vim.keymap.set("n", "<leader>b", builtin.buffers)
vim.keymap.set("n", "<leader>d", builtin.diagnostics)
vim.keymap.set("n", "<leader>ca", actions.code_actions)
vim.keymap.set("n", "<leader>F", all_files)
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>")
vim.keymap.set("n", "<leader>sh", ":split<CR>")
vim.keymap.set({ "n", "t" }, "<leader>t", ":tabnew<CR>", { silent = true })
vim.keymap.set({ "n", "t" }, "<leader>x", ":tabclose<CR>", { silent = true })
vim.keymap.set("n", "<C-f>", ":Open .<CR>")
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

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
vim.cmd("hi statusline guibg=NONE")
vim.cmd("hi TabLineFill guibg=NONE")
