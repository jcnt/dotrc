-- LSP Support
return {
    -- LSP Configuration
    -- https://github.com/neovim/nvim-lspconfig
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
        -- LSP Management
        -- https://github.com/williamboman/mason.nvim
        { 'williamboman/mason.nvim' },
        -- https://github.com/williamboman/mason-lspconfig.nvim
        { 'williamboman/mason-lspconfig.nvim' },

        -- Auto-Install LSPs, linters, formatters, debuggers
        -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
        { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

        -- Useful status updates for LSP
        -- https://github.com/j-hui/fidget.nvim
        { 'j-hui/fidget.nvim',                        opts = {} },

        -- Additional lua configuration, makes nvim stuff amazing!
        -- https://github.com/folke/neodev.nvim
        { 'folke/neodev.nvim',                        opts = {} },
    },
    config = function()
        require('mason').setup()
        require('mason-lspconfig').setup({
            -- Install these LSPs automatically
            ensure_installed = {
                'bashls',
                'cssls',
                'html',
                'lua_ls',
                'jsonls',
                'marksman',
                'quick_lint_js',
                'yamlls',
                'pylsp',
                'gopls',
            }
        })

        require('mason-tool-installer').setup({
            -- Install these linters, formatters, debuggers automatically
            ensure_installed = {
                'black',
                'debugpy',
                'flake8',
                'isort',
                'mypy',
                'pylint',
            },
        })

        -- There is an issue with mason-tools-installer running with VeryLazy, since it triggers on VimEnter which has already occurred prior to this plugin loading so we need to call install explicitly
        -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
        vim.api.nvim_command('MasonToolsInstall')

        local lspconfig = require('lspconfig')
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lsp_attach = function(client, bufnr)
            -- Create your keybindings here...
        end

        -- Call setup on each LSP server
        require('mason-lspconfig').setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    on_attach = lsp_attach,
                    capabilities = lsp_capabilities,
                })
            end
        })

        -- Lua LSP settings
        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
                    },
                },
            },
        }

        -- LSP Configuration
        require("lspconfig").yamlls.setup {
            settings = {
                yaml = {
                    schemas = {
                        kubernetes = "k8s-*.yaml",
                        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
                        ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                        ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                        ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                        ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
                    },
                },
            },
        }


        lspconfig.gopls.setup {
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            settings = {
                gopls = {
                    completeUnimported = true,
                    usePlaceholders = true,
                    analyses = {
                        unusedparams = true,
                    }
                }
            }
        }

        -- Globally configure all LSP floating preview popups (like hover, signature help, etc)
        local open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or "rounded" -- Set border to rounded
            return open_floating_preview(contents, syntax, opts, ...)
        end
    end
}
