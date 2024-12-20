local CDebug = {}

function CDebug.setup_c_debugger()
	-- --- Setting Configuration for C debugger
	local dap = require("dap")
	--  -- Setting up the debug adapter
	dap.adapters.cppdbg = {
		id = 'cppdbg',
		type = 'executable',
		command = '/home/nnkiere/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7'
	}

	vim.notify("DAP: C Debugger configuration set", vim.log.levels.INFO)

	-- -- Setting up the configuration for c
	dap.configurations.c = {
		{
			name = "Launch file",
			type = "cppdbg",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopAtEntry = true,
			setupCommands = {
				text = '-enable-pretty-printing',
				description = 'Enable pretty printing for gdb',
				ignoreFailures = false
			}
		},
		{
			name = "Attach to gdbserver :1234",
			type = 'cppdbg',
			request = 'launch',
			MIMode = 'gdb',
			miDebuggerServerAddress = 'localhost:1234',
			miDebuggerPath = '/usr/bin/gdb',
			cwd = '${workspaceFolder}',
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			end,
			setupCommands = {
				text = '-enable-pretty-printing',
				description = 'Enable pretty printing for gdb',
				ignoreFailures = false
			}
		},
	}
	---- Add a Run and Debug configuration for a C fle
	table.insert(dap.configurations.c, {
		name = "Run and Debug",
		type = "cppdbg",
		request = "launch",
		program = function()
			-- Automatically generate the executable path
			local file_name = vim.fn.expand("%:t:r") -- Get the current file name without extension
			local executable = vim.fn.getcwd() .. "/" .. file_name

			-- Compile the source file
			local source_file = vim.fn.expand("%:p")
			local compile_cmd = string.format("gcc -g -o %s %s", executable, source_file)
			local result = vim.fn.system(compile_cmd)


			-- Check for compilation errors
			if vim.v.shell_error ~= 0 then
				vim.notify("Compilation failed; " .. result, vim.log.levels.ERROR)
				return nil
			end

			vim.notify("Compilation successful! Executable: " .. executable, vim.log.levels.INFO)
			return executable
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = true,
		setupCommands = {
			{
				text = '-enable-pretty-printing',
				description = 'Enable pretty printing for gdb',
				ignoreFailures = false
			}
		}
	})
end

return CDebug
