local theme_cache = vim.fn.stdpath("data") .. "/last_theme_cvim.lua"

local function save_state(theme, transparent)
	if not theme or theme == "" or theme == "lazy" then
		return
	end
	local file = io.open(theme_cache, "w")
	if file then
		file:write(string.format("return { theme = '%s', transparent = %s }", theme, tostring(transparent)))
		file:close()
	end
end

local function lighten(hex, amount)
	hex = hex:gsub("#", "")

	local r = tonumber(hex:sub(1, 2), 16)
	local g = tonumber(hex:sub(3, 4), 16)
	local b = tonumber(hex:sub(5, 6), 16)

	amount = math.max(0, math.min(1, amount))

	local function blend(c)
		return math.floor(c + (255 - c) * amount + 0.5)
	end

	return string.format("#%02x%02x%02x", blend(r), blend(g), blend(b))
end

local function set_fold_hl()
	local normal = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false })

	local bg = normal.bg
	if not bg or bg == 0 then
		bg = tonumber("1e1e2e", 16)
	end

	bg = string.format("#%06x", bg)

	vim.api.nvim_set_hl(0, "Folded", {
		bg = lighten(bg, 0.08),
		fg = "#6b7280",
		italic = true,
	})
end

local function load_state()
	local f = loadfile(theme_cache)
	local ok, data = pcall(function()
		return f and f()
	end)
	if ok and data then
		return data
	else
		return { theme = "onedark", transparent = false }
	end
end

local state = load_state()

local function apply_theme_config(theme_name, transparent)
	local status, _ = pcall(function()
		if theme_name:find("onedark") then
			require("onedark").setup({ style = "darker", transparent = transparent })
		elseif theme_name:find("catppuccin") then
			require("catppuccin").setup({ transparent_background = transparent })
		elseif theme_name:find("tokyonight") then
			require("tokyonight").setup({ transparent = transparent })
		elseif theme_name:find("nord") then
			vim.g.nord_disable_background = transparent
		end
	end)
	return status
end

-- Colorscheme autocommand
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- Load persistent theme
		local name = vim.g.colors_name
		if name and name ~= "" and name ~= "lazy" then
			save_state(name, state.transparent)
		end
		-- Set blinkcmp colors
		local set_hl = vim.api.nvim_set_hl
		set_hl(0, "BlinkCmpSourceCopilot", { fg = "#6CC644", italic = true })
		set_hl(0, "BlinkCmpSourceLsp", { fg = "#7AA2F7", bold = true })
		set_hl(0, "BlinkCmpSourceSnippets", { fg = "#f38ba8" })
		set_hl(0, "BlinkCmpSourceBuffer", { fg = "#9ECE6A" })
		set_hl(0, "BlinkCmpSourcePath", { fg = "#E0AF68" })
		-- Set fold color
		set_fold_hl()
	end,
})

vim.keymap.set("n", "<leader>bg", function()
	state.transparent = not state.transparent
	apply_theme_config(vim.g.colors_name, state.transparent)
	vim.cmd.colorscheme(vim.g.colors_name)
	save_state(vim.g.colors_name, state.transparent)
end, { desc = "Toggle Transparency" })

local function finalize_theme()
	apply_theme_config(state.theme, state.transparent)
	pcall(vim.cmd.colorscheme, state.theme)
end

vim.schedule(function()
	finalize_theme()
end)

return {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		enabled = false,
		config = finalize_theme,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		enabled = false,
		config = finalize_theme,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		enabled = false,
		config = finalize_theme,
	},
	{
		"shaunsingh/nord.nvim",
		lazy = false,
		priority = 1000,
		enabled = false,
		config = finalize_theme,
	},
}
