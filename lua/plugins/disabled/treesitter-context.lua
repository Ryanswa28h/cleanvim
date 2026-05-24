-- treesitter-context.lua
return {
	-- Code header
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		vim.keymap.set("n", "co", function()
			require("treesitter-context").go_to_context(vim.v.count1)
		end, { silent = true })
	end,
}
