-- illuminate.lua
return {
	"RRethy/vim-illuminate",
	event = "VeryLazy",
	config = function()
		require("illuminate").configure({
			delay = 200,
			large_file_cutoff = 2000,
			providers = { "regex" },
			under_cursor = true,
		})
	end,
}
