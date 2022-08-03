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

end)
