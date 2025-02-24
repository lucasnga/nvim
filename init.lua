vim.api.nvim_create_augroup('vimrc', { clear = true })

-- +---------------+
-- | plugin config |
-- +---------------+
require('config.lazy')
require('pluggedconf')
require("nvim-autopairs").setup({})
require('refactoring').setup({})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank { higroup = 'IncSearch', timeout = 700 }
    end,
})

vim.opt.rtp:append("~/nvim/godoctor.vim")

vim.cmd("filetype on")
vim.cmd("filetype plugin indent on")

-- Impossible to put it in vim-delve.nvimrc file...
vim.g.delve_breakpoint_sign = ""
vim.g.delve_tracepoint_sign = ""

-- project config - personnal file (not on my git repository)
vim.cmd("source ~/nvim/projects.nvimrc")

-- close the buffer
vim.keymap.set('n', '<leader>db', ':Bdelete<cr>', { noremap = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.twig" },
    command = "set filetype=html.twig",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.mod" },
    command = "set filetype=gomod",
})

vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_math = 1

-- +-----------------+
-- | general binding |
-- +-----------------+
vim.cmd("syntax on")

-- space as leader key
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

vim.keymap.set("v", "<F2>", "!boxes -d stone")

-- un-highlight when esc is pressed
vim.keymap.set("n", "<esc>", ":noh<cr>", { silent = true })

-- surround by quotes - frequently use cases of vim-surround
vim.keymap.set({ "n", "v", "x" }, '<leader>\"', 'ysiw"', { remap = true })
vim.keymap.set({ "n", "v", "x" }, "<leader>\'", "ysiw'", { remap = true })

-- indent without kill the selection in vmode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- remap the annoying u in visual mode
vim.keymap.set("v", "u", "y")

-- shortcut to substitute current word under cursor
vim.keymap.set("n", "<leader>[", ":%s/<c-r><c-w>//g<left><left>", { noremap = true })

-- Change in next bracket
vim.keymap.set("n", "cinb", "cib")

-- TODO: Fix this
-- Visual mode pressing * or # searches for the current selection
-- Super useful! From an idea by Michael Naumann
-- vim.keymap.set("v", "*", ":<C-u>call general#VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>", { silent = true, noremap = true })
-- vim.keymap.set("v", "#", ":<C-u>call general#VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>", { silent = true, noremap = true })

-- location & quickfix window
vim.keymap.set("n", "<leader>l", ':call general#ToggleList("Location List", "l")<CR>', { silent = true, noremap = true })
vim.keymap.set("n", "<leader>q", ':call general#ToggleList("Quickfix List", "c")<CR>', { silent = true, noremap = true })

-- TODO: Maybe use more luaish command
-- Toggle between absolute -> relative line number
vim.keymap.set("n", "<C-n>", ":let [&nu, &rnu] = [&nu, &nu+&rnu==1]<CR>", { noremap = true })

vim.keymap.set("n", "<leader>t", ":terminal<CR>", { noremap = true })

-- tabs
vim.keymap.set("n", "th", ":tabfirst<CR>", { noremap = true })
vim.keymap.set("n", "tk", ":tabnext<CR>", { noremap = true })
vim.keymap.set("n", "tj", ":tabprev<CR>", { noremap = true })
vim.keymap.set("n", "tl", ":tablast<CR>", { noremap = true })
vim.keymap.set("n", "tn", ":tabnew<CR>", { noremap = true })

-- move tab to first/last position
vim.keymap.set("n", "tF", ":tabm 0<CR>", { noremap = true })
vim.keymap.set("n", "tL", ":tabm<CR>", { noremap = true })

-- windows navigation
-- use ctrl + hjkl

-- close all windows except the current one
vim.keymap.set("n", "<leader>wco", ":only<cr>", { noremap = true })
vim.keymap.set("n", "<leader>wcc", ":cclose<cr>", { noremap = true })

-- windows creation
-- create horizontal window
vim.keymap.set("n", "<leader>wh", "<c-w>s", { noremap = true })
-- create vertival window
vim.keymap.set("n", "<leader>wv", "<c-w>v", { noremap = true })

