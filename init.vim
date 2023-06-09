" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if &compatible
    set nocompatible
endif

" Declare the general config group for autocommand
augroup vimrc
  autocmd!
augroup END

let g:loaded_matchit = 1

" +----------------+
" | install plugin |
" +----------------+

call plug#begin('~/nvim/plugged')
Plug 'henrik/vim-indexed-search' " display the result when searching
Plug 'tmux-plugins/vim-tmux' | Plug 'tmux-plugins/vim-tmux-focus-events' " syntax highlighting for tmux.conf + other cool options
Plug 'christoomey/vim-tmux-navigator' " seemless navigation between vim windows / tmux pane
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive' | Plug 'mhinz/vim-signify'  " wrapper for git and display git diff in the left gutter
Plug 'tpope/vim-rhubarb' " fugitive for the hub
Plug 'junegunn/gv.vim' " Display commits for project / file
Plug 'tpope/vim-surround' " surrounding text objects with whatever you want (paranthesis, quotes, html tags...)
Plug 'tpope/vim-abolish' " easily search, substitute and abbreviate multiple version of words
Plug 'tpope/vim-repeat' " the . command can repeat whatever you want!
Plug 'tpope/vim-commentary' " keystroke to comment automatically depending on the file you're in
Plug 'editorconfig/editorconfig-vim'
Plug 'machakann/vim-highlightedyank' " Highlight briefly every yank text
Plug 'machakann/vim-swap' " swap arguments in parenthesis
Plug 'wellle/targets.vim' " add new text object (can delete between comma with di, for example)
Plug 'chaoren/vim-wordmotion' " camel case motion
Plug 'andymass/vim-matchup' " Match more stuff with % (html tag, LaTeX...)
Plug 'amiorin/vim-project' " vim project for one specific vimrc / project + startify for startup cow
Plug 'mhinz/vim-startify'
Plug 'SirVer/ultisnips'
Plug 'godlygeek/tabular' " Align plugin
Plug 'junegunn/goyo.vim', { 'for': 'markdown' } " Distraction-free
Plug 'junegunn/limelight.vim', { 'for': 'markdown' } " Hyperfocus-writing
Plug 'rhysd/vim-grammarous', { 'for': 'markdown' } " show grammar mistakes
Plug 'reedes/vim-wordy' " Verify quality of writting (see :Wordy)
Plug 'reedes/vim-lexical' " Dictionnary, thesaurus...
Plug 'ron89/thesaurus_query.vim' " Thesaurus
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown' }
Plug 'chr4/nginx.vim' " nginx syntax colors

Plug 'stephpy/vim-php-cs-fixer', {'for': 'php'}
Plug 'nishigori/vim-php-dictionary', {'for': 'php'}
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}

" TODO: Do wypierdolenia/konwersji do LSP
Plug 'jiangmiao/auto-pairs'

Plug 'neovim/nvim-lspconfig'
Plug 'fatih/vim-go', {'for': 'go'} " general plugin
Plug 'godoctor/godoctor.vim', {'for': 'go'} " refactoring
Plug 'sebdah/vim-delve', {'for': 'go'} " debugger
Plug 'mlaursen/vim-react-snippets'
"Plug 'posva/vim-vue' " For Vue
"Plug 'majutsushi/tagbar' " outliner
Plug 'liuchengxu/vista.vim'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']} " Nerdtree + modifications 
" 'tiagofumo/vim-nerdtree-syntax-highlight' replacement
Plug 'johnstef99/vim-nerdtree-syntax-highlight'
Plug 'itchyny/lightline.vim' " status bar
Plug 'simnalamburt/vim-mundo' " undo tree
Plug 'bfredl/nvim-miniyank' " registers
Plug 'moll/vim-bbye' " close the current buffer
Plug 'wgwoods/vim-systemd-syntax' " systemd syntax and error
Plug 'mattn/emmet-vim' " emmet for html
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } } " fzf - poweful fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'wincent/ferret' " allow multisearch in current directory / multi replace as well
Plug 'ap/vim-css-color' " display the hexadecimal colors - useful for css and color config
Plug 'simeji/winresizer' " easy way to rezise and exchange windows
Plug 'yangmillstheory/vim-snipe' " replace f F t T to target easily the motion
Plug 'AndrewRadev/splitjoin.vim' " Split arrays in PHP / struct in Go / other things
Plug 'chrisbra/csv.vim' " CSV plugin
Plug 'blueyed/vim-diminactive' " Plug to dim not-focused windows
Plug 'lambdalisue/suda.vim' " Write file with sudo
Plug 'junegunn/vim-peekaboo' " Display register values on \" and @
Plug 'phux/vim-hardtime'
Plug 'ludovicchabant/vim-gutentags'

