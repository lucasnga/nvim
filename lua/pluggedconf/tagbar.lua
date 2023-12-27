vim.g.tagbar_type_typescriptreact = {
    ctagstype = 'typescript',
    kinds = {
        'c:class',
        'n:namespace',
        'f:function',
        'G:generator',
        'v:variable',
        'm:method',
        'p:property',
        'i:interface',
        'g:enum',
        't:type',
        'a:alias',
    },
    sro = '.',
    kind2scope = {
        c = 'class',
        n = 'namespace',
        i = 'interface',
        f = 'function',
        G = 'generator',
        m = 'method',
        p = 'property',
    },
}

vim.g.tagbar_type_javascriptreact = {
    ctagstype = 'typescript',
    kinds = {
        'c:class',
        'n:namespace',
        'f:function',
        'G:generator',
        'v:variable',
        'm:method',
        'p:property',
        'i:interface',
        'g:enum',
        't:type',
        'a:alias',
    },
    sro = '.',
    kind2scope = {
        c = 'class',
        n = 'namespace',
        i = 'interface',
        f = 'function',
        G = 'generator',
        m = 'method',
        p = 'property',
    },
}

vim.keymap.set('n', '<leader>o', ':TagbarToggle', { noremap = true })
