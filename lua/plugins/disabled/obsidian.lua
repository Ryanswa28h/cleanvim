-- Obsidian.nvim is as of right now, not polished enough to be used, instead, I recommend using the actual Obsidian app with vim bindings.
return {
	"epwalsh/obsidian.nvim",
	version = "*",

	ft = "markdown",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	opts = {
		workspaces = {
			{
				name = "vault",
				path = "~/vault",
			},
		},

		notes_subdir = "80-Untitled",

		daily_notes = {
			folder = "01-Daily",
			date_format = "%Y-%m-%d",
			alias_format = "%B %-d, %Y",
			template = "daily.md",
		},

		templates = {
			folder = "99-Templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
		},

		completion = {
			nvim_cmp = false,
			blink = true,
			min_chars = 2,
		},

		new_notes_location = "notes_subdir",

		preferred_link_style = "wiki",

		wiki_link_func = function(opts)
			return require("obsidian.util").wiki_link_id_prefix(opts)
		end,

		note_id_func = function(title)
			if title ~= nil then
				return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				return tostring(os.time())
			end
		end,

		attachments = {
			img_folder = "assets/imgs",
		},

		ui = {
			enable = true,

			checkboxes = {
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
				[">"] = { char = "", hl_group = "ObsidianRightArrow" },
				["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
			},

			bullets = {
				char = "•",
				hl_group = "ObsidianBullet",
			},
		},

		picker = {
			name = "mini.pick",
		},

		mappings = {
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},

			["<leader>on"] = {
				action = function()
					require("obsidian").util.new_note()
				end,
				opts = { buffer = true, desc = "New Obsidian Note" },
			},

			["<leader>ot"] = {
				action = function()
					require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true, desc = "Toggle Checkbox" },
			},
		},
	},
}
