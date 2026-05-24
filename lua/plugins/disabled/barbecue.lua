-- barbecue.lua
return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- or your mini.icons mock
	},
	opts = {
		-- configurations go here
		show_modified = true, -- shows a dot if the file is unsaved
	},
}
