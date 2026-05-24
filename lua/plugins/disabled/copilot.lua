return {
	"github/copilot.vim",
	event = "VimEnter",
	config = function()
		-- Disable default <Tab> to prevent conflicts with blink.cmp
		vim.g.copilot_no_tab_map = true
		vim.g.copilot_assume_mapped = true

		-- Accept suggestion
		vim.keymap.set("i", "<C-g>", 'copilot#Accept("<CR>")', {
			expr = true,
			replace_keycodes = false,
			silent = true,
			desc = "Copilot Accept",
		})
		-- vim.keymap.set("i", "<Tab>", function()
		-- 	-- 1. If blink.cmp menu is visible → accept completion
		-- 	if require("blink.cmp").is_visible() then
		-- 		return require("blink.cmp").accept()
		-- 	end
		--
		-- 	-- 2. If Copilot suggestion is visible → accept it
		-- 	if vim.fn["copilot#GetDisplayedSuggestion"]() ~= "" then
		-- 		return vim.fn["copilot#Accept"]("<CR>")
		-- 	end
		--
		-- 	-- 3. Otherwise → insert Tab
		-- 	return "\t"
		-- end, {
		-- 	expr = true,
		-- 	replace_keycodes = false,
		-- 	silent = true,
		-- })

		-- Cycle to next suggestion
		vim.keymap.set("i", "<C-;>", "<Plug>(copilot-next)", {
			desc = "Copilot Next",
		})

		-- Cycle to previous suggestion
		vim.keymap.set("i", "<C-,>", "<Plug>(copilot-previous)", {
			desc = "Copilot Prev",
		})

		-- Clear suggestion
		vim.keymap.set("i", "<C-x>", "<Plug>(copilot-dismiss)", {
			desc = "Copilot Dismiss",
		})
	end,
}
