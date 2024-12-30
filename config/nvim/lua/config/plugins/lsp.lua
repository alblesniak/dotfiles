return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'folke/neodev.nvim',
        },
        config = function()
            require('neodev').setup()
            local lspconfig = require('lspconfig')
            
            -- Podstawowa konfiguracja serwerów LSP
            local servers = {
                pyright = {},
		ts_ls = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                        },
                    },
                },
            }

            -- Konfiguracja keymapów LSP
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                end,
            })

            -- Automatyczna instalacja i setup serwerów
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = vim.tbl_keys(servers),
            })

            -- Konfiguracja serwerów
            for server, config in pairs(servers) do
                lspconfig[server].setup(config)
            end
        end,
    },
}
