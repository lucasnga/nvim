vim.api.nvim_create_autocmd("FileType", {
    pattern = '*',
    callback = function()
        vim.keymap.set('n', '<leader>M', ":MarkdownPreview<CR>", { noremap = true })
    end
})
