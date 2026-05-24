return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		local ts_pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

		require("Comment").setup({
			pre_hook = function(ctx)
				local cs = ts_pre_hook(ctx)

				if cs == nil or cs == "" or not cs:find("%%s") then
					return "# %s"
				end

				return cs
			end,
		})
	end,
}
