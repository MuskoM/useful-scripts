-- Setup treesitter
require("nvim-treesitter.configs").setup({
    -- List of parser names
	ensure_installed = {"c","javascript", "typescript", "lua", "vim", "vimdoc", "python"},

    -- Install parsers synchronously (only applied to 'ensure_installed')
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Reccomendation: set to false if you don't have 'tree-sitter' CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or 'all')
    ignore_install = {},

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("some/path/to/store/parsers")!
    highlight = {
        enable = true,
       },

    additional_vim_regex_highlighting = false,
})





