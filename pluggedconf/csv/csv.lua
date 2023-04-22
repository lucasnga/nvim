vim.g.no_csv_maps = 1
vim.g.csv_autocmd_arrange = 1

vim.api.nvim_create_autocmd({ "BufRead","BufWritePost" }, {
    pattern = "*.csv",
    command = ':%ArrangeComumn!'
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*.csv",
    command = ':%UnArrangeComumn'
})
