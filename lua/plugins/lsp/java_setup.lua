local LspJava = {}

function LspJava.setup_java_lsp(on_attach, capabilities)
	local home = vim.env.HOME
	local jdtls = require('jdtls')
	local bundles = {
		vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
	}
	vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n"))
	vim.list_extend(bundles,
		vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-*/extension/server/*/jar", 1), "\n"))


	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local workspace_dir = home .. "/.cache/jdtls/workspaces/" .. project_name
	local config = {
		-- The command that starts the language server
		-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
		cmd = {
			'java',
			'-Declipse.application=org.eclipse.jdt.ls.core.id1',
			'-Dosgi.bundles.defaultStartLevel=4',
			'-Declipse.product=org.eclipse.jdt.ls.core.product',
			'-Dlog.protocol=true',
			-- Could use the lombok agent here if needed
			'-Dlog.level=ALL',
			'-Xmx4g',
			'--add-modules=ALL-SYSTEM',
			'--add-opens', 'java.base/java.util=ALL-UNNAMED',
			'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
			'-javaagent:' .. home .. '/.local/share/nvim/mason/share/lombok/lombok.jar',

			'-jar', home .. '/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
			-- 💀
			'-configuration', home .. '/.local/share/nvim/mason/packages/jdtls/config_linux',

			-- 💀
			-- See `data directory configuration` section in the README
			'-data', workspace_dir,
		},

		-- vim.fs.root requires Neovim 0.10.
		-- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
		root_dir = vim.fs.root(0, { ".git", "gradlew" }),

		settings = {
			java = {
				home = "/opt/jdk-23/jdk-23.0.2",
				eclipse = {
					downloadSources = true,
				},
				configuration = {
					updateBuildConfiguration = "automatic",

					runtimes = {
						{
							name = "JavaSE-23",
							path = "/opt/jdk-23/jdk-23.0.2",
						},
						{
							-- Java 8
							name = "JavaSE-1.8",
							path = "/export/apps/jdk/JDK-1_8_0_282-msft",
							default = true, -- Spelled correctly; this makes Java 8 the default
						},
						{
							-- Java 11
							name = "JavaSE-11",
							path = "/export/apps/jdk/JDK-11_0_8-msft",
						},
						{
							-- Java 17
							name = "JavaSE-17",
							path = "/export/apps/jdk/JDK-17_0_5-msft",
						},
					},
					implementationsCodeLens = {
						enabled = true,
					},
					references = {
						includeDecompiledSources = true,
					},
					signatureHelp = {
						enabled = true,
					},
					format = {
						enabled = true,
						-- Formatting works by default, but you can refer to a specific file/URL if you choose
						-- settings = {
						--   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
						--   profile = "GoogleStyle",
						-- },
					},
					contentProvider = {
						preferred = "fernflower",
					},
					completion = {
						favoriteStaticMembers = {
							-- Complete this later
						},
						importOrder = {
							-- Complete this later
						},
					},
					sources = {
						organizeImports = {
							starThreshold = 9999,
							staticStarThreshold = 9999,
						},
					},
					codeGeneration = {
						toString = {
							template = "${object.className}{${member.name()}=${member.value()}, ${otherMembers}}",
						},
						useBlocks = {
							enabled = true,
						},
					},
				}
			}
		},

		capabilities = capabilities,
		flags = {
			allow_incremental_sync = true,
		},

		-- Language server `initializationOptions`
		-- You need to extend the `bundles` with paths to jar files
		-- if you want to use additional eclipse.jdt.ls plugins.
		--
		-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
		--
		-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
		init_options = {
			bundles = bundles,
			extendedClientCapabilities = jdtls.extendedClientCapabilities,
		},
	}

	-- Needed for debugging
	config['on_attach'] = function(_, bufnr)
		jdtls.setup_dap({ hotcodereplace = 'auto' })
		require('jdtls.dap').setup_dap_main_class_configs()
		on_attach(_, bufnr)
	end


	-- This starts a new client & server,
	-- or attaches to an existing client & server depending on the `root_dir`.
	require('jdtls').start_or_attach(config)

	-- Prinitng to debug
	vim.notify("Java LSP started", vim.log.levels.INFO)
	vim.notify(("The workspace directory is: %s"):format(workspace_dir), vim.log.levels.INFO)
end

return LspJava
