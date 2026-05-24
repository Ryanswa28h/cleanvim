vim.keymap.set("n", "<bs>", "<CMD>Oil<CR>", { desc = "Open parent directory" })
return {
	"stevearc/oil.nvim",
	default_file_explorer = false,
	opts = {
		keymaps = {
			["l"] = "actions.select", -- Open the file/folder under cursor
			["h"] = "actions.parent", -- Go up to the parent directory
		},
	},
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	lazy = false,
	view_options = {
		show_hidden = true,
	},
	config = function(_, opts)
		require("oil").setup(opts)
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory with Oil" })
	end,
}
