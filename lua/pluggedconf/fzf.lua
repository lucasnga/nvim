fzf_cmd_group = vim.api.nvim_create_augroup('fzf', { clear = true })

vim.g.fzf_tags_command = 'ctags --recurse --verbose --append --extra=+q --fields=+aimS --c-kinds=+p --c++-kinds=+p'
vim.g.fzf_preview_window = { 'up,60%', 'ctrl-/' }
vim.g.fzf_layout = {
  window = {
    height = 0.9,
    width = 0.9
  }
}

-- History of file opened
vim.keymap.set('n', '<leader>h', ':History<cr>', { noremap = true })
-- Buffers opens
vim.keymap.set('n', '<leader>b', ':Buffers<cr>', { noremap = true })
-- Files recursively from pwd
vim.keymap.set('n', '<leader>f', ':Files<cr>', { noremap = true })
-- Ex commands
vim.keymap.set('n', '<leader>c', ':Commands<cr>', { noremap = true })
-- Ex command history. <C-e> to modify the command
vim.keymap.set('n', '<leader>:', ':History:<cr>', { noremap = true })
-- Ripgrep
vim.keymap.set('n', '<leader>a', ':Rgi<space>', { noremap = true })
vim.keymap.set('n', '<leader>A', ':exec "Rgi ".expand("<cword>")<cr>', { noremap = true })

-- Customize fzf colors to match your color scheme
vim.g.fzf_colors = {
  fg = { '\fg', 'Normal' },
  bg = { '\bg', 'Normal' },
  hl = { '\fg', 'Comment' },
  ['fg+'] = { '\fg', 'CursorLine', 'CursorColumn', 'Normal' },
  ['bg+'] = { '\bg', 'CursorLine', 'CursorColumn' },
  ['hl+'] = { '\fg', 'Statement' },
  info = { '\fg', 'PreProc' },
  border = { '\fg', 'Ignore' },
  prompt = { '\fg', 'Conditional' },
  pointer = { '\fg', 'Exception' },
  marker = { '\fg', 'Keyword' },
  spinner = { '\fg', 'Label' },
  header = { '\fg', 'Comment' }
}

vim.g.fzf_action = {
  ['ctrl-t'] = 'tab split',
  ['ctrl-h'] = 'split',
  ['ctrl-v'] = 'vsplit'
}

vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  group = fzf_cmd_group,
  callback = function(opts)
    local fzf_cmd = 'rg --column --line-number --no-heading --hidden --follow --glob "!.git/*" --color=always '
    local fzf_args = function(args) return vim.fn.shellescape(args) end
    local bang_state = function(bang)
      return bang and vim.call('fzf#vim#with_preview', 'up:60%') or
          vim.call('fzf#vim#with_preview', 'right:50%:hidden', '?')
    end
    local cb_opts = { nargs = '*', bang = true }

    -- ripgrep command to search in multiple files
    vim.api.nvim_create_user_command('Rg', function(args)
      vim.call('fzf#vim#grep', fzf_cmd .. '--fixed-strings --ignore-case --no-ignore ' .. fzf_args(args.args), 1,
        bang_state(args.bang_state), args.bang)
    end, cb_opts)

    --  ripgrep - ignore the files defined in ignore files (.gitignore...)
    vim.api.nvim_create_user_command('Rgi', function(args)
      vim.call('fzf#vim#grep', fzf_cmd .. '--fixed-strings --ignore-case ' .. fzf_args(args.args), 1,
        bang_state(args.bang_state), args.bang)
    end, cb_opts)

    -- ripgrep - ignore the files defined in ignore files (.gitignore...) and doesn't ignore case
    vim.api.nvim_create_user_command('Rgic', function(args)
      vim.call('fzf#vim#grep', fzf_cmd .. '--fixed-strings' .. fzf_args(args.args), 1, bang_state(args.bang_state),
        args.bang)
    end, cb_opts)


    -- ripgrep - ignore the files defined in ignore files (.gitignore...) and doesn't ignore case
    vim.api.nvim_create_user_command('Rgir', function(args)
      vim.call('fzf#vim#grep', fzf_cmd .. fzf_args(args.args), 1, bang_state(args.bang_state), args.bang)
    end, cb_opts)

    -- ripgrep - ignore the files defined in ignore files (.gitignore...) and doesn't ignore case and activate regex search
    vim.api.nvim_create_user_command('Rgr', function(args)
      vim.call('fzf#vim#grep', fzf_cmd .. '--no-ignore' .. fzf_args(args.args), 1, bang_state(args.bang_state), args
        .bang)
    end, cb_opts)
  end,
})
