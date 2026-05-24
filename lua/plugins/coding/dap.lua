return {
	{ "rcarriga/nvim-dap-ui", lazy = true },
	{ "nvim-neotest/nvim-nio", lazy = true },
	{ "jay-babu/mason-nvim-dap.nvim", lazy = true },
	{ "mfussenegger/nvim-dap-python", lazy = true },
	{
		"mfussenegger/nvim-dap",

		cmd = {
			"DapContinue",
			"DapToggleBreakpoint",
			"DapStepOver",
			"DapStepInto",
			"DapStepOut",
			"DapTerminate",
			"DapUIOpen",
			"DapUIToggle",
		},

		keys = {
			-- Session control
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "DAP: Continue / Start",
			},
			{
				"<F4>",
				function()
					require("dap").terminate()
				end,
				desc = "DAP: Terminate",
			},
			{
				"<leader>dr",
				function()
					require("dap").continue()
				end,
				desc = "DAP: Run / Continue",
			},
			{
				"<leader>dq",
				function()
					require("dap").terminate()
				end,
				desc = "DAP: Terminate",
			},
			{
				"<leader>dR",
				function()
					require("dap").restart()
				end,
				desc = "DAP: Restart",
			},

			-- Stepping
			{
				"<F1>",
				function()
					require("dap").step_into()
				end,
				desc = "DAP: Step Into",
			},
			{
				"<F2>",
				function()
					require("dap").step_over()
				end,
				desc = "DAP: Step Over",
			},
			{
				"<F3>",
				function()
					require("dap").step_out()
				end,
				desc = "DAP: Step Out",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "DAP: Step Into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "DAP: Step Over",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "DAP: Step Out",
			},
			{
				"<leader>dc",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "DAP: Run to Cursor",
			},

			-- Breakpoints
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "DAP: Toggle Breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "DAP: Conditional Breakpoint",
			},
			{
				"<leader>dl",
				function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end,
				desc = "DAP: Log Point",
			},
			{
				"<leader>dX",
				function()
					require("dap").clear_breakpoints()
				end,
				desc = "DAP: Clear All Breakpoints",
			},

			-- UI
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "DAP: Toggle UI",
			},
			{
				"<leader>de",
				function()
					require("dapui").eval()
				end,
				desc = "DAP: Evaluate Expression",
				mode = { "n", "v" },
			},
			{
				"<leader>dh",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "DAP: Hover Variables",
			},

			-- REPL
			{
				"<leader>dP",
				function()
					require("dap").repl.open()
				end,
				desc = "DAP: Open REPL",
			},

			-- Focus Terminal
			{
				"<leader>dt",
				function()
					require("dapui").float_element("console", { enter = true })
				end,
				desc = "DAP: Focus Terminal",
			},

			-- Focus REPL
			{
				"<leader>dT",
				function()
					require("dapui").float_element("repl", { enter = true })
				end,
				desc = "DAP: Focus REPL",
			},
		},

		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Mason auto-install adapters
			require("mason-nvim-dap").setup({
				ensure_installed = { "python", "cpptools", "js-debug-adapter" },
				automatic_installation = true,
			})

			dapui.setup()

			-- Python: pass the mason-installed debugpy python, fall back to system python3
			local mason_debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(vim.fn.executable(mason_debugpy) == 1 and mason_debugpy or "python3")

			-- JS/TS adapter
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			-- JS/TS configurations
			local js_config = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch Current File",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to Process",
					processId = require("dap.utils").pick_process,
					cwd = vim.fn.getcwd(),
				},
			}
			dap.configurations.javascript = js_config
			dap.configurations.typescript = js_config
			dap.configurations.javascriptreact = js_config
			dap.configurations.typescriptreact = js_config

			-- C/C++ configuration
			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "cpptools",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,
				},
			}
			dap.configurations.c = dap.configurations.cpp

			-- Auto open/close UI
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

			-- User commands
			vim.api.nvim_create_user_command("DapUIOpen", function()
				dapui.open()
			end, {})
			vim.api.nvim_create_user_command("DapUIClose", function()
				dapui.close()
			end, {})
			vim.api.nvim_create_user_command("DapUIToggle", function()
				dapui.toggle()
			end, {})

			-- DAP sign icons
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "◉", texthl = "DapLogPoint", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", {
				text = "▶",
				texthl = "DapStopped",
				linehl = "DapStoppedLine",
				numhl = "",
			})
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "✗", texthl = "DapBreakpointRejected", linehl = "", numhl = "" }
			)
		end,
	},
}
