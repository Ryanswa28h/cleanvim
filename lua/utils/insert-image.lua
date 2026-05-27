M = {}

M.insert_image = function()
	local path = vim.fn.input("Image path: ")

	if path == "" then
		return
	end

	-- Get filename without extension for alt text
	local filename = vim.fn.fnamemodify(path, ":t:r")

	-- Escape spaces for markdown paths
	local escaped_path = path:gsub(" ", "%%20")

	local line = string.format("![%s](%s)", filename, escaped_path)

	vim.api.nvim_put({ line }, "l", true, true)
end

return M
