-- Core Neovim options (ported from basic_settings.lua + coc_settings.lua)

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.cursorline = true

-- Splits open in natural positions
opt.splitright = true
opt.splitbelow = true

-- Mouse support
opt.mouse = "a"

-- Tabs as spaces
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4

-- Persist undo history across sessions
opt.undofile = true

-- Reduce delay for CursorHold (used by LSP highlight)
opt.updatetime = 300

-- Always show sign column to avoid text shifting on diagnostics
opt.signcolumn = "yes"

-- 24-bit color (required for treesitter highlight groups and colorschemes)
opt.termguicolors = true

-- No backup files (avoids issues with some LSP servers)
opt.backup = false
opt.writebackup = false
