-- Treesitter: syntax, indent, and refactoring (ported from plugins/core_plugins.lua)

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "BufReadPost",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-refactor",
	},
	opts = {
		highlight = {
			enable = true,
			-- Disable for very large files
			disable = function(_, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
			additional_vim_regex_highlighting = false,
		},
		autopairs = { enable = true },
		autotag = { enable = true },
		indent = { enable = true },
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
		},
		sync_install = false,
		ignore_install = {},
		refactor = {
			highlight_definitions = {
				enable = true,
				clear_on_cursor_move = true,
			},
			highlight_current_scope = { enable = false },
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
