-- Editor plugins: git, comments, fuzzy find, file tree, undo, movement

return {
	-- Git gutter signs (ported from plug_lua_settings.lua)
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add          = { text = "" },
				change       = { text = "" },
				delete       = { text = "" },
				topdelete    = { text = "" },
				changedelete = { text = "" },
			},
			numhl = true,
		},
	},

	-- Comment toggling (replaces tpope/vim-commentary)
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},

	-- Fuzzy finder (ported from plug_lua_settings.lua + plug_settings.vim)
	{
		"ibhagwan/fzf-lua",
		cmd = "FzfLua",
		keys = {
			{ "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", desc = "Find files" },
			{ "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", desc = "Find buffers" },
			{ "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<CR>", desc = "Live grep" },
		},
	},

	-- File explorer (ported from plug_lua_settings.lua + plug_settings.vim)
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle file explorer" },
		},
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			require("nvim-tree").setup()
			-- Auto-open when nvim is invoked on a directory
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function(data)
					if vim.fn.isdirectory(data.file) == 1 then
						vim.cmd.cd(data.file)
						require("nvim-tree.api").tree.open()
					end
				end,
			})
		end,
	},

	-- Undo tree visualizer (ported from plug_settings.vim)
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>ut", ":UndotreeToggle<CR>", desc = "Toggle undotree" },
		},
	},

	-- Quick f/F/t/T movement highlights (ported from plug_settings.vim)
	{
		"unblevable/quick-scope",
		init = function()
			vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
		end,
	},

	-- Tmux ↔ Neovim split navigation
	{ "christoomey/vim-tmux-navigator" },

	-- Utility library (required by several plugins)
	{ "nvim-lua/plenary.nvim", lazy = true },

	-- Startup time profiling
	{ "dstein64/vim-startuptime", cmd = "StartupTime" },
}
