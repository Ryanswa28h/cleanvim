-- treesj.lua
return {
	"Wansmer/treesj",
	keys = { { "<leader>tt", "<CMD>TSJToggle<CR>", desc = "Toggle Treesitter Join/Split" } },
	cmd = { "TSJToggle" },
	opts = { use_default_keymaps = false },
}
