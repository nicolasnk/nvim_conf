local JavaDebug = {}

function JavaDebug.setup_java_debugger()
	local dap = require("dap")

	dap.configurations.java = {
		{
			name = "Debug Launch (2GB)",
			type = "java",
			request = "launch",
			vmArgs = "-Xmx2G",
		},
		{
			name = "Debug Attach (8000)",
			type = "java",
			request = "attach",
			hostName = "127.0.0.1",
			port = 8000,
		},
		{
			name = "Beam Debug Attach (9009)",
			type = "java",
			request = "attach",
			hostName = "127.0.0.1",
			port = 9009,
		},
		{
			name = "Beam Debug Attach (9999)",
			type = "java",
			request = "attach",
			hostName = "127.0.0.1",
			port = 9999,
		},
		{
			name = "The Beam Job",
			type = "java",
			request = "launch",

			mainClass = "com.linkedin.beam.example.YourBeamJob",

			vmArgs = "" ..
					"-Dlog4j.configuration=file:~/Workcode/dogs-beam/beam-jobs/process-dogs-events/src/main/resources/log4j2-dev.xml",
		}
	}
end

return JavaDebug
