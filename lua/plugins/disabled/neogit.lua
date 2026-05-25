return {
	"NeogitOrg/neogit",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - adds better diffing
	},
	config = function()
		local neogit = require("neogit")
		neogit.setup({
			-- Use "floating" for a modern popup or "tab" for a full view
			kind = "floating",
			integrations = {
				diffview = true, -- Integrates with diffview.nvim
				-- telescope = true,
			},
		})

		-- Replace Fugitive's :G with a quick keybind
		vim.keymap.set("n", "<leader>gs", neogit.open, { desc = "Git Status (Neogit)" })
		vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { desc = "Git Commit" })
	end,
}
