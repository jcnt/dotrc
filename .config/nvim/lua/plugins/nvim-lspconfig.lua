-- LSP Support
return {
    -- https://github.com/neovim/nvim-lspconfig
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
        { 'mason-org/mason.nvim' },
        { 'mason-org/mason-lspconfig.nvim' },
        { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
        { 'j-hui/fidget.nvim', opts = {} },
        -- neodev.nvim is archived; lazydev.nvim is its replacement
        { 'folke/lazydev.nvim', ft = 'lua', opts = {} },
    },
    config = function()
        -- Shared settings for every server
        vim.lsp.config('*', {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })

        -- Keybindings (replaces on_attach)
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local bufnr = args.buf
                -- Create your keybindings here, e.g.:
                -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
            end,
        })

        -- Per-server settings
        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    diagnostics = { globals = { 'vim' } },
                },
            },
        })

        vim.lsp.config('yamlls', {
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
        })

        vim.lsp.config('gopls', {
            settings = {
                gopls = {
                    completeUnimported = true,
                    usePlaceholders = true,
                    analyses = { unusedparams = true },
                },
            },
        })

        -- Install servers; v2 auto-enables them (automatic_enable = true by default)
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                'bashls', 'html', 'lua_ls', 'jsonls',
                'marksman', 'yamlls', 'pylsp', 'gopls',
            },
        })

        require('mason-tool-installer').setup({
            ensure_installed = {
                'black', 'debugpy', 'flake8', 'isort', 'mypy', 'pylint',
            },
        })
        -- VeryLazy loads after VimEnter, so trigger the install manually
        -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
        vim.api.nvim_command('MasonToolsInstall')

        -- Rounded borders on all LSP floating windows
        local open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or 'rounded'
            return open_floating_preview(contents, syntax, opts, ...)
        end
    end,
}
