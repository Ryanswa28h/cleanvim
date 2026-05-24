return {
	"supermaven-inc/supermaven-nvim",
	event = "InsertEnter",
	opts = {
		keymaps = {
			accept_suggestion = "<C-g>",
			clear_suggestion = "<C-]>",
			accept_word = "<C-j>",
		},
		color = {
			suggestion_color = "#808080",
		},
		disable_inline_completion = false,
	},
}