Plug 'rust-lang/rust.vim'
Plug 'elzr/vim-json'
Plug 'simrat39/rust-tools.nvim'
Plug 'liuchengxu/graphviz.vim'

Plug 'mfussenegger/nvim-dap'

Plug 'folke/lsp-colors.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'onsails/lspkind-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'sainnhe/sonokai'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

Plug 'j-hui/fidget.nvim'
Plug 'hashivim/vim-terraform'

Plug 'folke/neodev.nvim'
call plug#end()

" +---------------+
" | plugin config |
" +---------------+

" let g:AutoPairsFlyMode = 1

" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/*.nvimrc"), '\n')
    exe 'source' file
endfor

lua << EOF
for k, v in ipairs(vim.fn.glob("~/.config/nvim/pluggedconf/**/*.lua", false, true)) do

    dofile(v)
end
EOF

if exists("g:did_load_filetypes")
  filetype off
  filetype plugin indent off
endif

set rtp+=~/nvim/godoctor.vim

filetype on
filetype plugin indent on

" Impossible to put it in vim-delve.nvimrc file...
let g:delve_breakpoint_sign = ""
let g:delve_tracepoint_sign = ""

" project config - personnal file (not on my git repository)
source ~/nvim/projects.nvimrc

" close the buffer
nmap <leader>db :Bdelete!<cr>

autocmd vimrc BufNewFile,BufRead *.twig set filetype=html.twig
autocmd vimrc BufNewFile,BufRead *.mod set filetype=gomod

let g:vim_markdown_folding_disabled = 1

" +-----------------+
" | general binding |
" +-----------------+

syntax on

" Weird hack for NERDTree to work
let mapleader = "\\"
map <SPACE> <leader>

vmap <F2> !boxes -d stone

" un-highlight when esc is pressed
map <silent><esc> :noh<cr>

" surround by quotes - frequently use cases of vim-surround
map <leader>" ysiw"<cr>
map <leader>' ysiw'<cr>

" Act like D and C
nnoremap Y y$

" indent without kill the selection in vmode
vmap < <gv
vmap > >gv

" remap the annoying u in visual mode
vmap u y

