-- if hidden is not set, TextEdit might fail.
vim.o.hidden = true
-- Better display for messages
vim.o.cmdheight = 2
-- Smaller updatetime for CursorHold & CursorHoldI
vim.o.updatetime = 1000
-- don't give |ins-completion-menu| messages.
vim.o.shortmess = vim.o.shortmess .. 'c'
-- always show signcolumns
vim.o.signcolumn = "yes"
vim.o.completeopt = "menu,menuone,noselect"

vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = { "*" },
    command = "lua vim.diagnostic.open_float({ focusable = false })",
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
    command = "silent! EslintFixAll",
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.tf", "*.tfvars" },
    callback = function()
        vim.lsp.buf.formatting_sync()
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
        vim.keymap.set("n", "<leader>cd", vim.lsp.buf.type_definition, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
        vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, { noremap = true, silent = true })
        vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, { noremap = true, silent = true })
        vim.keymap.set("n", '<C-k>', vim.lsp.buf.signature_help, { noremap = true, silent = true })
        vim.keymap.set("i", '<C-k>', vim.lsp.buf.signature_help, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>p", function()
            vim.lsp.buf.format { async = true }
        end, { noremap = true, silent = true })
    end,
})

vim.keymap.set("n", "[c", vim.diagnostic.goto_next)
vim.keymap.set("n", "]c", vim.diagnostic.goto_prev)

require("neodev").setup({
    library = {
        enabled = true,
        -- these settings will be used for your Neovim config directory
        runtime = true, -- runtime path
        types = true,   -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        plugins = true, -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as a workspace library
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
    -- for your Neovim config directory, the config.library settings will be used as is
    -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
    -- for any other directory, config.library.enabled will be set to false
    override = function(root_dir, options)
    end,
    lspconfig = true,
    pathStrict = true,
})

local nvim_lsp = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


local on_attach = function(client)
    if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint(0, true)
    end

    -- TODO: Fix signature_help box of switch to keybinding
       vim.api.nvim_exec2([[
           augroup lsp
               autocmd!
               autocmd CursorHoldI <buffer> lua vim.lsp.buf.signature_help()
           augroup END
       ]], { output = false })
end

nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { 'typescript-language-server', '--stdio' },
    init_options = {
        -- preferences = {
        --     includeInlayParameterNameHints = "all",
        --     includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        --     includeInlayFunctionParameterTypeHints = true,
        --     includeInlayVariableTypeHints = false,
        --     includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        --     includeInlayPropertyDeclarationTypeHints = true,
        --     includeInlayFunctionLikeReturnTypeHints = true,
        --     includeInlayEnumMemberValueHints = true,
        -- }
    }
}
nvim_lsp.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true
            }
        }
    }
}
nvim_lsp.bashls.setup {}
nvim_lsp.html.setup { capabilities = capabilities, }
nvim_lsp.jsonls.setup { capabilities = capabilities, }
nvim_lsp.cssls.setup { capabilities = capabilities, }
nvim_lsp.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
nvim_lsp.pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { 'E501' },
                    maxLineLength = 100
                },
                mccabe = { enabled = true },
                flake8 = { enabled = true }
            }
        }
    }
}
nvim_lsp.yamlls.setup {}
nvim_lsp.dockerls.setup {}
nvim_lsp.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
nvim_lsp.dotls.setup {}
nvim_lsp.terraformls.setup {}
nvim_lsp.tflint.setup {}
nvim_lsp.eslint.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {  'vscode-eslint-language-server', '--stdio' },
}
nvim_lsp.prismals.setup {}

nvim_lsp.lua_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            telemetry = { enable = false },
            hint = { enable = true }
        },
    },
}

nvim_lsp.csharp_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        inlayHintsOptions = {
            enableForParameters = false,
            forLiteralParameters = false,
            forIndexerParameters = false,
            forObjectCreationParameters = false,
            forOtherParameters = false,
            suppressForParametersThatDifferOnlyBySuffix = false,
            suppressForParametersThatMatchMethodIntent = false,
            suppressForParametersThatMatchArgumentName = false,
            enableForTypes = false,
            forImplicitVariableTypes = false,
            forLambdaParameterTypes = false,
            forImplicitObjectCreation = false
        },
        FormattingOptions = {
            EnableEditorConfigSupport = false,
            OrganizeImports = false,
            NewLine = '\n',
            UseTabs = false,
            TabSize = 2,
            IndentationSize = 2,
            SpacingAfterMethodDeclarationName = false,
            SpaceWithinMethodDeclarationParenthesis = false,
            SpaceBetweenEmptyMethodDeclarationParentheses = false,
            SpaceAfterMethodCallName = false,
            SpaceWithinMethodCallParentheses = false,
            SpaceBetweenEmptyMethodCallParentheses = false,
            SpaceAfterControlFlowStatementKeyword = true,
            SpaceWithinExpressionParentheses = false,
            SpaceWithinCastParentheses = false,
            SpaceWithinOtherParentheses = false,
            SpaceAfterCast = false,
            SpacesIgnoreAroundVariableDeclaration = false,
            SpaceBeforeOpenSquareBracket = false,
            SpaceBetweenEmptySquareBrackets = false,
            SpaceWithinSquareBrackets = false,
            SpaceAfterColonInBaseTypeDeclaration = true,
            SpaceAfterComma = true,
            SpaceAfterDot = false,
            SpaceAfterSemicolonsInForStatement = true,
            SpaceBeforeColonInBaseTypeDeclaration = true,
            SpaceBeforeComma = false,
            SpaceBeforeDot = false,
            SpaceBeforeSemicolonsInForStatement = false,
            SpacingAroundBinaryOperator = 'single',
            IndentBraces = false,
            IndentBlock = true,
            IndentSwitchSection = true,
            IndentSwitchCaseSection = true,
            IndentSwitchCaseSectionWhenBlock = true,
            LabelPositioning = 'oneLess',
            WrappingPreserveSingleLine = true,
            WrappingKeepStatementsOnSingleLine = true,
            NewLinesForBracesInTypes = true,
            NewLinesForBracesInMethods = true,
            NewLinesForBracesInProperties = true,
            NewLinesForBracesInAccessors = true,
            NewLinesForBracesInAnonymousMethods = true,
            NewLinesForBracesInControlBlocks = true,
            NewLinesForBracesInAnonymousTypes = true,
            NewLinesForBracesInObjectCollectionArrayInitializers = true,
            NewLinesForBracesInLambdaExpressionBody = true,
            NewLineForElse = true,
            NewLineForCatch = true,
            NewLineForFinally = true,
            NewLineForMembersInObjectInit = true,
            NewLineForMembersInAnonymousTypes = true,
            NewLineForClausesInQuery = true
        }
    }
}

require "fidget".setup {}

local lspkind = require('lspkind')
local cmp = require 'cmp'

cmp.setup({
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'nvim_lua' }
    },
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            menu = {
                otter = "[🦦]",
                copilot = '[]',
                luasnip = "[snip]",
                nvim_lsp = "[LSP]",
                buffer = "[buf]",
                path = "[path]",
                spell = "[spell]",
                pandoc_references = "[ref]",
                tags = "[tag]",
                treesitter = "[TS]",
                calc = "[calc]",
                latex_symbols = "[tex]",
                emoji = "[emoji]",
            },
            mode = 'symbol', -- show only symbol annotations
            ellipsis_char = '...',
        })
    }
})
