-- UI plugins: colorscheme, statusline, bufferline, icons, indent guides

return {
	-- Dracula colorscheme (primary theme, ported from plug_lua_settings.lua)
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("dracula").setup({
				show_end_of_buffer = true,
				transparent_bg = true,
				italic_comment = true,
				overrides = {
				-- LSP symbol references: subtle background only, no fg color change
				LspReferenceText  = { bg = "#44475a", fg = "NONE", bold = false },
				LspReferenceRead  = { bg = "#44475a", fg = "NONE", bold = false },
				LspReferenceWrite = { bg = "#44475a", fg = "NONE", bold = false },
				-- dracula links H1 to rainbowcol1 (= fg, invisible); use orange instead
				["@markup.heading.1.markdown"] = { fg = "#FFB86C" },
			},
			})
			-- Only set dracula when not in firenvim (firenvim uses material)
			if not vim.g.started_by_firenvim then
				vim.cmd("colorscheme dracula")
			end
		end,
	},

	-- Material theme (used by firenvim for compact browser editing)
	{
		"marko-cerovac/material.nvim",
		lazy = true,
		config = function()
			if vim.g.started_by_firenvim then
				vim.g.material_style = "darker"
				vim.cmd("colorscheme material")
			end
		end,
	},

	-- Statusline (ported from plug_lua_settings.lua, removing g:coc_status)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = vim.g.started_by_firenvim and "auto" or "dracula-nvim",
					disabled_filetypes = {},
					always_divide_middle = true,
					globalstatus = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "filetype" },
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
		end,
	},

	-- Buffer tabs (ported from plug_lua_settings.lua)
	{
		"akinsho/bufferline.nvim",
		version = "v4.*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			highlights = {
				buffer_selected = {
					bold = true,
					italic = false,
				},
			},
		},
	},

	-- Icons (required by several plugins)
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- Indent guides (ported from plug_lua_settings.lua)
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPost",
		opts = {},
	},
}
