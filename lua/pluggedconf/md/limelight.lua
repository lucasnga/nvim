vim.g.limelight_conceal_ctermfg = 'DarkGray'
vim.api.nvim_create_user_command('GoyoEnter', 'Limelight', {})
vim.api.nvim_create_user_command('GoyoLeave', 'Limelight!', {})
