local function run_file()
	local file = vim.fn.expand("%")
	local ft = vim.bo.filetype

	if file == "" then
		vim.notify("No file to run", vim.log.levels.WARN)
		return
	end

	vim.cmd("w")

	local cmd
	if ft == "python" then
		cmd = "python " .. file
	elseif ft == "javascript" then
		cmd = "node " .. file
	elseif ft == "typescript" then
		cmd = "ts-node " .. file
	elseif ft == "lua" then
		cmd = "lua " .. file
	elseif ft == "sh" then
		cmd = "bash " .. file
	elseif ft == "c" then
		cmd = "gcc " .. file .. " -o /tmp/a.out && /tmp/a.out"
	elseif ft == "cpp" then
		cmd = "g++ " .. file .. " -o /tmp/a.out && /tmp/a.out"
	elseif ft == "go" then
		cmd = "go run " .. file
	elseif ft == "rust" then
		cmd = "cargo run"
	else
		vim.notify("No runner for filetype: " .. ft, vim.log.levels.ERROR)
		return
	end

	vim.cmd("botright split | terminal " .. cmd)
end

return {
	"coderunner",
	virtual = true,
	keys = {
		{ "<leader>r", run_file, desc = "Run current file" },
	},
}