vim.api.nvim_create_autocmd("CursorHold", { pattern = "*", command = "update" })

vim.keymap.set("i", "<C-d>", "<Del>", { noremap = true })

-- highlight the line which is longer than the defined margin (120 character)
vim.api.nvim_set_hl(0, "MaxLineChar", { ctermbg = "red" })

-- TODO: not working
vim.api.nvim_create_autocmd("FileType", {
    group = "vimrc",
    pattern = { "*.php", "*.js", "*.vue", "*.go", "vim" },
    callback = function(args)
        vim.w.m1 = vim.fn.matchadd("MaxLineChar", '%80v', 100)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = "vimrc",
    pattern = { "python", "javascript", "typescript", "typescriptreact", "css", "go", "html", "php" },
    callback = function()
        vim.keymap.set("n", "<leader>D",
            ":lua os.execute('xdg-open https://devdocs.io/#q=' .. vim.fn.fnameescape(vim.fn.expand('<cword>')))<cr>",
            { silent = true, buffer = true })
    end,
})

-- arrow keys resize windows
vim.keymap.set("n", "<Left>", ":vertical resize -10<CR>", { noremap = true })
vim.keymap.set("n", "<Right>", ":vertical resize +10<CR>", { noremap = true })
vim.keymap.set("n", "<Up>", ":resize -10<CR>", { noremap = true })
vim.keymap.set("n", "<Down>", ":resize +10<CR>", { noremap = true })

vim.keymap.set("i", "<up>", "<nop>")
vim.keymap.set("i", "<down>", "<nop>")
vim.keymap.set("i", "<left>", "<nop>")
vim.keymap.set("i", "<right>", "<nop>")

-- Keep the cursor in place while joining lines
vim.keymap.set("n", "J", "mzJ`z", { noremap = true })

-- Quit neovim termial
vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { noremap = true })

-- buffer cleanup - delete every buffer except the one open
vim.api.nvim_create_user_command("Ball", ":silent call general#Bdeleteonly()", {})

-- restore the position of the last cursor when you open a file
vim.api.nvim_create_autocmd("BufReadPost", {
    group = "vimrc",
    pattern = "*",
    command = "call general#RestorePosition()"
})

-- -- edit vimrc with f5 and source it with f6
vim.keymap.set("n", "<leader><f5>", ":e $MYVIMRC<CR>", { silent = true })
vim.keymap.set("n", "<leader><f6>", ":so $MYVIMRC<CR>", { silent = true })

vim.api.nvim_create_autocmd("BufWrite", {
    group = "vimrc",
    pattern = { "*.py", "*.php", "*.js", "*.jsx", "*.vue", "*.twig", "*.html", "*.sh", "*.yaml", "*.yml" },
    command = "call general#DeleteTrailingWS()"
})

-- Simple Zoom / Restore window (like Tmux)
vim.keymap.set("n", "<Leader>z", ":call general#ZoomToggle()<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("BufEnter", {
    group = "vimrc",
    pattern = { "*.png", "*.jpg", "*.gif" },
    command = "silent! !sxiv " .. vim.fn.expand("%") .. " | :bw"
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = "vimrc",
    pattern = "*.pdf",
    command = "silent! !zathura " .. vim.fn.expand("%") .. " | :bw"
})


-- Execute a macro for the all selection
vim.keymap.set("x", "@", ":<C-u>call general#ExecuteMacroOverVisualRange()<CR>", { noremap = true })

-- Disable anoying ex mode
vim.keymap.set("n", "Q ", "<Nop>", { noremap = true })

-- Save files as root
vim.keymap.set("c", "w!!", 'execute :w suda://%', { noremap = true })

-- +----------------+
-- | general config |
-- +----------------+

vim.g.sonokai_style = 'shusia'
-- vim.g.sonokai_better_performance = 1
vim.cmd.colorscheme("sonokai")

if vim.env.TERM == "fbterm" then
    vim.opt.termguicolors = false
else
    vim.opt.termguicolors = true
end

vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { ctermbg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE" , ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "#4a4a3a" , ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = 'none', ctermbg = 'none', fg = '#4a4a4a' })

-- vim.api.nvim_set_hl(0, "LineNr" , { bg="NONE", ctermbg="NONE" })
-- vim.api.nvim_set_hl(0, "ColorColumn", { bg=238, ctermbg=238 })
-- vim.api.nvim_set_hl(0, "spInlayHint", { fg="#d8d8d8", bg="#4a4a3a" })
-- vim.api.nvim_set_hl(0, "VirtualTextError", { fg="#FF2020", bg="lightgrey" })

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"

vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- set the directory where the swap file will be saved
vim.opt.backupdir = vim.env.HOME .. '/nvim/backup/'
vim.opt.directory = vim.env.HOME .. '/nvim/swap/'

-- save undo trees in files
vim.opt.undofile = true
vim.opt.undodir = vim.env.HOME .. '/nvim/undo/'

vim.opt.number = true                   -- set line number
vim.opt.clipboard:append('unnamedplus') -- the copy goes to the clipboard

-- copy indent from current line when starting a new line
vim.opt.autoindent = true
-- indentation is always done with spaces
vim.opt.expandtab = true
vim.opt.smartindent = true
-- use 4 spaces instead of tab (to replace existing tab use :retab)
vim.opt.tabstop = 4
-- cursor move by
vim.opt.softtabstop = 4
-- 0 - same as tabstop
vim.opt.shiftwidth = 0
-- at the line start use shiftwidth
vim.opt.smarttab = true

-- Save session
vim.keymap.set("n", "<Leader>ss", ":mksession! ~/nvim/sessions/*.vim<C-D><BS><BS><BS><BS><BS>", { noremap = true })
-- Reload session
vim.keymap.set("n", "<Leader>sl", ":so ~/nvim/sessions/*.vim<C-D><BS><BS><BS><BS><BS>", { noremap = true })

vim.opt.shiftround = true -- when at 3 spaces, and I hit > ... go to 4, not 7

-- number of undo saved in memory
vim.opt.undolevels = 10000 -- How many undos
vim.opt.undoreload = 10000 -- number of lines to save for undo

-- Use case insensitive search, except when using capital letters
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.listchars:append {
    tab = "| ",
    trail = '·',
    nbsp = '±'
}

vim.opt.list = true
vim.opt.hidden = true    -- doesn't prompt a warning when opening a file and the current file was written but not saved
vim.opt.showmode = false -- doesn't display the mode status
vim.opt.scrolloff = 999  -- Keep cursor more in middle when scrolling down / up
vim.opt.swapfile = false -- no swap file! This is just annoying
vim.opt.autowrite = true -- write automatically when quitting buffer

-- Fold related
vim.opt.foldlevelstart = 0                   -- Start with all folds closed

vim.opt.foldtext = "general#FoldText()" -- Set foldtext
vim.opt.inccommand = "nosplit"               -- Show the substitution LIVE

-- Better ex autocompletion
vim.opt.wildmenu = true
vim.opt.wildmode = 'list:longest,full'

vim.opt.number = true
vim.opt.relativenumber = false     -- relative / hybrid line number switch
vim.opt.diffopt:append('vertical') -- for vertical pane in git diff tool

vim.opt.modeline = true            -- add modeline even for root

number_toggle = vim.api.nvim_create_augroup("numbertoggle", {})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
    group = number_toggle,
    pattern = "*",
    command = "set relativenumber"
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
    group = number_toggle,
    pattern = "*",
    command = "set norelativenumber"
})

vim.api.nvim_create_autocmd("FileType", {
    group = "vimrc",
    pattern = "*",
    command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"
})


-- xxxxx
-- highlight EndOfBuffer guibg=NONE ctermbg=NONE
-- highlight Normal guibg=None ctermbg=238
-- highlight SignColumn ctermbg=NONE guibg=NONE
-- highlight LineNr     ctermbg=NONE guibg=NONE
-- highlight ColorColumn ctermbg=238
-- " " hi VirtualTextError guifg=darkred guibg=lightgrey
-- hi LspInlayHint guifg=#d8d8d8 guibg=#4a4a3a
--
-- xxxxx
