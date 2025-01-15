local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.code_actions.ts_node_action,
        require("none-ls.diagnostics.eslint_d"),
        require("none-ls.code_actions.eslint_d"),
        -- null_ls.builtins.completion.spell,
        -- null_ls.builtins.formatting.biome
    },
})
