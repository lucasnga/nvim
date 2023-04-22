vim.api.nvim_create_autocmd("FileType", {
    pattern = "*.md",
    callback = function()
        vim.keymap.set("n", "<leader>M", ":exec 'MarkdownPreview'<CR>")
    end
})
