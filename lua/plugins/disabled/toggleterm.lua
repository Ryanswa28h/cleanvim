return {
	"akinsho/toggleterm.nvim",
	version = "*",
	-- Load the plugin when you trigger the keymap or call the command
	keys = { [[<C-\>]] },
	cmd = {
		"ToggleTerm",
		"ToggleTermToggleAll",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualLines",
		"ToggleTermSendVisualSelection",
		"ToggleTermSetName",
	},
	opts = {
		open_mapping = [[<C-\>]],

		direction = "horizontal", -- can be 'horizontal', 'vertical', 'float', or 'tab'
		size = 15,
		hide_numbers = true,
		shade_terminals = true,
		start_in_insert = true,
		insert_mappings = true,
		terminal_mappings = true,
		persist_size = true,
		close_on_exit = true,
		shell = vim.o.shell,
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		local function set_terminal_keymaps()
			local map = vim.keymap.set
			local opts_buf = { buffer = 0 }

			map("t", "<Esc>", [[<C-\><C-n>]], opts_buf)

			map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts_buf)
			map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts_buf)
			map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts_buf)
			map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts_buf)

			map("t", "<C-w>", [[<C-\><C-n><C-w>]], opts_buf)
		end

		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*toggleterm#*",
			callback = set_terminal_keymaps,
		})
	end,
}
