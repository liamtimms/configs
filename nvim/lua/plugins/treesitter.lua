-- Treesitter: syntax, indent, and highlighting (rewritten for new nvim-treesitter API)
-- NOTE: nvim-treesitter-refactor is incompatible with the new rewrite; removed.
-- NOTE: The new nvim-treesitter does not support lazy-loading.

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- markdown.pandoc filetype (set by autocmds.lua) needs explicit mapping
		vim.treesitter.language.register("markdown", "markdown.pandoc")

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
			"css", "dockerfile", "html", "json", "markdown", "markdown.pandoc", "vim", "yaml",
		}

		local function enable_ts(buf)
			local ok = pcall(vim.treesitter.start, buf)
			if ok then
				vim.wo.foldmethod = "expr"
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo.foldenable = false
			end
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function(args) enable_ts(args.buf) end,
		})

		-- Handle buffers already open when the plugin config runs (e.g. nvim file.py)
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buf) then
				local ft = vim.bo[buf].filetype
				if vim.tbl_contains(filetypes, ft) then
					enable_ts(buf)
				end
			end
		end
	end,
}
