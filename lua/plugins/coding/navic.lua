-- navic.lua
return {
	"SmiteshP/nvim-navic",
	enabled = false,
	event = { "BufReadPost", "BufNewFile" },
	dependencies = "neovim/nvim-lspconfig",
	opts = {
		lsp = {
			auto_attach = true,
			preference = { "lua_ls", "pyright", "clangd" },
		},
		highlight = true,
		separator = " > ",
		click_to_skip = true,
		depth_limit = 3,
		depth_limit_indicator = "..",
		filter_errors = true,
		filter_kinds = {
			"Class",
			-- "Constructor",
			-- "Enum",
			"Function",
			-- "Interface",
			"Method",
			-- "Module",
			"Struct",
		},
	},
	config = function(_, opts)
		local navic = require("nvim-navic")
		navic.setup(opts)

		-- Optional: If you want to EXCLUDE specific types globally
		-- (e.g., don't show Variables or Packages)
		vim.g.navic_silence = true -- Keeps it quiet if no LSP is attached
	end,
}
