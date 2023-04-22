local NERDTreeToggleInCurDir = function()
  -- If NERDTree is open in the current buffer
  if(vim.t.NERDTreeBufName and (vim.fn.bufwinnr(vim.t.NERDTreeBufName) ~= -1)) then
    vim.cmd([[ exec ":NERDTreeClose" ]], false) 
  else
    if (vim.fn.expand("%:t") ~= '') then
        vim.cmd([[ exe ":NERDTreeFind" ]])
    else
      vim.cmd([[ exec ":NERDTreeToggle" ]])
    end
  end
end


vim.keymap.set("n", "<leader>n", NERDTreeToggleInCurDir)

-- don't display informations (type ? for help and so on)
vim.g.NERDTreeMinimalUI = 1
-- don't replace the native vim file explorer
vim.g.NERDTreeHijackNetrw = 1
vim.g.NERDTreeChDirMode = 2
vim.g.NERDTreeAutoDeleteBuffer = 1
vim.g.NERDTreeShowBookmarks = 0
vim.g.NERDTreeCascadeOpenSingleChildDir = 1
vim.g.NERDTreeCascadeSingleChildDir = 0
vim.g.NERDTreeQuitOnOpen = 1

-- change the arrows
vim.g.NERDTreeDirArrowExpandable = ''
vim.g.NERDTreeDirArrowCollapsible = ''
vim.g.NERDTreeDirArrowExpandable = '▸'
vim.g.NERDTreeDirArrowCollapsible = '▾'

-- remapping - see nerdtree.txt and search for "NERDTreeMappings"
vim.NERDTreeMapOpenSplit = 'b'
vim.NERDTreeMapPreviewSplit='gb'

vim.NERDTreeMapOpenVSplit = 'v'
vim.NERDTreeMapPreviewVSplit='gv'
vim.g.NERDTreeMouseMode=3
