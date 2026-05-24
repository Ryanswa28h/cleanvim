local M = {}

function M.swap()
	local word = vim.fn.expand("<cword>")
	local swaps = {
		["true"] = "false",
		["false"] = "true",
		["True"] = "False",
		["False"] = "True",
		["TRUE"] = "FALSE",
		["FALSE"] = "TRUE",
		["1"] = "0",
		["0"] = "1",
		["yes"] = "no",
		["no"] = "yes",
		["Yes"] = "No",
		["No"] = "Yes",
		["else"] = "if",
		["if"] = "else",
	}

	if swaps[word] then
		vim.cmd("normal! ciw" .. swaps[word])
		vim.cmd("silent! call repeat#set('g!', 1)")
	else
		vim.notify("No alternative available")
	end
end

return M
