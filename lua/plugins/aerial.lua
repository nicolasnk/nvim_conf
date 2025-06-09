return {
	'stevearc/aerial.nvim',
	opts = {},
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons"
	},
	config = function()
		require("aerial").setup({
			on_attach = function(bufnr)
				-- Jump forwards/backwards with '{' and '}'
				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Go to previous function" })
				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Go to next function" })
			end,
		})
		vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toogle Aerial View" })
	end
}
