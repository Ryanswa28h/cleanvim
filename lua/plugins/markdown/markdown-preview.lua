return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	keys = {
		{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview Toggle" },
	},
	ft = { "markdown" },
	-- Switch the build hook to run directly in your system shell:
	build = "cd app && npm install",
	init = function()
		-- This tells the plugin where its system binary lives
		vim.g.mkdp_filetypes = { "markdown" }
	end,
}
