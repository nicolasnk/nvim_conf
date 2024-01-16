return {
	"zbirenbaum/copilot.lua",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = true,
				auto_refresh = true,
				keymap = {
					jump_prev = "<leader>cp",
					jump_next = "<leader>cn",
					accept = "<leader>cc",
					refresh = "<leader>cr",
					open = "<leader>co",
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<leader>cc",
					accept_line = "<leader>cl",
					accept_word = "<leader>cw",
					next = "<leader>cn",
					prev = "<leadet>cp",
					dismiss = "<leader>cd",
				},
			},
		})
	end,
}
