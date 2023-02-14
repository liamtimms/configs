-- Specific Plugin Settings --
-- covers lua plugin settings

-- treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"python",
		"c",
		"lua",
		"rust",
		"javascript",
		"bibtex",
		"cmake",
		"css",
		"dockerfile",
		"html",
		"http",
		"json",
		"json5",
		"latex",
		"markdown",
		"regex",
		"scss",
		"vim",
		"yaml",
	}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "markdown" }, -- list of language that will be disabled
	},
})
-- lualine
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		-- component_separators = { left = '', right = ''},
		-- section_separators = { left = '', right = ''},
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			"filename",
			-- {
			-- 	"buffers",
			-- 	buffers_color = {
			-- 		-- Same values as the general color option can be used here.
			-- 		active = "lualine_{section}_normal", -- Color for active buffer.
			-- 		inactive = "lualine_{section}_inactive", -- Color for inactive buffer.
			-- 	},
			-- },
		},
		lualine_x = { "g:coc_status", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})

-- bufferline without font issues
require("bufferline").setup({
	highlights = {
		buffer_selected = {
			bold = true,
			italic = false,
		},
	},
})

-- git signs
require("gitsigns").setup()

--comments
require("Comment").setup()

--fzf
-- require('fzf-lua').setup()

-- vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
})

-- explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()

local function open_nvim_tree(data)
	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not directory then
		return
	end

	-- change to the directory
	vim.cmd.cd(data.file)

	-- open the tree
	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- alpha
-- require('alpha').setup(require'alpha.themes.startify'.config)

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>fb",
	"<cmd>lua require('fzf-lua').buffers()<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fg",
	"<cmd>lua require('fzf-lua').live_grep()<CR>",
	{ noremap = true, silent = true }
)

-- prosemode
require("prosemode").setup()

-- neogen
require("neogen").setup()
vim.api.nvim_set_keymap("n", "<Leader>ng", ":lua require('neogen').generate()<CR>", { noremap = true, silent = true })
