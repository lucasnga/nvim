require('ts_context_commentstring').setup {}
vim.g.skip_ts_context_commentstring_module = true

require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    ignore_install = { "glsl", "r" },
    highlight = {
        additional_vim_regex_highlighting = false,
        enable = true,
        disable = { "scss" },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
        },
    },
    indent = {
        enable = true,
    },
    matchup = {
        enable = true,
    },
    context_commentstring = {
        enable = nil,
        enable_autocmd = false,
    },
}
