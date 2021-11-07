local cmp = require('cmp');

cmp.setup {
    snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},
    completion = {completeopt = 'menu,menuone,noinsert'},
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Esc>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end
    },
    sources = {
        {name = 'nvim_lua'}, {name = 'nvim_lsp', priority = 10},
        {name = 'path'}, {name = 'vsnip'},
        {name = 'buffer', priority = 2, keyword_length = 5, max_item_count = 10},
        {name = 'calc'}
    }
}

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})
