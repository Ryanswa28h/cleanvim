-- My personal choice of keymaps. Feel free to change these to your liking, or add more as you see fit.

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local opener = "xdg-open" -- "xdg-open" on linux, "open" on macOS, "explorer" on Windows

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- Show all keymaps
-- vim.keymap.set("n", "<leader>lm", "<cmd>Telescope keymaps<CR>")

-- Move around text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Override bind
vim.keymap.set("n", "J", "mzJ`z")

-- Telescope binds
-- vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "[F]ind [F]iles" })
-- vim.keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<CR>", { desc = "[F]ind [G]it" })
-- vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "[F]ind [W]ords (Grep)" })
-- vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "[F]ind [R]ecents" })
-- vim.keymap.set("n", "<leader>sth", "<cmd>Telescope colorscheme enable_preview=true<CR>")
-- vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "[T]odo Telescope" })
-- vim.keymap.set("n", "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>", { desc = "Todo/Fix/Fixme" })

-- L and H as $ and 0
vim.keymap.set({ "n", "v" }, "L", "$", opts)
vim.keymap.set({ "n", "v" }, "H", "^", opts)

-- Remap the register
vim.keymap.set({ "n", "x" }, '<leader>"', '"', { desc = "Select Register" })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", opts)

-- Open lazy
vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<CR>", opts)

-- Jump Forward
vim.keymap.set({ "i", "s" }, "<C-f>", function()
	if vim.snippet.active({ direction = 1 }) then
		vim.snippet.jump(1)
	end
end, { silent = true, desc = "Next snippet placeholder" })

-- Jump Backward
vim.keymap.set({ "i", "s" }, "<C-b>", function()
	if vim.snippet.active({ direction = -1 }) then
		vim.snippet.jump(-1)
	end
end, { silent = true, desc = "Previous snippet placeholder" })

-- save file
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd> w <CR>", opts)

-- save file without auto-formatting
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- EXIT Neovim
vim.keymap.set("n", "<leader>qq", "<cmd> confirm qa <CR>", opts)
vim.keymap.set("n", "<leader>Q", "<cmd> qa <CR>", opts)

-- EXIT Neovim from terminal
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>:confirm q<CR>", opts)
vim.keymap.set("t", "<C-S-q>", "<C-\\><C-n>:qa<CR>", opts)

-- Open Todo list
vim.keymap.set("n", "<leader>ot", function()
	require("utils.todo")()
end, { desc = "Notes: Open ToDo Float" })

-- Open Journal
vim.keymap.set("n", "<leader>oj", function()
	require("utils.journal")()
end, { desc = "Notes: Open Journal Float" })

-- Check signature of function under cursor
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation" })
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation" })

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<C-i>", "<C-i>", opts) -- to restore jump forward
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer

-- Increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>", opts) -- increment
vim.keymap.set("n", "<leader>-", "<C-x>", opts) -- decrement

-- Window management
vim.keymap.set("n", "|", "<C-w>v", { desc = "Split Vertically" }) -- split window vertically
vim.keymap.set("n", "_", "<C-w>s", { desc = "Split Horizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "[S]plit [V]ertically" }) -- split window vertically
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "[S]plit [H]orizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>wd", "<cmd>close<CR>", { desc = "Close window" }) -- close current split window

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Navigate between splits in terminal mode
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)

-- Tabs
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", opts) -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab

vim.keymap.set("n", "gz", function()
	require("utils.swap").swap()
end, { desc = "Toggle Boolean/Value" })

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Press jk fast to exit insert mode
-- vim.keymap.set("i", "jk", "<ESC>", opts)
-- vim.keymap.set("i", "kj", "<ESC>", opts)
-- vim.keymap.set("i", "jj", "<ESC>", opts)
-- vim.keymap.set("i", "kk", "<ESC>", opts)

-- Use 'jk' to exit terminal mode
vim.keymap.set("t", "jk", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })
vim.keymap.set("t", "kj", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Explicitly yank to system clipboard (highlighted and entire row)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Open file explorer
vim.keymap.set("n", "<leader>fO", function()
	local path = vim.fn.expand("%:p:h") -- Get the absolute path to the current file's directory

	-- Check if the path exists (it might not in a new, unsaved buffer)
	if vim.fn.isdirectory(path) > 0 then
		-- 'jobstart' runs the command in the background so it doesn't freeze Neovim
		vim.system({ opener, path }, { detach = true })
	else
		print("Error: Current buffer has no valid directory path.")
	end
end, { desc = "Open current directory in [f]ile explorer [O]utside" })

-- Toggle diagnostics
local diagnostics_active = true

vim.keymap.set("n", "<leader>do", function()
	diagnostics_active = not diagnostics_active

	if diagnostics_active then
		vim.diagnostic.enable(true)
	else
		vim.diagnostic.enable(false)
	end
end)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Save and load session
vim.keymap.set("n", "<leader>ps", ":mksession! .session.vim<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>pl", ":source .session.vim<CR>", { noremap = true, silent = false })

-- Set K to peek fold or show LSP hover documentation
vim.keymap.set("n", "K", function()
	local winid = require("ufo").peekFoldedLinesUnderCursor()
	if not winid then
		-- Fallback to LSP hover if no fold is found
		local lsp_clients = vim.lsp.get_clients({ bufnr = 0 })
		if #lsp_clients > 0 then
			vim.lsp.buf.hover()
		else
			-- If no LSP, fall back to native Vim help/behavior
			vim.api.nvim_feedkeys("K", "n", false)
		end
	end
end, { desc = "LSP hover documentation or peek fold" })

-- Showkeys
vim.keymap.set("n", "<leader>lm", "<cmd>ShowkeysToggle<CR>", { desc = "Toggle Showkeys" })

-- Terminal
vim.keymap.set({ "n", "t", "v" }, "<C-\\>", "<Cmd>FloatermToggle<CR>", { desc = "Toggle Terminal" })
