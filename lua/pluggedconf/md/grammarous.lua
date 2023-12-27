vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = "*.md",
  callback = function()
    local opts = { buffer = true }
    vim.keymap.set('n', '<leader>go', '<plug>(grammarous-move-to-info-window)', opts)
    vim.keymap.set('n', '<leader>gc', '<plug>(grammarous-close-info-window)', opts)
    vim.keymap.set('n', '<leader>gr', '<plug>(grammarous-reset)', opts)
    vim.keymap.set('n', '<leader>gn', '<Plug>(grammarous-move-to-next-error)', opts)
    vim.keymap.set('n', '<leader>gN', '<Plug>(grammarous-move-to-previous-error)', opts)
    vim.keymap.set('n', '<leader>gf', '<Plug>(grammarous-fixit)', opts)
  end
})
