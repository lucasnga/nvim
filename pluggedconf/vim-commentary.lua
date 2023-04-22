vim.api.nvim_create_autocmd('FileType', {
    pattern = 'nvimrc',
    command = 'setlocal commentstring="\\ %s'
})

