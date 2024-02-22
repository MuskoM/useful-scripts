vim.g.mapleader = " "

local plugins = {
	"folke/which-key.nvim",
}

-- Setup lazy.vim
local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
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

-- Keymaps
require('core.mappings')

-- Load plugins
require("plugins")
