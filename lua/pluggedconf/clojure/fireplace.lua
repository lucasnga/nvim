vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = "clojure",
  callback = function()
    vim.keymap.set('n', '<leader>E', ':Eval<cr>', { buffer = true })
    vim.keymap.set('n', '<leader>K', ':exec "Doc ".expand("<cword>")<cr>', { buffer = true })
  end
})
