vim.cmd("highlight NvimTreeNormal guibg=#00FF00 guifg=#9da5b3")
vim.cmd("highlight NvimTreeGitDirty ctermfg=magenta guifg=#ff0000")
vim.cmd("highlight NvimTreeGitDeleted ctermfg=red guifg=red")
vim.cmd("highlight NvimTreeGitStaged ctermfg=yellow guifg=red")
vim.cmd("highlight NvimTreeGitMerge	ctermfg=blue guifg=red")
vim.cmd("highlight NvimTreeGitNew ctermfg=green guifg=red")
vim.cmd("highlight NvimTreeModifiedFile ctermfg=magenta guifg=red")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.g.nvim_tree_gitignore = 1

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  },
  filters = {
    dotfiles = true,
  },
})

vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<cr>', { silent = true, nowait = true })

