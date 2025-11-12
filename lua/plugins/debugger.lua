return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup dap-ui
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
				mappings = {
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				expand_lines = vim.fn.has("nvim-0.7") == 1,
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"stacks",
							"watches",
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 10,
						position = "bottom",
					},
				},
				controls = {
					enabled = true,
					element = "repl",
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏬",
						step_over = "⏭",
						step_out = "⏫",
						step_back = "⏮",
						run_last = "▶▶",
						terminate = "⏹",
					},
				},
				floating = {
					max_height = nil,
					max_width = nil,
					border = "single",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil,
					max_value_lines = 100,
				},
			})

			-- Setup mason-nvim-dap
			require("mason-nvim-dap").setup({
				ensure_installed = {},
				automatic_installation = true,
				handlers = {},
			})

			-- DAP keybinds
			local keymap = vim.keymap.set
			local opts = { noremap = true, silent = true }

			keymap("n", "<F5>", dap.continue, vim.tbl_extend("force", opts, { desc = "Debug: Start/Continue" }))
			keymap("n", "<F1>", dap.step_into, vim.tbl_extend("force", opts, { desc = "Debug: Step Into" }))
			keymap("n", "<F2>", dap.step_over, vim.tbl_extend("force", opts, { desc = "Debug: Step Over" }))
			keymap("n", "<F3>", dap.step_out, vim.tbl_extend("force", opts, { desc = "Debug: Step Out" }))
			keymap("n", "<leader>b", dap.toggle_breakpoint, vim.tbl_extend("force", opts, { desc = "Debug: Toggle Breakpoint" }))
			keymap("n", "<leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, vim.tbl_extend("force", opts, { desc = "Debug: Set Conditional Breakpoint" }))
			keymap("n", "<leader>lp", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, vim.tbl_extend("force", opts, { desc = "Debug: Set Logpoint" }))
			keymap("n", "<leader>dr", dap.repl.open, vim.tbl_extend("force", opts, { desc = "Debug: Open REPL" }))
			keymap("n", "<leader>dl", dap.run_last, vim.tbl_extend("force", opts, { desc = "Debug: Run Last" }))
			keymap("n", "<leader>du", dapui.toggle, vim.tbl_extend("force", opts, { desc = "Debug: Toggle UI" }))

			-- Auto open/close dap-ui
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Language-specific configurations
			-- Python
			dap.adapters.python = {
				type = "executable",
				command = "python",
				args = { "-m", "debugpy.adapter" },
			}

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					python = function()
						return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python3"
					end,
					console = "integratedTerminal",
				},
				{
					type = "python",
					request = "attach",
					name = "Attach",
					connect = {
						port = 5678,
						host = "127.0.0.1",
					},
				},
			}

			-- JavaScript/TypeScript (Node.js)
			dap.adapters.node2 = {
				type = "executable",
				command = "node",
				args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
			}

			dap.configurations.javascript = {
				{
					name = "Launch",
					type = "node2",
					request = "launch",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
				},
				{
					name = "Attach to process",
					type = "node2",
					request = "attach",
					processId = require("dap.utils").pick_process,
				},
			}

			dap.configurations.typescript = dap.configurations.javascript

			-- C/C++ (cpptools)
			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
			}

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,
				},
				{
					name = "Attach to gdbserver :1234",
					type = "cppdbg",
					request = "attach",
					MIMode = "gdb",
					miDebuggerServerAddress = "localhost:1234",
					miDebuggerPath = "/usr/bin/gdb",
					cwd = "${workspaceFolder}",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
				},
			}

			dap.configurations.c = dap.configurations.cpp

			-- Java
			dap.adapters.java = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/build/launch.sh",
			}

			dap.configurations.java = {
				{
					type = "java",
					name = "Debug (Attach)",
					request = "attach",
					hostName = "127.0.0.1",
					port = 5005,
				},
				{
					type = "java",
					name = "Debug (Launch)",
					request = "launch",
					vmArgs = "",
					projectName = "",
					mainClass = "",
					args = "",
				},
			}

			-- Go
			dap.adapters.go = {
				type = "executable",
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:38697" },
			}

			dap.configurations.go = {
				{
					type = "go",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "go",
					name = "Debug test",
					request = "launch",
					mode = "test",
					program = "${file}",
				},
				{
					type = "go",
					name = "Debug test (go.mod)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			}

			-- Lua
			dap.adapters.nlua = function(callback, config)
				callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
			end

			dap.configurations.lua = {
				{
					type = "nlua",
					request = "attach",
					name = "Attach to running Neovim instance",
					host = function()
						local value = vim.fn.input("Host [127.0.0.1]: ")
						if value ~= "" then
							return value
						end
						return "127.0.0.1"
					end,
					port = function()
						local val = tonumber(vim.fn.input("Port: "))
						assert(val, "Please provide a port number")
						return val
					end,
				},
			}
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		cmd = { "DapInstall", "DapUninstall" },
	},
}

