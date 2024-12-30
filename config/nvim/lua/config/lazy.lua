local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Automatyczna instalacja lazy.nvim
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git', 'clone', '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git', lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Konfiguracja pluginów
require('lazy').setup({
    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
    },
    
    -- Zarządzanie LSP
    {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        config = function() require('mason').setup() end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup {
                ensure_installed = { 'pyright', 'ts_ls' },
            }
        end,
    },

    -- Motyw
    {
        'Shatur/neovim-ayu',
        config = function()
            require('ayu').setup({
                mirage = false,
                terminal = true,
            })
            require('ayu').colorscheme()
        end,
    }
})
