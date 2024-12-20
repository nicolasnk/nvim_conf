local PythonDebug = {}

function PythonDebug.setup_python_debugger()
	require("dap-python").setup()
	-- Disable justMyCode for python
	table.insert(require("dap").configurations.python, {
		type = "python",
		justMyCode = false,
		request = "attach",
		name = "Python: Attach Debugger",
		port = 5678,
		host = "0.0.0.0"
	})
	table.insert(require("dap").configurations.python, {
		type = "python",
		justMyCode = false,
		request = "attach",
		name = "Python: Attach Debugger 2",
		port = 5679,
		host = "0.0.0.0"
	})
	-- Hardcoded
	table.insert(require("dap").configurations.python, {
		name = "PyGrpc Hardcoded",
		type = "python",
		request = "attach",
		justMyCode = false,
		connect = {
			host = "localhost",
			port = 5678,
		},
		pathMappings = {
			{
				localRoot = "/home/nnkiere/Workcode/ingen-grpc-demo/ingen-grpc-demo/src/ingengrpcdemo",
				remoteRoot =
				"/export/content/lid/apps/ingen-grpc-demo/i001/libexec/ingen-grpc-demo.pyz_91befa7145fc0ce2663dd8f93ab85ac0fd31717feacc3db1aafb686231f750e7/site-packages/ingengrpcdemo",
			}
		}
	})

	-- Adding configuration for grpc python ---
	table.insert(require("dap").configurations.python, {
		name = "PyGrpc Debugger",
		type = "python",
		request = "attach",
		justMyCode = false,
		connect = {
			host = "localhost",
			port = 5678,
		},
		pathMappings = {
			{
				localRoot = "/home/nnkiere/Workcode/ingen-grpc-demo/ingen-grpc-demo/src/ingengrpcdemo",
				remoteRoot = "<DYNAMIC>",
			}
		}
	})

	-- Dynamically resolving the remoteRoot path
	-- Function to get the newest pyz directory dynamically
	local function get_newest_pyz_dir(base_path)
		vim.notify("DAP: Getting newest pyz directory. Within helper function", vim.log.levels.INFO)
		local pattern = "ingen-grpc-demo\\.pyz_"
		local cmd = string.format('ls -t "%s" | grep "%s"', base_path, pattern)
		vim.notify("DAP: Running command: " .. cmd, vim.log.levels.INFO)

		local handle = io.popen(cmd)
		vim.notify("DAP: Command executed", vim.log.levels.INFO)
		vim.notify("DAP: Handle = " .. tostring(handle), vim.log.levels.INFO)
		if not handle then return nil end

		local newest_dir = handle:read("*l")
		handle:close()

		return newest_dir
	end

	-- Base path where the pyz directory is located
	local libexec_path = "/export/content/lid/apps/ingen-grpc-demo/i001/libexec"
	-- Listener that runs each time you start this debug configuration
	-- It will dynamically compute the newest pyz directory and set the remoteRoot accordingly.
	require("dap").listeners.before['attach']['dynamic_remote_root'] = function(session, body)
		local config = session.config
		vim.notify("DAP: Running dynamic_remote_root listener", vim.log.levels.INFO)
		if config.name == "PyGrpc Debugger" or config.name:match("^Subprocess ") then
			vim.notify("DAP: Configuration name = " .. config.name, vim.log.levels.INFO)
			vim.notify("DAP: Getting the newest pyz directory", vim.log.levels.INFO)
			local newest_pyz_dir = get_newest_pyz_dir(libexec_path)
			vim.notify("DAP: Newest pyz directory = " .. newest_pyz_dir, vim.log.levels.INFO)

			if not newest_pyz_dir then
				vim.notify("No ingen-grpc-demo.pyz_ directories found in " .. libexec_path, vim.log.levels.ERROR)
				newest_pyz_dir = "ingen-grpc-demo.pyz_unknown"
			end

			local remote_root = libexec_path .. "/" .. newest_pyz_dir .. "/site-packages/ingengrpcdemo"
			config.pathMappings[1].remoteRoot = remote_root
			vim.notify("DAP: Using remoteRoot = " .. remote_root, vim.log.levels.INFO)
		end
	end
	---- End of dynamic path mapping

	require("dap-python").test_runner = "pytest"

	---- debuging printing
	vim.notify("DAP: Python Debugger configuration set", vim.log.levels.INFO)
	---- End of Python Debugger configuration
end

return PythonDebug
