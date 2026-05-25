return {
	"MagicDuck/grug-far.nvim",
	-- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
	-- additional lazy config to defer loading is not really needed...
	keys = {
		{
			"<leader>S",
			function()
				require("grug-far").open({ transient = true })
			end,
			desc = "GrugFar: Search and Replace",
		},
		{
			"<leader>SS",
			function()
				require("grug-far").open({ transient = true })
			end,
			desc = "GrugFar: Search and Replace",
		},
		{
			"<leader>Ss",
			function()
				require("grug-far").open({ transient = true })
			end,
			desc = "GrugFar: Search and Replace",
		},
		{
			"<leader>Sw",
			function()
				require("grug-far").open({
					prefills = { search = vim.fn.expand("<cword>") },
				})
			end,
			desc = "GrugFar: Search current word",
		},
	},
	config = function()
		-- optional setup call to override plugin options
		-- alternatively you can set options with vim.g.grug_far = { ... }
		require("grug-far").setup({
			-- options, see Configuration section below
			-- there are no required options atm
		})
	end,
}
