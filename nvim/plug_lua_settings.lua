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

require("ibl").setup()

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

-- dracula
local dracula = require("dracula")
dracula.setup({
	-- -- customize dracula color palette
	-- colors = {
	--   bg = "#282A36",
	--   fg = "#F8F8F2",
	--   selection = "#44475A",
	--   comment = "#6272A4",
	--   red = "#FF5555",
	--   orange = "#FFB86C",
	--   yellow = "#F1FA8C",
	--   green = "#50fa7b",
	--   purple = "#BD93F9",
	--   cyan = "#8BE9FD",
	--   pink = "#FF79C6",
	--   bright_red = "#FF6E6E",
	--   bright_green = "#69FF94",
	--   bright_yellow = "#FFFFA5",
	--   bright_blue = "#D6ACFF",
	--   bright_magenta = "#FF92DF",
	--   bright_cyan = "#A4FFFF",
	--   bright_white = "#FFFFFF",
	--   menu = "#21222C",
	--   visual = "#3E4452",
	--   gutter_fg = "#4B5263",
	--   nontext = "#3B4048",
	--   white = "#ABB2BF",
	--   black = "#191A21",
	-- },
	-- show the '~' characters after the end of buffers
	show_end_of_buffer = true, -- default false
	-- use transparent background
	transparent_bg = true, -- default false
	-- set custom lualine background color
	-- lualine_bg_color = "#44475a", -- default nil
	-- set italic comment
	italic_comment = true, -- default false
	-- overrides the default highlights with table see `:h synIDattr`
	overrides = {},
	-- You can use overrides as table like this
	-- overrides = {
	--   NonText = { fg = "white" }, -- set NonText fg to white
	--   NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
	--   Nothing = {} -- clear highlight of Nothing
	-- },
	-- Or you can also use it like a function to get color from theme
	-- overrides = function (colors)
	--   return {
	--     NonText = { fg = colors.white }, -- set NonText fg to white of theme
	--   }
	-- end,
})

require("lualine").setup({
	options = {
		theme = "dracula-nvim",
	},
})
