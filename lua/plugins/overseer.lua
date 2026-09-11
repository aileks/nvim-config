local dbt = require('config.dbt')
local overseer = require('overseer')

overseer.setup({})

overseer.register_template({
  name = 'dbt',
  cache_key = function(opts)
    return dbt.find_root(opts.dir)
  end,
  generator = function(opts, callback)
    local root = dbt.find_root(opts.dir)
    if not root then
      return 'No dbt_project.yml found'
    end

    callback({
      {
        name = 'dbt',
        params = {
          command = {
            type = 'enum',
            choices = { 'build', 'run', 'test', 'compile' },
            default = 'build',
          },
          selector = {
            type = 'string',
            optional = true,
          },
        },
        builder = function(params)
          local command = { 'uv', 'run', 'dbt', params.command }
          if params.selector and params.selector ~= '' then
            vim.list_extend(command, { '--select', params.selector })
          end
          return {
            cmd = command,
            cwd = root,
          }
        end,
      },
    })
  end,
})

overseer.register_template({
  name = 'zig build',
  cache_key = function(opts)
    return vim.fs.root(opts.dir, 'build.zig')
  end,
  generator = function(opts, callback)
    local root = vim.fs.root(opts.dir, 'build.zig')
    if not root then
      return 'No build.zig found'
    end

    callback({
      {
        name = 'zig build',
        builder = function()
          return {
            cmd = { 'zig', 'build' },
            cwd = root,
          }
        end,
      },
    })
  end,
})

overseer.register_template({
  name = 'zig build test',
  cache_key = function(opts)
    return vim.fs.root(opts.dir, 'build.zig')
  end,
  generator = function(opts, callback)
    local root = vim.fs.root(opts.dir, 'build.zig')
    if not root then
      return 'No build.zig found'
    end

    callback({
      {
        name = 'zig build test',
        builder = function()
          return {
            cmd = { 'zig', 'build', 'test' },
            cwd = root,
          }
        end,
      },
    })
  end,
})

overseer.register_template({
  name = 'cmake configure',
  cache_key = function(opts)
    return vim.fs.root(opts.dir, 'CMakeLists.txt')
  end,
  generator = function(opts, callback)
    local root = vim.fs.root(opts.dir, 'CMakeLists.txt')
    if not root then
      return 'No CMakeLists.txt found'
    end

    callback({
      {
        name = 'cmake configure',
        builder = function()
          return {
            cmd = { 'cmake', '-S', '.', '-B', 'build', '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON' },
            cwd = root,
          }
        end,
      },
    })
  end,
})

overseer.register_template({
  name = 'cmake build',
  cache_key = function(opts)
    return vim.fs.root(opts.dir, 'CMakeLists.txt')
  end,
  generator = function(opts, callback)
    local root = vim.fs.root(opts.dir, 'CMakeLists.txt')
    if not root then
      return 'No CMakeLists.txt found'
    end

    callback({
      {
        name = 'cmake build',
        builder = function()
          return {
            cmd = { 'cmake', '--build', 'build' },
            cwd = root,
          }
        end,
      },
    })
  end,
})

local map = vim.keymap.set

map('n', '<leader>or', '<cmd>OverseerRun<cr>', { desc = 'Run task from template' })
map('n', '<leader>oR', '<cmd>OverseerRunShell<cr>', { desc = 'Run shell command as task' })
map('n', '<leader>ot', '<cmd>OverseerToggle<cr>', { desc = 'Toggle task list' })
map('n', '<leader>oa', '<cmd>OverseerQuickAction<cr>', { desc = 'Run quick action (restart)' })
