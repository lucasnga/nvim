require('ts_context_commentstring').setup {}
vim.g.skip_ts_context_commentstring_module = true

require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    sync_install = true,
    ignore_install = { "ada", "agda", "apex", "authzed", "bass", "beancount", "bicep", "bitbake", "blueprint", "bp", "cairo", "capnp", "chatito", "circom", "cooklang", "corn", "cpon", "cylc", "dhall", "djot", "earthfile", "ebnf", "eds", "eex", "elsa", "elvish", "embedded_template", "enforce", "facility", "faust", "fennel", "fidl", "firrtl", "foam", "func", "fusion", "gap", "gaptst", "gdscript", "gdshader", "gleam", "glimmer", "glimmer_javascript", "glimmer_typescript", "gn", "gren", "gstlaunch", "hack", "hare", "heex", "hocon", "hoon", "hurl", "idl", "idris", "ini", "inko", "ispc", "janet_simple", "julia", "koto", "kusto", "lalrpop", "ledger", "leo", "liquid", "liquidsoap", "luau", "menhir", "mermaid", "nickel", "nim", "nim_format_string", "nu", "odin", "pony", "problog", "promql", "psv", "purescript", "ql", "qmldir", "qmljs", "racket", "ralph", "rbs", "rego", "rescript", "rnoweb", "robot", "robots", "roc", "ron", "runescript", "slint", "smali", "smithy", "snakemake", "soql", "sosl", "sourcepawn", "sparql", "squirrel", "starlark", "supercollider", "superhtml", "surface", "sway", "sxhkdrc", "t32", "tablegen", "tact", "tiger", "tlaplus", "turtle", "typespec", "typoscript", "typst", "ungrammar", "usd", "uxntal", "v", "vala", "vento", "vrl", "wing", "wit", "yang", "yuck", "ziggy", "ziggy_schema"
    },
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
