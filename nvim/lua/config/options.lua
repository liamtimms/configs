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

-- Redirect volatile editor state to tmpfs (RAM): root drive is an SMR HDD
-- (ST8000DM004) whose fsync stalls cause visible typing lag. We keep swap,
-- undo, and shada in /run/user/$UID/nvim — per-user tmpfs cleared at logout.
-- Tradeoff: undo history and shada don't survive reboot/logout; saved files
-- on disk are unaffected.
local tmp = (vim.env.XDG_RUNTIME_DIR or ("/run/user/" .. vim.fn.getuid())) .. "/nvim"
vim.fn.mkdir(tmp .. "/swap", "p")
vim.fn.mkdir(tmp .. "/undo", "p")
opt.directory = tmp .. "/swap//" -- trailing // = use full path in swap filename, avoids collisions
opt.undodir = tmp .. "/undo//"
opt.shadafile = tmp .. "/main.shada"
