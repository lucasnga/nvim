-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        'nvim-lua/plenary.nvim',
        'tmux-plugins/vim-tmux',                       -- syntax highlighting for tmux.conf + other cool options
        'tmux-plugins/vim-tmux-focus-events',
        'christoomey/vim-tmux-navigator',              -- seemless navigation between vim windows / tmux pane
        'tpope/vim-obsession',
        'tpope/vim-fugitive',                          -- wrapper for git and display git diff in the left gutter
        'mhinz/vim-signify',
        'tpope/vim-rhubarb',                           -- fugitive for the hub
        'junegunn/gv.vim',                             -- Display commits for project / file
        'tpope/vim-surround',                          -- surrounding text objects with whatever you want (paranthesis, quotes, html tags...)
        'tpope/vim-abolish',                           -- easily search, substitute and abbreviate multiple version of words
        'tpope/vim-repeat',                            -- the . command can repeat whatever you want!
        'tpope/vim-speeddating',
        'machakann/vim-swap',                          -- swap arguments in parenthesis
        'wellle/targets.vim',                          -- add new text object (can delete between comma with di, for example)
        'chaoren/vim-wordmotion',                      -- camel case motion
        'andymass/vim-matchup',                        -- Match more stuff with % (html tag, LaTeX...)
        'amiorin/vim-project',                         -- vim project for one specific vimrc / project + startify for startup cow
        'mhinz/vim-startify',
        'godlygeek/tabular',                           -- Align plugin
        { 'junegunn/goyo.vim',      ft = 'markdown' }, -- Distraction-free

        { 'junegunn/limelight.vim', ft = 'markdown' }, -- Hyperfocus-writing
        { 'rhysd/vim-grammarous',   ft = 'markdown' }, -- show grammar mistakes
        'reedes/vim-wordy',                            -- Verify quality of writting (see :Wordy)
        'reedes/vim-lexical',                          -- Dictionnary, thesaurus...
        'ron89/thesaurus_query.vim',                   -- Thesaurus
        { 'iamcco/markdown-preview.nvim', ft = 'markdown', build = function() vim.fn["mkdp#util#install"]() end },
        { 'lukas-reineke/headlines.nvim', ft = 'markdown' },
        'chr4/nginx.vim', -- nginx syntax colors
        'Darazaki/indent-o-matic',
        'mtdl9/vim-log-highlighting',

        { 'stephpy/vim-php-cs-fixer',         ft = 'php' },
        { 'nishigori/vim-php-dictionary',     ft = 'php' },
        { 'adoy/vim-php-refactoring-toolbox', ft = 'php' },
        { 'phpactor/phpactor',                ft = 'php', build = function() vim.fn['composer install']() end },
        'windwp/nvim-autopairs',
        'windwp/nvim-ts-autotag',

        'neovim/nvim-lspconfig',
        'nvimtools/none-ls.nvim',
        'nvimtools/none-ls-extras.nvim',
        { 'ray-x/go.nvim',    ft = 'go' },
        'ray-x/guihua.lua',
        { 'sebdah/vim-delve', ft = 'go' }, -- debugger
        -- BUG: Posible performance issues
        -- "'mlaursen/vim-react-snippets'
        -- 'posva/vim-vue' " For Vue
        'majutsushi/tagbar', -- outliner
        'liuchengxu/vista.vim',
        'nvim-tree/nvim-tree.lua',
        'antosha417/nvim-lsp-file-operations',
        'itchyny/lightline.vim',                                                                 -- status bar
        'simnalamburt/vim-mundo',                                                                -- undo tree
        'bfredl/nvim-miniyank',                                                                  -- registers
        'moll/vim-bbye',                                                                         -- close the current buffer
        'wgwoods/vim-systemd-syntax',                                                            -- systemd syntax and error
        { 'mattn/emmet-vim', ft = 'html' },                                                      -- emmet for html
        { 'junegunn/fzf',    dir = '~/.fzf', build = function() vim.fn['fzf#install()']() end }, -- fzf - poweful fuzzy finder
        'junegunn/fzf.vim',
        'wincent/ferret',                                                                        -- allow multisearch in current directory / multi replace as well
        'ap/vim-css-color',                                                                      -- display the hexadecimal colors - useful for css and color config
        'simeji/winresizer',                                                                     -- easy way to rezise and exchange windows
        'yangmillstheory/vim-snipe',                                                             -- replace f F t T to target easily the motion
        'AndrewRadev/splitjoin.vim',                                                             -- Split arrays in PHP / struct in Go / other things
        -- TODO: GO up and find replacements
        { 'chrisbra/csv.vim', ft = 'csv' },                                                      -- CSV plugin
        'blueyed/vim-diminactive',                                                               -- Plug to dim not-focused windows
        'lambdalisue/suda.vim',                                                                  -- Write file with sudo
        'junegunn/vim-peekaboo',                                                                 -- Display register values on \" and @
        'phux/vim-hardtime',
        'ludovicchabant/vim-gutentags',
        { 'L3MON4D3/LuaSnip', version = 'v2.*', build = "make install_jsregexp" },
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        { 'fsharp/vim-fsharp',          ft = 'fsharp',   build = 'make fsautocomplete' },
        { 'rust-lang/rust.vim',         ft = 'rust' },
        { 'simrat39/rust-tools.nvim',   ft = 'rust' },
        { 'liuchengxu/graphviz.vim',    ft = 'dot' },
        { 'hashivim/vim-terraform',     ft = 'terraform' },
        { 'folke/neodev.nvim',          ft = 'lua' },
        { 'yorinasub17/vim-terragrunt', ft = 'terraform' },
        { 'j-hui/fidget.nvim',          tag = 'v1.5.0' },
        { 'sainnhe/sonokai',            lazy = false },
        'ryanoasis/vim-devicons',
        'nvim-tree/nvim-web-devicons',
        'onsails/lspkind-nvim',
        { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdateSync' },
        'nvim-treesitter/nvim-treesitter-textobjects',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'ckolkey/ts-node-action',
        'ThePrimeagen/refactoring.nvim',

        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',

        -- dba tools
        {
            'kristijanhusak/vim-dadbod-ui',
            dependencies = {
                { 'tpope/vim-dadbod',                     lazy = true },
                { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
            },
            cmd = {
                'DBUI',
                'DBUIToggle',
                'DBUIAddConnection',
                'DBUIFindBuffer',
            },
            init = function()
                -- Your DBUI configuration
                vim.g.db_ui_use_nerd_fonts = 1
            end,
        },

        'stevearc/profile.nvim', -- vim profiler
        'jamestthompson3/sort-import.nvim',

        'drzel/quakec.vim', -- quakeC

        -- debuggerers
        'vim-vdebug/vdebug',
        'mfussenegger/nvim-dap',
        'nvim-neotest/nvim-nio',
        'rcarriga/nvim-dap-ui',

        -- add your plugins here
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
})
