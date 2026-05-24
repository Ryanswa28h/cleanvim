-- better-escape.lua
return {
	"max397574/better-escape.nvim",
	event = "InsertEnter",
	config = function()
		require("better_escape").setup({
			timeout = 200, -- time in ms to complete the sequence
			mappings = {
				i = { -- Insert mode
					j = {
						k = "<Esc>", -- jk
					},
					k = {
						j = "<Esc>", -- kj
					},
				},
				c = { -- Command mode
					j = { k = "<Esc>" },
					k = { j = "<Esc>" },
				},
				t = { -- Terminal mode
					j = { k = "<C-\\><C-n>" },
					k = { j = "<C-\\><C-n>" },
				},
			},
		})
	end,
}
