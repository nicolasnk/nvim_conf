--- File to install the base plugins for LSP


-- on_attach function for LSP
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
	nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
	nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	nmap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })

	nmap('<leader>f', vim.lsp.buf.format(), '[F]ormat File')
end


--[[
Not Sure why is this for
TODO Try to test what is the use of this code
---- document existing key chains
require('which-key').register {
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').register({
  ['<leader>'] = { name = 'VISUAL <leader>' },
  ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })
]]
--


-- Table of each lsp servers that needs to be installed and their configuration
local servers = {
	pylsp = {},
	tsserver = {},
	bufls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
			-- diagnostics = { disable = { 'missing-fields' } },
		},
	},
	c = {}
}


-- Broadcasting additional completion capabilities to nvim-cmp
-- TODO Understand what this is about
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

return {
	'neovim/nvim-lspconfig',
	dependencies = {
		-- nvim java lsp
		'mfussenegger/nvim-jdtls',
		-- Automatically install LSPs to stdpath for neovim
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',

		-- Useful status updates for LSP
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ 'j-hui/fidget.nvim', opts = {} },

		-- Additional lua configuration, makes nvim stuff amazing!
		'folke/neodev.nvim',
	},
	config = function()
		require('mason').setup({})
		require('mason-lspconfig').setup()
		require('neodev').setup({
			library = { plugins = { "nvim-dap-ui" }, types = true }
		})

		local mason_lspconfig = require 'mason-lspconfig'
		-- Ensuring that every lsp clients mentioned in our servers table are installed
		mason_lspconfig.setup {
			ensure_installed = vim.tbl_keys(servers)
		}

		-- Setting up handlers for the lsp defined in the servers table
		mason_lspconfig.setup_handlers {
			function(server_name)
				-- do not setup jdtls as it is already setup in java_setup.lua
				if server_name == 'jdtls' then
					return
				end
				require('lspconfig')[server_name].setup {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				}
			end,
		}

		-- We will have LSPs clients configuration that are not supported by Mason under here
		require('plugins.lsp.dart_setup').setup_dart_lsp(on_attach, capabilities)
		-- Having some issues to setup the python servers using the function setup_handlers above. Will do it here for now
		require('plugins.lsp.python_settings').setup_python_lsp(on_attach, capabilities)
		-- Setting up the java lsp
		-- require('plugins.lsp.java_setup').setup_java_lsp(on_attach, capabilities)
	end
}
