-- Treesitter: syntax, indent, and highlighting (rewritten for new nvim-treesitter API)
-- NOTE: nvim-treesitter-refactor is incompatible with the new rewrite; removed.
-- NOTE: The new nvim-treesitter does not support lazy-loading.

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- Install parsers (async; no-op if already installed)
		require("nvim-treesitter").install({
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
			"json",
			"json5",
			"latex",
			"markdown",
			"regex",
			"scss",
			"vim",
			"yaml",
		})

		-- Enable treesitter highlighting + indent for common filetypes
		local filetypes = {
			"bash", "python", "c", "lua", "rust", "javascript",
			"css", "dockerfile", "html", "json", "markdown", "vim", "yaml",
		}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function(args)
				local buf = args.buf
				local ok = pcall(vim.treesitter.start, buf)
				if ok then
					-- Treesitter-based folding
					vim.wo.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo.foldenable = false -- open all folds by default
				end
			end,
		})
	end,
}
