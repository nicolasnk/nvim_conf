return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon.setup()
		vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end)
		vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		vim.keymap.set("n", "<C-h-j>", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<C-h-k>", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<C-h-l>", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<C-h-;>", function() harpoon:list():select(4) end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-h-P>", function() harpoon:list():prev() end)
		vim.keymap.set("n", "<C-h-N>", function() harpoon:list():next() end)
	end
}
