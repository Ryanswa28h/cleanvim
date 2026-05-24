-- neoscroll.lua
return {
	"karb94/neoscroll.nvim",
	enabled = true,
	event = "WinScrolled", -- or "VeryLazy"
	config = function()
		local neoscroll = require("neoscroll")

		neoscroll.setup({
			duration_multiplier = 0.5,
			easing = "quadratic",
		})

		local keymap = {
			["<C-u>"] = function()
				neoscroll.ctrl_u({ duration = 150 })
			end,
			["<C-d>"] = function()
				neoscroll.ctrl_d({ duration = 150 })
			end,
		}

		local modes = { "n", "v", "x" }
		for key, func in pairs(keymap) do
			vim.keymap.set(modes, key, func, { silent = true })
		end
	end,
}
