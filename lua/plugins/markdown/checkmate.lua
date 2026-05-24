-- checkmate.lua
return {
	"bngarren/checkmate.nvim",
	ft = "markdown",
	opts = {
		metadata = {
			due = {
				style = { fg = "#ff8787" },
				key = "<leader>Tm",
				get_value = function()
					local t = os.date("*t")
					t.day = t.day + 1
					local tomorrow = os.time(t)
					return os.date("%m/%d/%y", tomorrow)
				end,
			},
		},
		ui = {
			picker = "snacks", -- or "mini", "telescope", or "native"
		},
		todo_states = {
			-- Built-in states (cannot change markdown or type)
			unchecked = { marker = "□" },
			checked = { marker = "✔" },

			-- Custom states
			in_progress = {
				marker = "◐",
				markdown = ".", -- Saved as `- [.]`
				type = "incomplete", -- Counts as "not done"
				order = 50,
			},
			cancelled = {
				marker = "✗",
				markdown = "c", -- Saved as `- [c]`
				type = "complete", -- Counts as "done"
				order = 2,
			},
			on_hold = {
				marker = "⏸",
				markdown = "/", -- Saved as `- [/]`
				type = "inactive", -- Ignored in counts
				order = 100,
			},
		},
	},
}
