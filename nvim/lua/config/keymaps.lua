-- Core keymaps (ported from basic_settings.lua + plug_settings.vim)

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Prevent Space from moving cursor (it's the leader)
keymap("", "<Space>", "<Nop>", opts)

-- Split navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize splits
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation via bufferline
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)

-- Jump list fix (C-i shares keycode with Tab in some terminals)
keymap("n", "<C-i>", "<C-i>", opts)

-- Stay in indent mode after visual indent/dedent
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Debug helper: pretty-print a Lua value
P = function(v)
	print(vim.inspect(v))
	return v
end

-- Toggle LSP diagnostics visibility (underlines, signs, virtual text)
keymap("n", "<leader>id", function()
	local current = vim.diagnostic.is_enabled()
	vim.diagnostic.enable(not current)
end, { desc = "Toggle diagnostics" })

-- Show syntax highlight stack under cursor (port of SynStack VimScript fn)
keymap("n", "ga", function()
	for _, i1 in ipairs(vim.fn.synstack(vim.fn.line("."), vim.fn.col("."))) do
		local i2 = vim.fn.synIDtrans(i1)
		local n1 = vim.fn.synIDattr(i1, "name")
		local n2 = vim.fn.synIDattr(i2, "name")
		print(n1 .. " -> " .. n2)
	end
end, { desc = "Show syntax stack under cursor" })