" shortcut to substitute current word under cursor
nnoremap <leader>[ :%s/<c-r><c-w>//g<left><left>

" Change in next bracket
nmap cinb cib

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call general#VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call general#VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" location & quickfix window
nnoremap <silent> <leader>l :call general#ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>q :call general#ToggleList("Quickfix List", 'c')<CR>

"Toggle between absolute -> relative line number
nnoremap <C-n> :let [&nu, &rnu] = [&nu, &nu+&rnu==1]<CR>

nnoremap <leader>t :terminal<CR>

" tabs
nnoremap th :tabfirst<CR>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap tl :tablast<CR>
nnoremap tn :tabnew<CR>

" move tab to first position
nnoremap tF :tabm 0<CR>
nnoremap tL :tabm<CR>

" windows navigation
" use ctrl + hjkl

" close all windows except the current one
nnoremap <leader>wco :only<cr>
nnoremap <leader>wcc :cclose<cr>

" windows creation
" create horizontal window
nnoremap <leader>wh <c-w>s
" create vertival window
nnoremap <leader>wv <c-w>v

" delete character after cursor in insert mode
inoremap <C-d> <Del>

" highlight the line which is longer than the defined margin (120 character)
highlight MaxLineChar ctermbg=red
autocmd vimrc FileType php,js,vue,go call matchadd('MaxLineChar', '\%120v', 100)

" open devdocs.io with firefox and search the word under the cursor
command! -nargs=? DevDocs :call system('xdg-open https://devdocs.io/#q=<args>')
autocmd vimrc FileType python,javascript,typescript,typescriptreact,css,go,html,php nmap <buffer> <leader>D :exec "DevDocs " . fnameescape(expand('<cword>'))<CR>

" arrow keys resize windows
nnoremap <Left> :vertical resize -10<CR>
nnoremap <Right> :vertical resize +10<CR>
nnoremap <Up> :resize -10<CR>
nnoremap <Down> :resize +10<CR>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Quit neovim termial
tnoremap <C-\> <C-\><C-n>

" buffer cleanup - delete every buffer except the one open
command! Ball :silent call general#Bdeleteonly()

" restore the position of the last cursor when you open a file
autocmd vimrc BufReadPost * call general#RestorePosition()

" edit vimrc with f5 and source it with f6
nmap <silent> <leader><f5> :e $MYVIMRC<CR>
nmap <silent> <leader><f6> :so $MYVIMRC<CR>

" delete trailing space when saving files
autocmd vimrc BufWrite *.php,*.js,*.jsx,*.vue,*.twig,*.html,*.sh,*.yaml,*.yml :call general#DeleteTrailingWS()

" Simple Zoom / Restore window (like Tmux)
nnoremap <silent> <Leader>z :call general#ZoomToggle()<CR>

" Open images and pdfs
autocmd vimrc BufEnter *.png,*.jpg,*gif silent! exec "! sxiv ".expand("%") | :bw
autocmd vimrc BufEnter *.pdf silent! exec "! zathura ".expand("%") | :bw

" Execute a macro for the all selection
xnoremap @ :<C-u>call general#ExecuteMacroOverVisualRange()<CR>

" Disable anoying ex mode
nnoremap Q <Nop>

" Save files as root
cnoremap w!! execute ':w suda://%'

" +----------------+
" | general config |
" +----------------+

" if has('termguicolors')
" endif

colorscheme sonokai

if $TERM == "fbterm"
	set notermguicolors
else
    set termguicolors
endif

highlight EndOfBuffer guibg=NONE ctermbg=NONE
highlight Normal guibg=None ctermbg=238
highlight SignColumn ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight ColorColumn ctermbg=238
hi VirtualTextError guifg=darkred guibg=lightgrey

let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0

set signcolumn=yes
set colorcolumn=100

" set the directory where the swap file will be saved
set backupdir=~/nvim/backup/
set directory=~/nvim/swap/

" save undo trees in files
set undofile
set undodir=~/nvim/undo/

set number " set line number
set clipboard+=unnamedplus " the copy goes to the clipboard

" copy indent from current line when starting a new line
set autoindent
" indentation is always done with spaces
set expandtab
set smartindent
" use 4 spaces instead of tab (to replace existing tab use :retab)
set tabstop=4
" cursor move by
set softtabstop=4
" 0 - same as tabstop
set shiftwidth=0
" at the line start use shiftwidth
set smarttab

" Save session
exec 'nnoremap <Leader>ss :mksession! ~/nvim/sessions/*.vim<C-D><BS><BS><BS><BS><BS>'
" Reload session
exec 'nnoremap <Leader>sl :so ~/nvim/sessions/*.vim<C-D><BS><BS><BS><BS><BS>'

set shiftround " when at 3 spaces, and I hit > ... go to 4, not 7

" number of undo saved in memory
set undolevels=10000 " How many undos
set undoreload=10000 " number of lines to save for undo

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

set list listchars=tab:\┆\ ,trail:·,nbsp:± " set list
set hidden " doesn't prompt a warning when opening a file and the current file was written but not saved 
set noshowmode " doesn't display the mode status
set scrolloff=999 " Keep cursor more in middle when scrolling down / up
set noswapfile " no swap file! This is just annoying
set autowrite " write automatically when quitting buffer

" Fold related
set foldlevelstart=0 " Start with all folds closed

set foldtext=general#FoldText() " Set foldtext
set inccommand=nosplit " Show the substitution LIVE

" Better ex autocompletion
set wildmenu
set wildmode=list:longest,full

set number relativenumber " relative / hybrid line number switch
set diffopt+=vertical " for vertical pane in git diff tool

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

autocmd vimrc FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
