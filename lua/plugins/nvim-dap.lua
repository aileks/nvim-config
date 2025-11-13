return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			"mxsdev/nvim-dap-vscode-js",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

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

			require("mason-nvim-dap").setup({
				ensure_installed = { "java-debug-adapter" },
				automatic_installation = true,
				handlers = {},
			})

			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			})

			local keymap = vim.keymap.set
			local opts = { noremap = true, silent = true }

			keymap("n", "<F5>", dap.continue, vim.tbl_extend("force", opts, { desc = "Debug: Start/Continue" }))
			keymap("n", "<F1>", dap.step_into, vim.tbl_extend("force", opts, { desc = "Debug: Step Into" }))
			keymap("n", "<F2>", dap.step_over, vim.tbl_extend("force", opts, { desc = "Debug: Step Over" }))
			keymap("n", "<F3>", dap.step_out, vim.tbl_extend("force", opts, { desc = "Debug: Step Out" }))
			keymap("n", "<leader>b", dap.toggle_breakpoint,
				vim.tbl_extend("force", opts, { desc = "Debug: Toggle Breakpoint" }))
			keymap("n", "<leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, vim.tbl_extend("force", opts, { desc = "Debug: Set Conditional Breakpoint" }))
			keymap("n", "<leader>lp", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, vim.tbl_extend("force", opts, { desc = "Debug: Set Logpoint" }))
			keymap("n", "<leader>dr", dap.repl.open, vim.tbl_extend("force", opts, { desc = "Debug: Open REPL" }))
			keymap("n", "<leader>dl", dap.run_last, vim.tbl_extend("force", opts, { desc = "Debug: Run Last" }))
			keymap("n", "<leader>du", dapui.toggle, vim.tbl_extend("force", opts, { desc = "Debug: Toggle UI" }))

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			dap.configurations.javascript = {
				{
					name = "Launch",
					type = "pwa-node",
					request = "launch",
					program = "${file}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
					resolveSourceMapLocations = {
						"${workspaceFolder}/**",
						"!**/node_modules/**",
					},
				},
				{
					name = "Attach to process",
					type = "pwa-node",
					request = "attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
				},
				{
					name = "Debug Jest Tests",
					type = "pwa-node",
					request = "launch",
					runtimeExecutable = "node",
					runtimeArgs = {
						"./node_modules/.bin/jest",
						"--runInBand",
					},
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
				},
			}

			dap.configurations.typescript = {
				{
					name = "Launch",
					type = "pwa-node",
					request = "launch",
					program = "${file}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
					resolveSourceMapLocations = {
						"${workspaceFolder}/**",
						"!**/node_modules/**",
					},
					runtimeExecutable = "node",
					runtimeArgs = { "--loader", "ts-node/esm" },
				},
				{
					name = "Attach to process",
					type = "pwa-node",
					request = "attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
				},
				{
					name = "Debug Jest Tests",
					type = "pwa-node",
					request = "launch",
					runtimeExecutable = "node",
					runtimeArgs = {
						"./node_modules/.bin/jest",
						"--runInBand",
					},
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
				},
			}

			local jdtls_ok, jdtls = pcall(require, "jdtls")
			if jdtls_ok then
				jdtls.setup_dap({ hotcodereplace = "auto" })
			end

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
				{
					type = "java",
					name = "Debug Current File",
					request = "launch",
					mainClass = function()
						return vim.fn.input("Main class: ", vim.fn.expand("%:t:r"), "file")
					end,
					projectName = "${workspaceFolder}",
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
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = { "mfussenegger/nvim-dap" },
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	},
}
