vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = "*.go",
  callback = function()
    vim.keymap.set('n', '<F9>', ':exec "DlvToggleTracepoint"<cr>', { buffer = true, noremap = true })
    vim.keymap.set('n', '<10>', ':exec "DlvToggleBreakpoint"<cr>', { buffer = true, noremap = true })
    vim.keymap.set('n', '<11>', ':exec "DlvClearAll"<cr>', { buffer = true, noremap = true })
    vim.keymap.set('n', '<F5>', ':exec "DlvDebug"<cr>', { buffer = true })
    vim.keymap.set('n', '<F6>', ':exec "DlvTest"<cr> ', { buffer = true })
  end
})
