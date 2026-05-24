return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim { 'mason-org/mason.nvim', config = true },
		-- NOTE: Must be loaded before dependants mason-lspconfig: - Bridges the gap between LSP config names (e.g. "lua_ls") and actual Mason package names (e.g. "lua-language-server").
		-- - Used here only to allow specifying language servers by their LSP name (like "lua_ls") in `ensure_installed`.
		-- - It does not auto-configure servers — we use vim.lsp.config() + vim.lsp.enable() explicitly for full control.
		"mason-org/mason-lspconfig.nvim",
		-- - Installs LSPs, linters, formatters, etc. by their Mason package name.
		-- mason-tool-installer:
		-- - We use it to ensure all desired tools are present.
		-- - The `ensure_installed` list works with mason-lspconfig to resolve LSP names like "lua_ls".
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"folke/lazydev.nvim",

		-- Useful status updates for LSP.
		{
			"j-hui/fidget.nvim",
			opts = {
				notification = {
					window = {
						winblend = 0, -- Background color opacity in the notification window
					},
				},
			},
		},

		-- Allows extra capabilities provided by nvim-cmp
		-- "hrsh7th/cmp-nvim-lsp",
		"saghen/blink.cmp",
		"neovim/nvim-lspconfig",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			-- Create a function that lets us more easily define mappings specific LSP related items.
			-- It sets the mode, buffer and description for us each time.
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-T>.
				-- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				-- Find references for the word under your cursor.
				-- map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				-- map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				-- map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				--  the definition of its *type*, not where it was *defined*.

				-- Fuzzy find all the symbols in your current document.
				--  Symbols are things like variables, functions, types, etc.
				-- map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

				-- Fuzzy find all the symbols in your current workspace
				--  Similar to document symbols, except searches over your whole project.
				-- map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- Rename the variable under your cursor
				--  Most Language Servers support renaming across files, etc.
				-- map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				-- map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

				vim.keymap.set("n", "gd", function()
					Snacks.picker.lsp_definitions()
				end, { desc = "Goto Definition", buffer = bufnr })
				vim.keymap.set("n", "<leader>gr", function()
					Snacks.picker.lsp_references()
				end, { desc = "References", buffer = bufnr, nowait = true })
				vim.keymap.set("n", "gI", function()
					Snacks.picker.lsp_implementations()
				end, { desc = "Goto Implementation", buffer = bufnr })
				vim.keymap.set("n", "gy", function()
					Snacks.picker.lsp_type_definitions()
				end, { desc = "Goto T[y]pe Definition", buffer = bufnr })
				-- vim.keymap.set("n", "<leader>ss", function()
				-- 	Snacks.picker.lsp_symbols()
				-- end, { desc = "LSP Symbols", buffer = bufnr })

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
				map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				map("<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[W]orkspace [L]ist Folders")

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				-- The following code creates a keymap to toggle inlay hints in your
				-- code, if the language server you are using supports them
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					client.server_capabilities.semanticTokensProvider = nil
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- LSP servers and clients are able to communicate to each other what features they support.
		-- By default, Neovim doesn't support everything that is in the LSP specification.
		-- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		-- So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		-- local capabilities = vim.lsp.protocol.make_client_capabilities()
		-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

		-- Enable the following language servers
		--
		-- Add any additional override configuration in the following tables. Available keys are:
		-- - cmd (table): Override the default command used to start the server
		-- - filetypes (table): Override the default list of associated filetypes for the server
		-- - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		-- - settings (table): Override the default settings passed when initializing the server.
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
						diagnostics = {
							globals = { "vim" },
							disable = { "missing-fields" },
						},
						format = {
							enable = false,
						},
						telemetery = {
							enable = false,
						},
					},
				},
			},
			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--completion-style=detailed",
					"--header-insertion=iwyu",
					"--pch-storage=memory",
				},
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			},
			pyright = {
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							typeCheckingMode = "basic", -- can also be "strict"

							diagnosticSeverityOverrides = {
								reportUnusedImport = "none",
								reportUnusedVariable = "none",
							},
						},
					},
				},
			},
			-- pylsp = {
			-- 	settings = {
			-- 		pylsp = {
			-- 			plugins = {
			-- 				pyflakes = { enabled = false },
			-- 				pycodestyle = { enabled = false },
			-- 				autopep8 = { enabled = false },
			-- 				yapf = { enabled = false },
			-- 				mccabe = { enabled = false },
			-- 				pylsp_mypy = { enabled = false },
			-- 				pylsp_black = { enabled = false },
			-- 				pylsp_isort = { enabled = false },
			-- 			},
			-- 		},
			-- 	},
			-- },
			ruff = {
				on_attach = function(client, bufnr)
					client.server_capabilities.hoverProvider = false
				end,
			},
			jsonls = {},
			sqlls = {},
			terraformls = {},
			yamlls = {},
			eslint = {
				settings = {
					workingDirectory = { mode = "auto" },
				},
			},
			bashls = {},
			dockerls = {},
			docker_compose_language_service = {},
			-- tailwindcss = {},
			-- graphql = {},
			html = { filetypes = { "html", "twig", "hbs" } },
			emmet_ls = {},
			cssls = {},
			vtsls = {},
			-- ltex = {},
			-- texlab = {},
		}

		-- Ensure the servers and tools above are installed
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"checkmake",
			"prettier",
			"eslint_d",
			"shfmt",
			"cpplint",
			"stylua",
			"ruff",
			"biome",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		-- Single loop to configure servers
		for server, cfg in pairs(servers) do
			-- Merge capabilities
			cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})

			-- Disable semantic tokens if you prefer standard highlighting
			cfg.on_init = function(client)
				client.server_capabilities.semanticTokensProvider = nil
			end

			-- Setup server
			vim.lsp.config(server, cfg)
			vim.lsp.enable(server)
		end
	end,
}
