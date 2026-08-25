local jdtls = require('jdtls')

local root_dir = vim.fs.root(0, {
  'mvnw',
  'gradlew',
  'pom.xml',
  'settings.gradle',
  'settings.gradle.kts',
  'build.gradle',
  'build.gradle.kts',
  '.git',
})

if not root_dir then
  return
end

local project_name = vim.fs.basename(root_dir)
local project_hash = vim.fn.sha256(root_dir):sub(1, 8)
local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls/' .. project_name .. '-' .. project_hash
local mason_dir = vim.fn.stdpath('data') .. '/mason'
local java_debug_jar = mason_dir .. '/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'

local bundles = {}

if vim.uv.fs_stat(java_debug_jar) then
  table.insert(bundles, java_debug_jar)
end

local config = {
  cmd = {
    'jdtls',
    '-data',
    workspace_dir,
  },

  root_dir = root_dir,

  capabilities = require('blink.cmp').get_lsp_capabilities(),

  settings = {
    java = {},
  },

  init_options = {
    bundles = bundles,
  },
}

jdtls.start_or_attach(config)

vim.keymap.set('n', '<leader>jo', function()
  jdtls.organize_imports()
end, {
  buffer = true,
  desc = 'Java organize imports',
})

vim.keymap.set('n', '<leader>jv', function()
  jdtls.extract_variable()
end, {
  buffer = true,
  desc = 'Java extract variable',
})
