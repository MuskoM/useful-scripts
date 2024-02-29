local plugins = {
    -- Treesitter
	{"nvim-treesitter/nvim-treesitter", build=":TSUpdate"},
    -- Lualine
	{"nvim-lualine/lualine.nvim", dependencies={"nvim-tree/nvim-web-devicons"}},
    -- Telescope
	{"nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies={"nvim-lua/plenary.nvim"}},
    -- Catpuccin theme
	{"catppuccin/nvim", name = "catppuccin", priority = 1000 },
    -- Mason
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
    -- Lspconfig + cmp-nvim
	"neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    -- nvim-cmp
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    -- Luasnip + nvim-cmp
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    -- nvim-autopairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    }
}

require("lazy").setup(plugins)

-- Setup mason
require('mason').setup()

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

-- Setup lspconfig
local servers = {"lua_ls", "pyright"}
require("mason-lspconfig").setup({
	ensure_installed = servers
})
local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                Lua = {
                    runtime = {
                        version = 'LuaJIT'
                    },
                    diagnostics = {
                        globals = {
                            'vim',
                            'require'
                        }
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = vim.api.nvim_get_runtime_file("", true)
                    },
                    telemetry = {
                        enable = false,
                    }
                }
            })
    end
    return true
end
}
lspconfig.pyright.setup {}


-- function for supertab
local has_words_before = function ()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- nvim-cmp setup
local cmp = require('cmp')
local luasnip = require('luasnip')


cmp.setup{
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {

    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
            end,
            {"i","s"})
    }),
    sources = cmp.config.sources(
        {
            {name = 'nvim_lsp'},
            {name = 'luasnip'},
        },
        {
            {name = 'buffer'},
        }
    )
}

-- Set configuration for specific filetype
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        {name = 'git'},
    }, {
        {name = 'cmdline'}
    })
})

-- Use buffer source for '/' and '?'
cmp.setup.cmdline({'/','?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path'}
    }, {
        { name = 'cmdline'}
    })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
for _, server in ipairs(servers) do
    lspconfig[server].setup{
        capabilities = capabilities
    }
end

-- Add nvim-autopairs to nvim-cmp
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)
