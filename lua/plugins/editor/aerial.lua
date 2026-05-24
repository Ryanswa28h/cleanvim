return {
	"stevearc/aerial.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>O", "<cmd>AerialToggle!<CR>", desc = "Aerial Outline" },
		{ "<leader>cs", "<cmd>AerialToggle!<CR>", desc = "Aerial Outline" },
		{
			"<leader>ss",
			function()
				require("aerial").snacks_picker()
			end,
			desc = "Search Symbols (Aerial)",
		},
		{ "[[", "<cmd>AerialPrev<CR>", desc = "Previous Symbol" },
		{ "]]", "<cmd>AerialNext<CR>", desc = "Next Symbol" },
	},
	opts = function()
		return {
			backends = { "lsp", "treesitter", "markdown", "man" },
			filter_kind = false,

			layout = {
				min_width = 25,
				default_direction = "left",
				placement = "window",
			},

			show_guides = true,
			icons = {},
		}
	end,
}
