local function open_today_journal()
	local date = os.date("%m-%d-%y")
	local dir = vim.fn.expand("~/.notes/journal")
	local path = dir .. "/" .. date .. ".md"

	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	end

	if vim.fn.filereadable(path) == 0 then
		local template = { "# Journal — " .. date, "", "## Journal", "", "- ", "", "---", "", "## Notes", "" }
		vim.fn.writefile(template, path)
	end

	-- require("utils.float").open_float(path, true)
	vim.cmd("edit " .. path)

	vim.cmd("normal! gg/^## Journal<CR>jj$")
end

return open_today_journal
