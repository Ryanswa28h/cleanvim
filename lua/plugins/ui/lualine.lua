return {
	"nvim-lualine/lualine.nvim",
	enabled = false,
	event = "VeryLazy",
	config = function()
		local colors = {
			blue = "#61afef",
			green = "#98c379",
			purple = "#c678dd",
			cyan = "#56b6c2",
			red1 = "#e06c75",
			red2 = "#be5046",
			yellow = "#e5c07b",
			fg = "#abb2bf",
			bg = "#282c34",
			gray1 = "#828997",
			gray2 = "#2c323c",
			gray3 = "#3e4452",
		}

		local onedark_theme = {
			normal = {
				a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
				b = { fg = colors.blue, bg = colors.gray2 }, -- Blue text on dark gray
				c = { fg = colors.fg, bg = colors.bg }, -- Matches editor background
			},
			command = { a = { fg = colors.bg, bg = colors.yellow, gui = "bold" } },
			insert = { a = { fg = colors.bg, bg = colors.green, gui = "bold" } },
			visual = { a = { fg = colors.bg, bg = colors.purple, gui = "bold" } },
			terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = "bold" } },
			replace = { a = { fg = colors.bg, bg = colors.red1, gui = "bold" } },
			inactive = {
				a = { fg = colors.gray1, bg = colors.bg, gui = "bold" },
				b = { fg = colors.gray1, bg = colors.bg },
				c = { fg = colors.gray1, bg = colors.gray2 },
			},
		}

		-- Import color theme based on environment variable NVIM_THEME
		local env_var_nvim_theme = "tokyonight-night"

		-- Define a table of themes
		local themes = {
			onedark = onedark_theme,
			nord = "nord",
			catppuccin = "catppuccin",
			tokyonight = "tokyonight-night",
		}

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end

		local mode = {
			"mode",
			fmt = function(str)
				if hide_in_width() then
					return " " .. str
				else
					return " " .. str:sub(1, 1) -- displays only the first character of the mode
				end
			end,
		}

		local filename = {
			"filename",
			file_status = true, -- displays file status (readonly status, modified status)
			path = 2, -- 0 = just filename, 1 = relative path, 2 = absolute path

			color = { fg = colors.fg },

			fmt = function(name)
				local home = vim.uv.os_homedir()

				if home then
					home = home:gsub("([^%w])", "%%%1")
					name = name:gsub("^" .. home, "~")
				end

				return name
			end,
		}

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			colored = false,
			update_in_insert = false,
			always_visible = false,
			cond = hide_in_width,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = { added = " ", modified = " ", removed = " " },
			cond = hide_in_width,
		}

		require("lualine").setup({
			options = {
				globalstatus = true,
				icons_enabled = true,
				theme = themes[env_var_nvim_theme], -- Set theme based on environment variable
				-- Some useful glyphs:
				-- https://www.nerdfonts.com/cheat-sheet
				--        
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "neo-tree", "ministarter", "undotree", "snacks_dashboard" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { mode },
				lualine_b = {
					{ "branch", color = { fg = colors.blue, gui = "bold" } },
				},
				lualine_c = {
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					filename,
					-- {
					-- 	function()
					-- 		return require("nvim-navic").get_location({
					-- 			highlight = true,
					-- 		})
					-- 	end,
					-- 	cond = function()
					-- 		return require("nvim-navic").is_available()
					-- 	end,
					-- 	color = { fg = colors.gray1 }, -- Navic location in a subtle gray
					-- },
				},
				lualine_x = {
					-- Recording macro (Red to stand out)
					{
						function()
							local reg = vim.fn.reg_recording()
							return reg == "" and "" or "REC @" .. reg
						end,
						color = { fg = colors.red1, gui = "bold" },
					},
					-- Diagnostics with specific colors
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
						color = { bg = colors.gray3 }, -- Gives the component its own "block" background
					},
					-- Diff with specific colors
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
						diff_color = {
							added = { fg = colors.green },
							modified = { fg = colors.yellow },
							removed = { fg = colors.red1 },
						},
					},
					{ "filetype", cond = hide_in_width, color = { fg = colors.cyan } },
				},
				lualine_y = {
					{ "location", color = { fg = colors.blue, bg = colors.gray3 } },
				},
				lualine_z = {
					{ "progress", color = { fg = colors.bg, bg = colors.blue, gui = "bold" } },
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 2 } },
				lualine_x = { { "location", padding = 0 } },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "fugitive" },
		})
	end,
}
