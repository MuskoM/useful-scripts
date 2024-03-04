local lsp = require 'lsp-zero'

lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
    local map = function (keys, func, desc)
        vim.keymap.set('n', keys, func, {buffer = bufnr, remap = false, desc = 'LSP: ' .. desc})
    end

    local builtin = require 'telescope.builtin'

    map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
    map('gr', builtin.lsp_references, '[G]oto [R]eferences')
    map('gl', builtin.lsp_implementations, '[G]oto [I]mplementation')
    map('gtd', builtin.lsp_type_definitions, '[G]oto [T]ype [D]efinition')
    map('gsd', builtin.lsp_document_symbols, '[G]oto [S]ymbols in [D]ocument ')
    map('gsw', builtin.lsp_dynamic_workspace_symbols, '[G]oto [S]ymbols in [W]orkspace ')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('<leader>vd', vim.diagnostic.open_float, '[V]iew [D]iagnostics')
    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, {buffer = bufnr, remap = false})

    -- vim.keymap.set('n', ']d', function () vim.diagnostic.goto_next() end, opts)
    -- vim.keymap.set('n', '[d', function () vim.diagnostic.goto_prev() end, opts)
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
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
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
