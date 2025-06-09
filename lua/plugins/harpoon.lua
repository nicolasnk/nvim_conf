return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon.setup()
		vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end, { desc = "Append file to harpoon list" })
		vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
			{ desc = "Toggle harpoon quick menu" })

		vim.keymap.set("n", "<leader>j", function() harpoon:list():select(1) end, {desc="Jump to harpoon file 1"})
		vim.keymap.set("n", "<leader>k", function() harpoon:list():select(2) end, {desc="Jump to harpoon file 2"})
		vim.keymap.set("n", "<leader>l", function() harpoon:list():select(3) end, {desc="Jump to harpoon file 3"})
		vim.keymap.set("n", "<leader>;", function() harpoon:list():select(4) end, {desc="Jump to harpoon file 4"})

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>P", function() harpoon:list():prev() end, {desc="Go to previous buffer in the harpoon list"})
		vim.keymap.set("n", "<leader>N", function() harpoon:list():next() end, {desc="Go to next buffer in the harpoon list"})
	end
}
