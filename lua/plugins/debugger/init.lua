return {
	"rcarriga/nvim-dap-ui",

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",
		"nvim-telescope/telescope-dap.nvim",
		"mfussenegger/nvim-dap",
		"theHamsta/nvim-dap-virtual-text",
		"mfussenegger/nvim-dap-python"
	},
	config = function()
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
		require("dap-python").test_runner = "pytest"
		require("nvim-dap-virtual-text").setup()
		require("telescope").load_extension("dap")

		-- Setting keymaps for debugger
		vim.keymap.set("n", "<leader>dc", ":lua require('dap').continue()<CR>", { desc = "Debbuger continue" })
		vim.keymap.set("n", "<leader>do", ":lua require('dap').step_over()<CR>", { desc = "Debbuger step over" })
		vim.keymap.set("n", "<leader>di", ":lua require('dap').step_into()<CR>", { desc = "Debbuger step into" })
		vim.keymap.set("n", "<leader>dO", ":lua require('dap').step_out()<CR>", { desc = "Debbuger step out" })
		vim.keymap.set("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>",
			{ desc = "Debbuger toggle breakpoint" })
		vim.keymap.set("n", "<leader>dB", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
			{ desc = "Debbuger set breakpoint with condition" })
		vim.keymap.set("n", "<leader>dr", ":lua require('dap').repl.open()<CR>", { desc = "Debbuger open repl" })
	end
}
