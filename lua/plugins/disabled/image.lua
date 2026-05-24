return {
	"3rd/image.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		backend = "kitty", -- or any other terminal backend

		hijack_file_patterns = {},

		hijack_directories = false,
		hijack_buffer_gutters = false,

		integrations = {
			markdown = {
				enabled = true,
				clear_in_insert_mode = false,
				download_remote_images = true,
				only_render_image_at_cursor = false,
			},
			neorg = {
				enabled = true,
			},
		},

		skip_filetypes = {
			"minifiles",
			"neo-tree",
			"dashboard",
			"alpha",
			"qf",
			"terminal",
		},

		max_height_window_percentage = 50,
		window_overlap_clear_enabled = true,
	},
}
