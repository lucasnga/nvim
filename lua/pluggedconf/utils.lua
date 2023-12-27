local utilSettingsGroup = vim.api.nvim_create_augroup('General settings', { clear = true })

vim.api.nvim_create_autocmd("FileType",
  {
    pattern = { "*" },
    callback = function()
      vim.opt_local.foldmethod = 'expr'
      vim.opt_local.foldexpr =
      "v:lnum==1?'>1':getline(v:lnum)=~'^import '?1:''"
    end,
    group = utilSettingsGroup
  })
