local plugins = {
	"folke/which-key.nvim",
	{"nvim-treesitter/nvim-treesitter", build=":TSUpdate"},
	{"nvim-lualine/lualine.nvim", dependencies={"nvim-tree/nvim-web-devicons"}}
}

require("lazy").setup(plugins)

-- Setup treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = {"c", "lua", "vim", "vimdoc", "python"}
})

-- Setup lualine
require("lualine").setup({
	options = {theme="gruvbox"}
})

