return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"moll/vim-bbye",
		"nvim-tree/nvim-web-devicons",
	},
	enabled = false,
	event = "VeryLazy",
	config = function()
		require("bufferline").setup({
			options = {
				-- groups = {
				-- 	items = {
				-- 		{
				-- 			name = "Config",
				-- 			icon = " ",
				-- 			matcher = function(buf)
				-- 				return buf.path:match("init.lua")
				-- 					or buf.path:match(".config")
				-- 					or buf.path:match("%.json")
				-- 					or buf.path:match("%.toml")
				-- 			end,
				-- 		},
				-- 		{
				-- 			name = "Infra",
				-- 			icon = "󱂚 ",
				-- 			matcher = function(buf)
				-- 				return buf.path:match("%.css")
				-- 					or buf.path:match("%.scss")
				-- 					or buf.path:match("Dockerfile")
				-- 					or buf.path:match("docker-compose")
				-- 			end,
				-- 		},
				-- 		{
				-- 			name = "Tests",
				-- 			icon = " ",
				-- 			matcher = function(buf)
				-- 				return buf.path:match("_spec") or buf.path:match("_test") or buf.path:match("tests/")
				-- 			end,
				-- 		},
				-- 		{
				-- 			name = "Docs",
				-- 			icon = "󰈙 ",
				-- 			matcher = function(buf)
				-- 				return buf.path:match("%.md") or buf.path:match("%.txt") or buf.path:match("docs/")
				-- 			end,
				-- 		},
				-- 	},
				-- },
				mode = "buffers", -- set to "tabs" to only show tabpages instead
				themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
				numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
				close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
				right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
				left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
				middle_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
				-- buffer_close_icon = '󰅖',
				buffer_close_icon = "󰅖",
				-- buffer_close_icon = '✕',
				close_icon = "",
				path_components = 1,
				modified_icon = "●",
				left_trunc_marker = "",
				show_duplicate_prefix = true,
				sort_by = "insert_at_end",
				right_trunc_marker = "",
				max_name_length = 18,
				max_prefix_length = 12, -- prefix used when a buffer is de-duplicated
				tab_size = 18,
				truncate_names = true,
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local icon = level:match("error") and " " or level:match("warning") and " " or " "

					return " " .. icon .. count
				end,
				diagnostics_update_in_insert = false,
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				sersist_buffer_sort = true, -- whether or not custom sorted buffers should persist
				separator_style = "thick", -- slant or slope [[ { "│", "│" }, -- | "thick" | "thin" | { 'any', 'any' }, ]]
				enforce_regular_tabs = false,
				always_show_bufferline = false,
				show_tab_indicators = false,
				indicator = {
					-- icon = '▎', -- this should be omitted if indicator style is not 'icon'
					style = "icon", -- Options: 'icon', 'underline', 'none'
				},
				icon_pinned = "󰐃",
				minimum_padding = 1,
				maximum_padding = 5,
				maximum_length = 15,
			},
			highlights = {
				-- separator = {
				-- 	fg = "#434C5E",
				-- },
				buffer_selected = {
					bold = true,
					italic = false,
				},
				-- separator_selected = {},
				-- tab_selected = {},
				-- background = {},
				-- indicator_selected = {},
				-- fill = {},
			},
		})

		-- Keymaps
		local opts = { noremap = true, silent = true, desc = "Go to Buffer" }
		-- Use <leader><S-(1-9)> to go to buffer 1-9, respectively
		-- vim.keymap.set("n", "<leader>!", "<cmd>lua require('bufferline').go_to_buffer(1)<CR>", opts)
		-- vim.keymap.set("n", "<leader>@", "<cmd>lua require('bufferline').go_to_buffer(2)<CR>", opts)
		-- vim.keymap.set("n", "<leader>#", "<cmd>lua require('bufferline').go_to_buffer(3)<CR>", opts)
		-- vim.keymap.set("n", "<leader>$", "<cmd>lua require('bufferline').go_to_buffer(4)<CR>", opts)
		-- vim.keymap.set("n", "<leader>%", "<cmd>lua require('bufferline').go_to_buffer(5)<CR>", opts)
		-- vim.keymap.set("n", "<leader>^", "<cmd>lua require('bufferline').go_to_buffer(6)<CR>", opts)
		-- vim.keymap.set("n", "<leader>&", "<cmd>lua require('bufferline').go_to_buffer(7)<CR>", opts)
		-- vim.keymap.set("n", "<leader>*", "<cmd>lua require('bufferline').go_to_buffer(8)<CR>", opts)
		-- vim.keymap.set("n", "<leader>(", "<cmd>lua require('bufferline').go_to_buffer(9)<CR>", opts)
		vim.keymap.set("n", "<leader>1", "<cmd>lua require('bufferline').go_to_buffer(1)<CR>", opts)
		vim.keymap.set("n", "<leader>2", "<cmd>lua require('bufferline').go_to_buffer(2)<CR>", opts)
		vim.keymap.set("n", "<leader>3", "<cmd>lua require('bufferline').go_to_buffer(3)<CR>", opts)
		vim.keymap.set("n", "<leader>4", "<cmd>lua require('bufferline').go_to_buffer(4)<CR>", opts)
		vim.keymap.set("n", "<leader>5", "<cmd>lua require('bufferline').go_to_buffer(5)<CR>", opts)
		vim.keymap.set("n", "<leader>6", "<cmd>lua require('bufferline').go_to_buffer(6)<CR>", opts)
		vim.keymap.set("n", "<leader>7", "<cmd>lua require('bufferline').go_to_buffer(7)<CR>", opts)
		vim.keymap.set("n", "<leader>8", "<cmd>lua require('bufferline').go_to_buffer(8)<CR>", opts)
		vim.keymap.set("n", "<leader>9", "<cmd>lua require('bufferline').go_to_buffer(9)<CR>", opts)
		vim.keymap.set("n", "<leader><cr>", "<cmd>BufferLinePick<CR>", opts)
		vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", opts)
	end,
}
