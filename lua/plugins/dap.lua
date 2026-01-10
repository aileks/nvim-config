return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        "nvim-neotest/nvim-nio",
      },
    },
    "theHamsta/nvim-dap-virtual-text",
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = {
        "mason-org/mason.nvim",
      },
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      automatic_installation = true,
      ensure_installed = { "codelldb" },
      handlers = {},
    })

    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 12,
          position = "bottom",
        },
      },
    })

    require("nvim-dap-virtual-text").setup({
      enabled = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
      show_stop_reason = true,
      commented = true,
    })

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "●", texthl = "DiagnosticWarn" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticHint" })
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "Special" })

    local codelldb_path = vim.fn.exepath("codelldb")
    if codelldb_path == "" then
      codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
    end

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = codelldb_path,
        args = { "--port", "${port}" },
        detached = false,
      },
    }

    local function project_name()
      return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    end

    local function program_picker(default_path)
      return function()
        return vim.fn.input("Path to executable: ", default_path, "file")
      end
    end

    local function cpp_config(name)
      return {
        name = name,
        type = "codelldb",
        request = "launch",
        program = program_picker(vim.fn.getcwd() .. "/"),
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      }
    end

    dap.configurations.cpp = {
      cpp_config("Launch"),
      {
        name = "Attach",
        type = "codelldb",
        request = "attach",
        pid = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }
    dap.configurations.c = dap.configurations.cpp

    dap.configurations.rust = {
      {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = program_picker(vim.fn.getcwd() .. "/target/debug/" .. project_name()),
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
      {
        name = "Attach",
        type = "codelldb",
        request = "attach",
        pid = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }

    dap.configurations.zig = {
      {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = program_picker(vim.fn.getcwd() .. "/zig-out/bin/" .. project_name()),
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
      {
        name = "Attach",
        type = "codelldb",
        request = "attach",
        pid = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }
  end,
}
