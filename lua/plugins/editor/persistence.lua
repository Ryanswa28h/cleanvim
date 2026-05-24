return {
	"folke/persistence.nvim",
	lazy = false,
	opts = {
		dir = vim.fn.stdpath("state") .. "/sessions/",
		options = { "buffers", "curdir", "tabpages", "winsize" },
	},
	config = function(_, opts)
		require("persistence").setup(opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "PersistenceSavePre",
			callback = function()
				if vim.bo.filetype == "undotree" then
					vim.cmd("UndotreeHide")
				end
			end,
		})
	end,
}
