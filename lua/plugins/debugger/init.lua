return {
	"mfussenegger/nvim-dap-python",

	dependencies = {
		"mfussenegger/nvim-dap"
	},
	config = function()
		root_dir = vim.fn.getcwd()
		py_path = root_dir .. "/build/lipy-langchain/environments/development-venv/bin/python"
		print("Python path: " .. py_path)
		require("dap-python").setup(py_path)
		require("dap-python").test_runner = "pytest"
	end
}
