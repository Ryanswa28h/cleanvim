local function open_or_create_todo()
	local path = vim.fn.expand("~/todo.md")

	if vim.fn.filereadable(path) == 0 then
		local template = { "# Tasks", "", "- [ ] ", "" }
		vim.fn.writefile(template, path)
	end

	-- require("utils.float").open_float(path, true)
	vim.cmd("edit " .. path)
end

return open_or_create_todo
