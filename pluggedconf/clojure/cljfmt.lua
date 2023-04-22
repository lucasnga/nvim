vim.api.nvim_create_autocmd("FileType", { pattern = "clojure", command = 'nmap <buffer><leader>g :Cljfmt<CR>' })
