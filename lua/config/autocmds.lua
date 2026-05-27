vim.api.nvim_create_autocmd("User", {
	pattern = "PersistenceLoadPost",
	callback = function()
		-- If there is more than one tab, close the first empty one
		if vim.fn.tabpagenr("$") > 1 then
			vim.cmd("tabclose 1")
		end
	end,
})

-- Disable mini.indentscope when opening the dashboard
vim.api.nvim_create_autocmd("User", {
	pattern = "SnacksDashboardOpened",
	callback = function(args)
		vim.b[args.buf].miniindentscope_disable = true
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "PersistenceSavePre",
	callback = function()
		-- Close ALL neo-tree windows before session is written
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(win)
			if vim.bo[buf].filetype == "neo-tree" then
				pcall(vim.api.nvim_win_close, win, true)
			end
		end
	end,
})

-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 120, visual = true })
	end,
})

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so it's applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
	pattern = { ".env", ".env.*" },
	callback = function()
		vim.bo.filetype = "dosini"
	end,
})

-- show cursorline only in active window enable
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

-- show cursorline only in active window disable
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = "active_cursorline",
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

-- local neotree = false
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function(data)
		-- vim.cmd("ShowkeysToggle") -- Enable showkeys on startup
		-- if vim.fn.isdirectory(data.file) == 1 then
		-- 	if neotree then
		-- 		vim.cmd("cd " .. data.file)
		-- 		require("lazy").load({ plugins = { "neo-tree.nvim" } })
		-- 		vim.cmd("Neotree reveal position=left")
		-- 	end
		-- end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"lua",
		"python",
		"javascript",
		"typescript",
		"vimdoc",
		"sh",
		"vim",
		"regex",
		"terraform",
		"sql",
		"dockerfile",
		"toml",
		"json",
		"java",
		"groovy",
		"go",
		"gitignore",
		"graphql",
		"yaml",
		"make",
		"cmake",
		"markdown",
		"markdown_inline",
		"latex",
		"bash",
		"zsh",
		"tsx",
		"css",
		"html",
		"cpp",
	},
	callback = function()
		vim.treesitter.start()
	end,
})
