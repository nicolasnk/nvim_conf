return {
	"nvim-neotest/neotest-python",
	dependencies = {
		"nvim-neotest/neotest",
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-dap-python",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter"
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					runner = "pytest",
					dap = { justMyCode = false },
				}),
			},
		})
		vim.keymap.set("n", "<leader>t", require("neotest").run.run, { desc = "Running the current test" })
		vim.keymap.set("n", "<leader>T", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
			{ desc = "Running test on the entire file" })
		-- Configuring running test with debugger
		vim.keymap.set("n", "<leader>td", require("neotest").run.run({strategy = "dap"}), { desc = "Running the current test with debugger" })
	end
}
