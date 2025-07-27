return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		local cpptools_path = vim.fn.glob(
			vim.fn.stdpath("data")
				.. "/nix/store/*-vscode-extension-ms-vscode-cpptools*/share/vscode/extensions/ms-vscode.cpptools"
		)
		local open_debug_ad7 = cpptools_path .. "/debugAdapters/bin/OpenDebugAD7"

		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = open_debug_ad7,
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
				stopAtEntry = false,
				setupCommands = {
					{
						text = "-enable-pretty-printing",
						description = "enable pretty printing",
						ignoreFailures = false,
					},
				},
				miMode = "gdb",
				miDebuggerPath = "gdb",
			},
		}

		-- Optionally open dapui automatically
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}
