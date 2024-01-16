return {
	"nvim-neotest/neotest-python",
	dependencies = {
		"nvim-neotest/neotest",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter"
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({}),
			},
		})
		vim.keymap.set("n", "<leader>rt", require("neotest").run.run, { desc = "Running the current test" })
		vim.keymap.set("n", "<leader>rT", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
			{ desc = "Running test on the entire file" })
	end
}
