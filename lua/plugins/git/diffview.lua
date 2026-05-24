return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	keys = {
		-- Basic Diff Views
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview: Working Tree" },
		{ "<leader>gdd", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: File History" },

		-- Compare Specific Commits/Branches
		{
			"<leader>gdo",
			function()
				vim.ui.input({ prompt = "Diff refs (ex: main..feature): " }, function(refs)
					if refs and refs:match("%S") then
						vim.cmd("DiffviewOpen " .. vim.fn.shellescape(refs))
					else
						vim.cmd("DiffviewOpen")
					end
				end)
			end,
			desc = "Diffview: Open (prompt refs)",
		},

		-- Quick Comparisons
		{ "<leader>gdc", "<cmd>DiffviewOpen HEAD~1<cr>", desc = "Diffview: vs Last Commit" },
		{ "<leader>gdm", "<cmd>DiffviewOpen origin/main<cr>", desc = "Diffview: vs origin/main" },

		-- Close/Refresh
		{ "<leader>gdq", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" },
		{ "<leader>gdQ", "<cmd>DiffviewClose!<cr>", desc = "Diffview: Close All" },
		{ "<leader>gdr", "<cmd>DiffviewRefresh<cr>", desc = "Diffview: Refresh" },
	},
}
