-- satellite.lua
return {
	"lewis6991/satellite.nvim",
	event = "BufWinEnter",
	opts = { excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify", "neo-tree" } },
}
