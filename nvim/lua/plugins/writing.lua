-- Writing plugins: LaTeX, wiki, prose, documentation generation

return {
	-- LaTeX support (ported from plug_settings.vim)
	{
		"lervag/vimtex",
		ft = "tex",
		init = function()
			vim.g.tex_flavor = "latex"
			vim.g.vimtex_view_method = "zathura"
		end,
	},

	-- Personal wiki with markdown (ported from plug_settings.vim)
	{
		"vimwiki/vimwiki",
		init = function()
			vim.g.vimwiki_list = {
				{
					path = "~/Documents/LaptopSync/wiki/",
					syntax = "markdown",
					ext = ".md",
					auto_diary_index = 1,
					diary_caption_level = -1,
				},
			}
			vim.g.vimwiki_markdown_link_ext = 1
			vim.g.vimwiki_global_ext = 0
			vim.g.vimwiki_hgader_type = "#"
		end,
		keys = {
			{ "<Leader>wf", "<Plug>VimwikiFollowLink", desc = "Follow wiki link" },
		},
	},

	-- Prose / distraction-free writing mode
	{
		"liamtimms/prosemode.nvim",
		config = function()
			require("prosemode").setup()
		end,
	},

	-- Auto-generate docstrings / documentation
	{
		"danymat/neogen",
		keys = {
			{ "<Leader>ng", ":lua require('neogen').generate()<CR>", desc = "Generate documentation" },
		},
		config = function()
			require("neogen").setup()
		end,
	},
}
