-- data-viewer.lua
return {
	"vidocqh/data-viewer.nvim",
	ft = { "csv", "tsv", "sqlite" },
	opts = {},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"kkharji/sqlite.lua", -- Optional, sqlite support
	},
}
