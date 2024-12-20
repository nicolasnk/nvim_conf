local LspDart = {}


function LspDart.setup_dart_lsp(on_attach, capabilities)
	-- Dart bundles their LSP server with the runtime executable itself. Thus dart lsp is not included within Mason
	-- No need for mason to install the lsp as dart lsp is already installed if you're developping using dart
	local lspconfig = require('lspconfig')
	local util = lspconfig.util
	require("lspconfig").dartls.setup({
		cmd = { "dart", "language-server", "--protocol=lsp" },
		filetypes = { "dart" },
		init_options = {
			closingLabels = true,
			flutterOutline = true,
			onlyAnalyzeProjectsWithOpenFiles = false,
			outline = true,
			suggestFromUnimportedLibraries = true,
		},
		root_dir = function(fname)
			-- Check if the file is inside the .pub-cache
			if string.find(fname, "/.pub-cache/") then
				-- Find the .pub-cache root
				return os.getenv("HOME") .. "/.pub-cache"
			else
				-- Default project root finding logic
				return util.root_pattern("pubspec.yaml")(fname) or
				    util.path.dirname(fname)
			end
		end,
		settings = {
			dart = {
				completeFunctionCalls = true,
				showTodos = true,
			},
		},
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

return LspDart
