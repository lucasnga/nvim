vim.g.vim_php_refactoring_use_default_mapping = 0
vim.g.vim_php_refactoring_default_property_visibility = 'private'
vim.g.vim_php_refactoring_default_method_visibility = 'private'
vim.g.vim_php_refactoring_auto_validate_visibility = 1
vim.g.vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = "*.php",
  callback = function()
    vim.keymap.set('n','<leader>reu :call PhpExtractUse()<CR>', { noremap = true, buffer = true })
    vim.keymap.set('x','<leader>rec :call PhpExtractConst()<CR>', { noremap = true, buffer = true })
    vim.keymap.set('n','<leader>rep :call PhpExtractClassProperty()<CR>', { noremap = true, buffer = true })
    vim.keymap.set('n','<leader>rrm :call PhpRenameMethod()<CR>', { noremap = true, buffer = true })
    vim.keymap.set('n','<leader>rcp :call PhpCreateProperty()<CR>', { noremap = true, buffer = true })
    vim.keymap.set('n','<leader>rrp :call PhpRenameClassVariable()<CR>', { noremap = true, buffer = true })
    vim.keymap.set('n','<leader>rlv :call PhpRenameLocalVariable()<CR>', { noremap = true, buffer = true })
    vim.keymap.set('n','<leader>rdu :call PhpDetectUnusedUseStatements()<CR>', { noremap = true, buffer = true })
    vim.keymap.set('x','<leader>raa :call PhpAlignAssigns()<CR>', { noremap = true, buffer = true })
    vim.keymap.set('n','<leader>rsg :call PhpCreateSettersAndGetters()<CR>', { noremap = true, buffer = true })
  end,
  group = vim_cmd_group
})
