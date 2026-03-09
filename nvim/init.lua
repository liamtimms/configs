-- Pure Lua entry point (lua-migration branch)
-- Switch to this from ~/.config/nvim/init.vim by changing:
--   source $CUSTOM_CONFIG_HOME/nvim/init.vim
-- to:
--   luafile $CUSTOM_CONFIG_HOME/nvim/init.lua

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Our config lives outside stdpath("config"); prepend it to rtp so that:
--   require("config.*")       → nvim/lua/config/*.lua
--   lazy.nvim plugin import   → nvim/lua/plugins/*.lua
local config_dir = (vim.env.CUSTOM_CONFIG_HOME or "/home/liam/.custom_config/configs") .. "/nvim"
vim.opt.rtp:prepend(config_dir)

require("config.options")
require("config.keymaps")
require("config.autocmds")

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	change_detection = { notify = false },
})
