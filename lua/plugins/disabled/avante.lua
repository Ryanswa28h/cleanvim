return {
	"yetone/avante.nvim",
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	---@module 'avante'
	---@type avante.Config
	opts = {
		instructions_file = "avante.md",
		provider = "copilot",
		providers = {
			gemini = {
				model = "gemini-2.0-flash",
				extra_request_body = {
					temperature = 0,
					timeout = 30000,
					max_tokens = 4096,
					disable_tools = true,
					use_ReAct_prompt = false,
				},
			},
			ollama = {
				endpoint = "http://localhost:11434",
				model = "qwen2.5:1.5b", -- or your chosen model
				extra_request_body = {
					temperature = 0,
					timeout = 30000,
					max_tokens = 4096,
				},
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"stevearc/dressing.nvim", -- for input provider dressing
		"folke/snacks.nvim", -- for input provider snacks
		"nvim-tree/nvim-web-devicons", -- or nvim-mini/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
	},
}
