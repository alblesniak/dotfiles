return {
    {
        'Shatur/neovim-ayu',
        priority = 1000,
        config = function()
            require('ayu').setup({
                mirage = false,
                terminal = true,
                overrides = {
                    Normal = { bg = 'None' },
                    ColorColumn = { bg = 'None' },
                    SignColumn = { bg = 'None' },
                    Folded = { bg = 'None' },
                    FoldColumn = { bg = 'None' },
                    CursorLine = { bg = 'None' },
                },
            })
            require('ayu').colorscheme()
        end,
    },
}
