return {
	"zbirenbaum/copilot.lua",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = true,
				auto_refresh = true,
				keymap = {
					jump_prev = "<leader>xp",
					jump_next = "<leader>xn",
					accept = "<leader>xc",
					refresh = "<leader>xr",
					open = "<leader>xo",
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<leader>xx",
					accept_line = "<leader>xl",
					accept_word = "<leader>xw",
					next = "<leader>xn",
					prev = "<leader>xp",
					dismiss = "<leader>xd",
				},
			},
		})
	end,
}
