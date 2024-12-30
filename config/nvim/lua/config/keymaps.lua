local map = vim.keymap.set

-- Nawigacja (colemak)
local nav_maps = {
    { {'n', 'v'}, 'j', 'h', 'Lewo' },
    { {'n', 'v'}, 'k', 'j', 'Dół' },
    { {'n', 'v'}, 'l', 'k', 'Góra' },
    { {'n', 'v'}, ';', 'l', 'Prawo' },
}

for _, m in ipairs(nav_maps) do
    map(m[1], m[2], m[3], { desc = m[4] })
end

-- Edycja
map('v', 'p', 'P', { desc = 'Zachowaj schowek po wklejeniu' })
map({'n', 'v'}, 'd', '"_d', { desc = 'Usuń bez kopiowania' })
map({'n', 'v'}, 'dd', '"_dd', { desc = 'Usuń linię bez kopiowania' })

-- Skróty wyjścia
map('i', 'jj', '<Esc>', { desc = 'Wyjście z INSERT' })
map('i', 'jk', '<Esc>:w<CR>', { desc = 'Zapisz i wyjdź z INSERT' })

-- Nawigacja między oknami
local window_maps = {
    { '<C-j>', '<C-w><C-h>', 'Okno lewo' },
    { '<C-k>', '<C-w><C-j>', 'Okno dół' },
    { '<C-l>', '<C-w><C-k>', 'Okno góra' },
    { '<C-;>', '<C-w><C-l>', 'Okno prawo' },
}

for _, m in ipairs(window_maps) do
    map('n', m[1], m[2], { desc = m[3] })
end

-- autocmds.lua
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Podświetlanie yanked tekstu
autocmd('TextYankPost', {
    desc = 'Podświetl skopiowany tekst',
    group = augroup('highlight-yank', { clear = true }),
    callback = function() vim.highlight.on_yank() end,
})
