return {
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            relativenumbers = true,
            icons = {
                -- Configure the base icons on the bufferline.
                -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
                buffer_index = true,
                gitsigns = {
                    added = { enabled = true, icon = '+' },

                    changed = { enabled = true, icon = '~' },
                    deleted = { enabled = true, icon = '-' },
                },
            },
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
}
