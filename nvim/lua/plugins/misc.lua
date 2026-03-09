-- Miscellaneous plugins: AI, browser embedding, git, formatting, linting

return {
	-- GitHub Copilot (ported from plug_settings.vim)
	{
		"github/copilot.vim",
		event = "InsertEnter",
		init = function()
			vim.g.copilot_filetypes = { markdown = false }
			vim.g.copilot_no_tab_map = true
		end,
		config = function()
			local k = vim.keymap.set
			k("n", "<leader>ce", ":Copilot enable<CR>", { noremap = true, desc = "Copilot enable" })
			k("n", "<leader>cd", ":Copilot disable<CR>", { noremap = true, desc = "Copilot disable" })
			k("n", "<leader>cp", ":Copilot panel<CR>", { noremap = true, desc = "Copilot panel" })
			-- Accept suggestion with C-J (mirrors imap from plug_settings.vim)
			k("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
				script = true,
				silent = true,
			})
		end,
	},

	-- Claude Code AI assistant
	{
		"greggh/claude-code.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("claude-code").setup()
		end,
	},

	-- Snacks.nvim utility collection (dependency of some plugins)
	{ "folke/snacks.nvim", lazy = true },

	-- Firenvim: embed Neovim in browser text areas
	{
		"glacambre/firenvim",
		-- Only build/load when actually running inside firenvim
		lazy = not vim.g.started_by_firenvim,
		build = function()
			vim.fn["firenvim#install"](0)
		end,
		init = function()
			vim.g.firenvim_config = {
				globalSettings = { alt = "all" },
				localSettings = {
					[".*"] = {
						cmdline = "neovim",
						content = "text",
						priority = 0,
						selector = "textarea",
						takeover = "never",
					},
				},
			}
		end,
	},

	-- Git workflow (ported from plug_settings.vim)
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gw", ":Gwrite<CR>", desc = "Git write/stage" },
			{ "<leader>gc", ":Git commit<CR>", desc = "Git commit" },
			{ "<leader>gp", ":Git push<CR>", desc = "Git push" },
			{ "<leader>gpl", ":Git pull<CR>", desc = "Git pull" },
		},
	},

	-- Session persistence
	{ "tpope/vim-obsession" },

	-- Rust: bacon compiler runner integration
	{ "Canop/nvim-bacon" },

	-- Igor Pro syntax (niche filetype)
	{ "t-b/igor-pro-vim" },

	-- Formatting on save (replaces ALE fixers)
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		keys = {
			{
				"<leader>af",
				function()
					require("conform").format({ async = true })
				end,
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				python     = { "black", "isort" },
				c          = { "clang_format" },
				json       = { "prettier" },
				markdown   = { "prettier" },
				javascript = { "prettier" },
				sh         = { "shfmt" },
				rust       = { "rustfmt" },
				lua        = { "stylua" },
				tex        = { "latexindent" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},

	-- Linting (replaces ALE linters)
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufWritePost" },
		keys = {
			{
				"<leader>al",
				function()
					require("lint").try_lint()
				end,
				desc = "Trigger linting",
			},
		},
		config = function()
			require("lint").linters_by_ft = {
				python     = { "ruff", "mypy" },
				javascript = { "eslint" },
				markdown   = { "proselint" },
				sh         = { "shellcheck" },
			}
			-- Auto-lint on save
			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
