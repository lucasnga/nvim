vim.g.php_cs_fixer_php_path = "php"
vim.g.php_cs_fixer_rules = "@PSR2"

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = "*.php",
  callback = function()
    -- vim.opt_local.commentstring = '\/\/\ %s'
    vim.keymap.set('n', '<leader>g', ':silent :call PhpCsFixerFixFile()<CR>', { noremap = true })
  end,
  group = vim_cmd_group
})
