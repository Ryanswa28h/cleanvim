local cmp_border = "single" -- "none", "single", "rounded", "double", "solid", "shadow"

return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = {
		"rafamadriz/friendly-snippets",
		-- {
		-- 	"zbirenbaum/copilot.lua",
		-- 	cmd = "Copilot",
		-- 	event = "InsertEnter",
		-- 	config = function()
		-- 		require("copilot").setup({
		-- 			suggestion = { enabled = false },
		-- 			panel = { enabled = false },
		-- 		})
		-- 	end,
		-- },
		-- {
		-- 	"giuxtaposition/blink-cmp-copilot",
		-- },
	},
	version = "*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "super-tab",
			["<C-y>"] = { "accept", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
			["<C-l>"] = { "show_documentation", "hide_documentation", "fallback" },
			-- ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
			-- ["<CR>"] = { "accept", "fallback" },
			-- ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			-- ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			-- ["<C-l>"] = { "snippet_forward", "fallback" },
			-- ["<C-h>"] = { "snippet_backward", "fallback" },
			["<A-1>"] = {
				function(cmp)
					if cmp.is_menu_visible() then
						return cmp.accept({ index = 1 })
					end
				end,
			},
			["<A-2>"] = {
				function(cmp)
					if cmp.is_menu_visible() then
						return cmp.accept({ index = 2 })
					end
				end,
			},
			["<A-3>"] = {
				function(cmp)
					if cmp.is_menu_visible() then
						return cmp.accept({ index = 3 })
					end
				end,
			},
			["<A-4>"] = {
				function(cmp)
					if cmp.is_menu_visible() then
						return cmp.accept({ index = 4 })
					end
				end,
			},
			["<A-5>"] = {
				function(cmp)
					if cmp.is_menu_visible() then
						return cmp.accept({ index = 5 })
					end
				end,
			},
			["<A-6>"] = {
				function(cmp)
					if cmp.is_menu_visible() then
						return cmp.accept({ index = 6 })
					end
				end,
			},
			["<A-7>"] = {
				function(cmp)
					if cmp.is_menu_visible() then
						return cmp.accept({ index = 7 })
					end
				end,
			},
			["<A-8>"] = {
				function(cmp)
					if cmp.is_menu_visible() then
						return cmp.accept({ index = 8 })
					end
				end,
			},
			["<A-9>"] = {
				function(cmp)
					if cmp.is_menu_visible() then
						return cmp.accept({ index = 9 })
					end
				end,
			},
		},

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
			kind_icons = {
				Text = "󰉿",
				Method = "m",
				Function = "󰊕",
				Constructor = "",
				Field = "",
				Variable = "󰆧",
				Class = "󰌗",
				Interface = "",
				Module = "",
				Property = "",
				Unit = "",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰇽",
				Struct = "",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰊄",
				Copilot = "",
			},
		},

		sources = {
			default = {
				"lsp",
				"snippets",
				-- "copilot", -- comment here to disable copilot suggestions
				"path",
				"buffer",
			},
			providers = {
				lsp = {
					name = "LSP",
					module = "blink.cmp.sources.lsp",
					score_offset = 100, -- Give LSP the highest priority
				},
				snippets = {
					name = "Snippets",
					module = "blink.cmp.sources.snippets",
					score_offset = 80, -- Snippets second
				},
				-- copilot = {
				-- 	name = "Copilot",
				--  module = "blink-cmp-copilot",
				-- 	score_offset = 50, -- AI can be fuzzy so we can put it below snippets and lsp
				-- 	async = true,
				-- },
				-- Paths and buffers last
			},
		},

		completion = {
			menu = {
				border = cmp_border,
				winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
				draw = {
					columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
					components = {
						source_name = {
							text = function(ctx)
								local source_names = {
									Copilot = " AI",
									LSP = "󰌵 LSP",
									Snippets = " Snippet",
									Buffer = "󰉿 Buffer",
									Path = "󰈙 Path",
									-- Copilot = "[AI]",
									-- LSP = "[LSP]",
									-- Snippets = "[Snip]",
									-- Buffer = "[Buffer]",
									-- Path = "[Path]",
								}
								-- return source_names[ctx.source_name] or "[" .. ctx.source_name .. "]"
								local display = source_names[ctx.source_name] or ctx.source_name
								return display
							end,
							highlight = function(ctx)
								return "BlinkCmpSource"
									.. ctx.source_name:sub(1, 1):upper()
									.. ctx.source_name:sub(2):lower()
							end,
						},
					},
				},
			},
			documentation = {
				auto_show = false,
				auto_show_delay_ms = 0,
				window = {
					border = cmp_border,
					winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
				},
			},
			ghost_text = {
				enabled = false, -- Matching your ghost_text = false
			},
			trigger = {
				show_in_snippet = false,
			},
		},

		signature = {
			enabled = true,
			window = {
				border = cmp_border,
			},
		},

		cmdline = {
			enabled = true,
			keymap = {
				preset = "super-tab",
				["<C-y>"] = { "accept", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
				["<C-l>"] = { "show_documentation", "hide_documentation", "fallback" },
				-- ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				-- ["<C-n>"] = { "show", "show_documentation", "hide_documentation" },
				-- ["<Tab>"] = { "select_next", "fallback" },
				-- ["<S-Tab>"] = { "select_prev", "fallback" },
				["<A-1>"] = {
					function(cmp)
						if cmp.is_menu_visible() then
							return cmp.accept({ index = 1 })
						end
					end,
				},
				["<A-2>"] = {
					function(cmp)
						if cmp.is_menu_visible() then
							return cmp.accept({ index = 2 })
						end
					end,
				},
				["<A-3>"] = {
					function(cmp)
						if cmp.is_menu_visible() then
							return cmp.accept({ index = 3 })
						end
					end,
				},
				["<A-4>"] = {
					function(cmp)
						if cmp.is_menu_visible() then
							return cmp.accept({ index = 4 })
						end
					end,
				},
				["<A-5>"] = {
					function(cmp)
						if cmp.is_menu_visible() then
							return cmp.accept({ index = 5 })
						end
					end,
				},
				["<A-6>"] = {
					function(cmp)
						if cmp.is_menu_visible() then
							return cmp.accept({ index = 6 })
						end
					end,
				},
				["<A-7>"] = {
					function(cmp)
						if cmp.is_menu_visible() then
							return cmp.accept({ index = 7 })
						end
					end,
				},
				["<A-8>"] = {
					function(cmp)
						if cmp.is_menu_visible() then
							return cmp.accept({ index = 8 })
						end
					end,
				},
				["<A-9>"] = {
					function(cmp)
						if cmp.is_menu_visible() then
							return cmp.accept({ index = 9 })
						end
					end,
				},
			},
			completion = {
				menu = {
					auto_show = true,
				},
				trigger = {
					-- show_in_snippet = false,
				},
			},
		},
	},
	opts_extend = { "sources.default" },
}
