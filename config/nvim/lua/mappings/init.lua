local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


-- Set leader key
vim.g.mapleader = ' '

-- Toggle File Explorer
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
