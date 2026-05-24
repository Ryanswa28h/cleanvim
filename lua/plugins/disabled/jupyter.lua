return {
	{
		"benlubas/molten-nvim",
		build = ":UpdateRemotePlugins",
		init = function()
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = true -- Aligns ghost text better with # %%
			vim.g.molten_wrap_output = true
			vim.g.molten_auto_open_output = false
			vim.g.molten_image_provider = "image.nvim"
		end,
	},
	{
		"GCBallesteros/jupytext.nvim",
		opts = {
			custom_language_formatting = {
				python = {
					extension = "py",
					style = "hydrogen",
					force_ft = "python",
				},
			},
		},
		config = function()
			local function init_notebook()
				local header = {
					"# ---",
					"# jupyter:",
					"#   kernelspec:",
					"#     display_name: Python 3",
					"#     name: python3",
					"# ---",
					"",
					"# %%",
				}
				vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
			end

			local function run_smart_cell()
				local bufnr = vim.api.nvim_get_current_buf()
				local cursor_row = vim.api.nvim_win_get_cursor(0)[1]
				local line_count = vim.api.nvim_buf_line_count(bufnr)

				local start_line = 1
				local end_line = line_count

				-- Search upwards for the previous # %%
				for i = cursor_row, 1, -1 do
					local line = vim.api.nvim_buf_get_lines(bufnr, i - 1, i, false)[1]
					if line:match("^# %%%%") then
						start_line = i + 1 -- Start after the marker
						break
					end
				end

				-- Search downwards for the next # %%
				for i = cursor_row + 1, line_count do
					local line = vim.api.nvim_buf_get_lines(bufnr, i - 1, i, false)[1]
					if line:match("^# %%%%") then
						end_line = i - 1 -- End before the next marker
						break
					end
				end

				if start_line <= end_line then
					vim.fn.MoltenEvaluateRange(start_line, end_line)
				end
			end

			vim.keymap.set("n", "<leader>rbin", init_notebook, { desc = "Initialize Notebook Header" })
			vim.keymap.set("n", "<leader>rrn", "<cmd>MoltenInit<CR>", { desc = "Run Smart Cell" })
			vim.keymap.set("n", "<leader>rmd", "<cmd>MoltenDelete<CR>", { desc = "Molten Delete" })
			vim.keymap.set("n", "<leader>rr", run_smart_cell, { desc = "Run Smart Cell" })
			vim.keymap.set("n", "<leader>ra", function()
				local line_count = vim.api.nvim_buf_line_count(0)
				vim.fn.MoltenEvaluateRange(1, line_count)
			end, { desc = "Molten: Run Entire File" })
		end,
	},
}
