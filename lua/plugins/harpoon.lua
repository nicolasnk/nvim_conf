return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon.setup()
		vim.keymap.set("n", "<leader>ja", function() harpoon:list():append() end)
		vim.keymap.set("n", "<leader>jh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		vim.keymap.set("n", "<leader>jj", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<leader>jk", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<leader>jl", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<leader>j;", function() harpoon:list():select(4) end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>jP", function() harpoon:list():prev() end)
		vim.keymap.set("n", "<leader>jN", function() harpoon:list():next() end)
	end
}
