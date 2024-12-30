return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
        },
        config = function()
            local telescope = require('telescope')
            local builtin = require('telescope.builtin')
            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                        },
                    },
                },
            })

            -- Włącz fuzzy finding
            telescope.load_extension('fzf')

            -- Keymapy
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Szukaj plików' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Szukaj w plikach' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Szukaj buforów' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Szukaj pomocy' })
        end,
    },
}
