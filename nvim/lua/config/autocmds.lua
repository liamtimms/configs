-- Autocommands (ported from plug_settings.vim + init.vim firenvim block)

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Trim trailing whitespace on save (cursor-position-preserving)
augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
	group = "TrimWhitespace",
	pattern = "*",
	callback = function()
		local pos = vim.api.nvim_win_get_cursor(0)
		vim.cmd([[%s/\s\+$//e]])
		vim.api.nvim_win_set_cursor(0, pos)
	end,
})

-- Treat .md files as markdown.pandoc filetype
augroup("PandocSyntax", { clear = true })
autocmd({ "BufNewFile", "BufFilePre", "BufRead" }, {
	group = "PandocSyntax",
	pattern = "*.md",
	callback = function()
		vim.bo.filetype = "markdown.pandoc"
	end,
})

-- Populate new diary entries with a template
augroup("DiaryTemplate", { clear = true })
autocmd("BufNewFile", {
	group = "DiaryTemplate",
	pattern = "*/diary/[0-9]*.md",
	callback = function()
		local date = vim.fn.expand("%:r"):match("[^/]+$")
		local lines = {
			"# Shiplog " .. date,
			"",
			"## Dailies",
			"",
			"- [ ] Meds Morning -",
			"- [ ] Meds Afternoon -",
			"- [ ] Workout",
			"- [ ] Vitamins",
			"- [ ] Hair",
			"- [ ] Walk",
			"",
			"## Plans",
			"",
			"1.",
			"2.",
			"3.",
			"",
			"## Things I did",
			"",
			"1.",
			"2.",
			"3.",
			"",
			"## Near Future",
			"",
			"## Scratch",
		}
		vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
	end,
})

-- Firenvim: adjust UI when embedded in browser
-- (colorscheme is handled in plugins/ui.lua after plugins load)
if vim.g.started_by_firenvim then
	vim.opt.laststatus = 0
	vim.opt.showtabline = 0
	autocmd({ "BufNew", "BufEnter" }, {
		pattern = "*.txt",
		callback = function()
			vim.cmd("ProseOn")
		end,
	})
else
	vim.opt.laststatus = 3
end
