-- Come back to treesitter to learn some new mapping

return {
	-- Highlight, edit, and navigate code
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
	},
	build = ':TSUpdate',
	config = function()
		require('nvim-treesitter.configs').setup {
			-- add languages to be installed here that you want installed for treesitter
			ensure_installed = { 'c', 'lua', 'python', 'vimdoc', 'vim', 'bash', 'dart', 'typescript', 'javascript', 'proto' },

			-- autoinstall languages that are not installed. defaults to false (but you can change for yourself!)
			auto_install = true,

			highlight = { enable = true },
			indent = { enable = true, disable = { 'dart' } },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<c-space>',
					node_incremental = '<c-space>',
					scope_incremental = '<c-s>',
					node_decremental = '<m-space>',
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- you can use the capture groups defined in textobjects.scm
						['aa'] = '@parameter.outer',
						['ia'] = '@parameter.inner',
						['af'] = '@function.outer',
						['if'] = '@function.inner',
						['ac'] = '@class.outer',
						['ic'] = '@class.inner',
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						[']m'] = '@function.outer',
						[']]'] = '@class.outer',
					},
					goto_next_end = {
						[']m'] = '@function.outer',
						[']['] = '@class.outer',
					},
					goto_previous_start = {
						['[m'] = '@function.outer',
						['[['] = '@class.outer',
					},
					goto_previous_end = {
						['[m'] = '@function.outer',
						['[]'] = '@class.outer',
					},
				},
				swap = {
					enable = false,
				},
			},
		}
	end
}
