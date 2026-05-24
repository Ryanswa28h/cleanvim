local M = {}

function M.open_float(path, saveOnExit)
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	})

	-- Open the file in the floating buffer
	vim.cmd("edit " .. path)

	if saveOnExit then
		vim.keymap.set("n", "q", "<cmd>wq<cr>", { buffer = true, silent = true })
		vim.keymap.set("n", "<ESC>", "<cmd>wq<cr>", { buffer = true, silent = true })
	else
		vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = true, silent = true })
		vim.keymap.set("n", "<ESC>", "<cmd>q<cr>", { buffer = true, silent = true })
	end
end

return M
