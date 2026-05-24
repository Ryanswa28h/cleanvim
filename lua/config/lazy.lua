local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins.ai" },
		{ import = "plugins.coding" },
		{ import = "plugins.lsp" },
		{ import = "plugins.editor" },
		{ import = "plugins.git" },
		{ import = "plugins.ui" },
		{ import = "plugins.markdown" },
		{ import = "plugins.data" },
		{ import = "plugins.misc" },
	},
	performance = {
		cache = { enabled = true },
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
