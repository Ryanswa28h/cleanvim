return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end,
			mode = "",
			desc = "Format buffer or range",
		},
	},
	opts = {
		formatters = {
			biome = {
				require_cwd = false, -- Allow running biome even without biome.json
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format", "ruff_organize_imports" },
			javascript = { "biome" },
			typescript = { "biome" },
			typescriptreact = { "biome" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			sh = { "shfmt" },
			cpp = { "clang-format" }, -- Prettier C++ support is often finicky; clang-format is standard
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
			shfmt = {
				prepend_args = { "-i", "4" },
			},
		},
	},
}
