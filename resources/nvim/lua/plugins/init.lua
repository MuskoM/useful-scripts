local plugins = {
	"folke/which-key.nvim",
	{"nvim-treesitter/nvim-treesitter", build=":TSUpdate"},
	{"nvim-lualine/lualine.nvim", dependencies={"nvim-tree/nvim-web-devicons"}},
	{"nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies={"nvim-lua/plenary.nvim"}},
	{"catppuccin/nvim", name = "catppuccin", priority = 1000 }
}

require("lazy").setup(plugins)

-- Setup treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = {"c", "lua", "vim", "vimdoc", "python"}
})

-- Setup lualine
require("lualine").setup({
	options = {theme="catppuccin"}
})

-- Setup telescope
local telescope_builtin = require("telescope.builtin")

vim.keymap.set('n','<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n','<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n','<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n','<leader>fh', telescope_builtin.help_tags, {})
vim.keymap.set('n','<leader>f.', telescope_builtin.colorscheme, {})

-- Setup colorscheme
require("catppuccin").setup({
	flavour="macchiato",
})
vim.cmd.colorscheme "catppuccin"
