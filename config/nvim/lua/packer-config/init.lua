return require('packer').startup(function()

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- File icons
    use 'kyazdani42/nvim-web-devicons'

    -- Tokyo Night colorscheme
    use 'folke/tokyonight.nvim'

    -- File Explorer nvim-tree
    use 'kyazdani42/nvim-tree.lua'

    -- Configurations for Nvim LSP
    use 'neovim/nvim-lspconfig'
    
    -- Autocompletion plugin
    use 'hrsh7th/nvim-cmp'

    -- LSP source for nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp'

    -- Snippets source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'

    -- Vscode-like pictograms in autocompletion
    use 'onsails/lspkind-nvim'
    
    -- A fancy, configurable, notification manager for NeoVim
    use 'rcarriga/nvim-notify'

    -- Neovim statusline
    use 'nvim-lualine/lualine.nvim'

    -- Tabline plugin
    use 'romgrk/barbar.nvim'

    -- Tree-sitter syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    -- Tree-sitter plugin for highlight definition and current scope
    use 'nvim-treesitter/nvim-treesitter-refactor'

    -- Telescope fuzzy finder
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Mason.nvim plugin to manage LSP, DAP, linters, formatters, etc.
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- plugin that renders diagnostics using virtual lines on top of the real line of code
    use({
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    })

end)
