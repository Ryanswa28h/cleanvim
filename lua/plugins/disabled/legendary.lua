-- Legendary.nvim
return {
	"mrjones2014/legendary.nvim",
	event = "VeryLazy",
	keys = {
		{ "<C-p>", "<cmd>Legendary<CR>", desc = "Search Commands & Keys", nowait = true },
	},
	opts = {
		-- 1. Tell it to grab everything you've already defined
		include_builtin = true,

		-- 2. This is the key: it hooks into which-key and your existing maps
		extensions = {
			which_key = { auto_register = true },
			lazy_nvim = true, -- Let's you search plugin commands
		},

		-- 3. Scrub out any default legendary bindings you don't want
		default_itemgroups = false,
		default_keymaps = false,
	},
}
