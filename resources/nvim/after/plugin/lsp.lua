local lsp = require 'lsp-zero'

lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}
    vim.keymap.set('n', 'gd', function () vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'K', function () vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>vws', function () vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>vd', function () vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', ']d', function () vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n', '[d', function () vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', '<leader>vca', function () vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>vrr', function () vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>vrn', function () vim.lsp.buf.rename() end, opts)
    vim.keymap.set('i', '<C-h>', function () vim.lsp.buf.signature_help() end, opts)
end
)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver',
        'eslint',
        'lua_ls',
        'rust_analyzer',
        'pyright',
    },
    handlers = {
        lsp.default_setup,
        lua_ls = function ()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)        end,
    },
})

-- Load extra snippets
require('luasnip.loaders.from_vscode').lazy_load()

-- function for supertab
local has_words_before = function ()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require 'cmp'
local luasnip = require 'luasnip'

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
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
        {name = 'luasnip', keyword_length = 2},
        {name = 'buffer', keyword_length = 3},
    },
    formatting = lsp.cmp_format()
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

-- Add nvim-autopairs to nvim-cmp
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)


lsp.setup ()
