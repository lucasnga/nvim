-- if hidden is not set, TextEdit might fail.
vim.o.hidden = true
-- Better display for messages
vim.o.cmdheight = 2
-- Smaller updatetime for CursorHold & CursorHoldI
vim.o.updatetime = 100
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

vim.keymap.set("n", "[c", vim.diagnostic.goto_next)
vim.keymap.set("n", "]c", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>cd", vim.lsp.buf.type_definition, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, { noremap = true, silent = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true })
vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, { noremap = true, silent = true })
vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>p", vim.lsp.buf.format, { noremap = true, silent = true })
-- vim
-- nnoremap " gd    ","      vim.lsp.buf.definition()', { silent: true })
-- nnoremap " <c-k> ","      vim.lsp.buf.signature_help()', { silent: true })

require("neodev").setup({
    library = {
        enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
        -- these settings will be used for your Neovim config directory
        runtime = true, -- runtime path
        types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
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
    -- With lspconfig, Neodev will automatically setup your lua-language-server
    -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
    -- in your lsp start options
    lspconfig = true,
    -- much faster, but needs a recent built of lua-language-server
    -- needs lua-language-server >= 3.6.0
    pathStrict = true,
})

local nvim_lsp = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.tsserver.setup {
    init_options = {
        maxTsServerMemory = 3072
    }
}

local on_attach = function(client)
    require 'completion'.on_attach(client)
end

nvim_lsp.rust_analyzer.setup {
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true
            }
        }
    }
}
nvim_lsp.bashls.setup {}
nvim_lsp.gopls.setup {}
-- nvim_lsp.graphql.setup{}
nvim_lsp.stylelint_lsp.setup {}
nvim_lsp.html.setup { capabilities = capabilities, }
nvim_lsp.jsonls.setup { capabilities = capabilities, }
nvim_lsp.cssls.setup { capabilities = capabilities, }
nvim_lsp.pylsp.setup {}
nvim_lsp.yamlls.setup {}
nvim_lsp.dockerls.setup {}
nvim_lsp.clangd.setup {}
nvim_lsp.ccls.setup {
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
}
nvim_lsp.dotls.setup {}
nvim_lsp.terraformls.setup {}
nvim_lsp.tflint.setup {}
nvim_lsp.eslint.setup {}
nvim_lsp.prismals.setup {}

nvim_lsp.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                checkThirdParty = false,
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

require "fidget".setup {}

-- lua autocmd e.g.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.tf", "*.tfvars" },
    callback = function()
        vim.lsp.buf.formatting_sync()
    end,
})

local lspkind = require('lspkind')
local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
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
        { name = 'ultisnips' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'nvim_lua' }
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            return vim_item
        end
    }
})
