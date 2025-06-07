return {
	"nvim-neotest/neotest-python",
	dependencies = {
		"nvim-neotest/neotest",
		"nvim-neotest/nvim-nio",
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
					args = { "-vv" },
				}),
			},
		})
		vim.keymap.set("n", "<leader>tc", require("neotest").run.run, { desc = "Running the current test" })
		vim.keymap.set("n", "<leader>ta", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
			{ desc = "Running test on the entire file" })
		-- Configuring running test with debugger
		vim.keymap.set("n", "<leader>ti", ":lua require('neotest').run.run({strategy = 'dap'})<CR>",
			{ desc = "Running the current test with debugger" })
		-- Entering test window
		vim.keymap.set("n", "<leader>te", ":lua require('neotest').output.open({ enter = true, auto_close = false })<CR>",
			{ desc = "Entering test window" })
	end
}
