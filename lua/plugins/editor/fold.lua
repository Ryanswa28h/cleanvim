return {
	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			require("ufo").setup({
				fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
					local newVirtText = {}
					local suffix = ""
					if (endLnum - lnum) > 1 then
						suffix = (" [%d lines]"):format(endLnum - lnum)
					else
						suffix = (" [%d line]"):format(endLnum - lnum)
					end
					local sufWidth = vim.fn.strdisplaywidth(suffix)
					local targetWidth = width - sufWidth
					local curWidth = 0

					for _, chunk in ipairs(virtText) do
						local chunkText = chunk[1]
						local chunkWidth = vim.fn.strdisplaywidth(chunkText)

						if targetWidth > curWidth + chunkWidth then
							table.insert(newVirtText, chunk)
						else
							chunkText = truncate(chunkText, targetWidth - curWidth)
							table.insert(newVirtText, { chunkText, chunk[2] })
							chunkWidth = vim.fn.strdisplaywidth(chunkText)

							if curWidth + chunkWidth < targetWidth then
								suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
							end

							break
						end

						curWidth = curWidth + chunkWidth
					end

					table.insert(newVirtText, { suffix, "MoreMsg" })

					return newVirtText
				end,
				provider_selector = function(bufnr, filetype, buftype)
					if filetype == "markdown" then
						return { "treesitter", "indent" }
					end

					return { "lsp", "indent" }
				end,
			})
		end,
	},
	{
		"chrisgrieser/nvim-origami",
		version = "v1.9",
		event = "BufReadPost",

		opts = {
			pauseFoldsOnSearch = true,
			pauseFoldsOnInsert = true,
		},
	},
	{
		"jghauser/fold-cycle.nvim",
		event = "VeryLazy",
		opts = {},
		init = function()
			vim.keymap.set("n", "zr", function()
				return require("fold-cycle").open()
			end, { desc = "Fold-cycle: open next level" })
			vim.keymap.set("n", "zm", function()
				return require("fold-cycle").close()
			end, { desc = "Fold-cycle: close next level" })
			vim.keymap.set("n", "zC", function()
				return require("fold-cycle").close_all()
			end, { desc = "Fold-cycle: close everything in this block" })
		end,
	},
}
