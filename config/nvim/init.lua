-- [[ Ładowanie Lazy.nvim ]]
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Podstawowa konfiguracja Neovim ]]
vim.g.mapleader = ' '             -- Klawisz lidera: spacja
vim.g.maplocalleader = ' '        -- Lokalny klawisz lidera: spacja

-- [[ Wygląd i interfejs ]]
vim.g.have_nerd_font = true       -- Użyj Nerd Fonts dla ikon, jeśli są zainstalowane
vim.opt.number = true             -- Wyświetl numery linii
vim.opt.relativenumber = true     -- Wyświetl względne numery linii
vim.opt.cursorline = true         -- Podświetl linię z kursorem
vim.opt.list = true               -- Pokazuj znaki specjalne (np. tabulatory)
vim.opt.listchars = {             -- Definicja znaków specjalnych:
    tab = '» ',                   -- → Tab
    trail = '·',                  -- · Puste miejsca na końcu linii
    nbsp = '␣'                    -- ␣ Spacja niełamliwa
}
vim.opt.termguicolors = true      -- Włącz obsługę kolorów true color

-- [[ Funkcjonalność ]]
vim.opt.mouse = 'a'               -- Obsługa myszy w każdym trybie
vim.opt.breakindent = true        -- Zachowaj wcięcia przy zawijaniu linii
vim.opt.clipboard = 'unnamedplus' -- Synchronizacja schowka systemowego z Neovimem
vim.opt.undofile = true           -- Zachowuj historię cofania między sesjami
vim.opt.ignorecase = true         -- Ignoruj wielkość liter w wyszukiwaniu
vim.opt.smartcase = true          -- Uwzględnij wielkość liter, jeśli wpisano wielką literę
vim.opt.signcolumn = 'yes'        -- Stała kolumna znaków diagnostycznych
vim.opt.updatetime = 250          -- Skróć czas aktualizacji
vim.opt.timeoutlen = 300          -- Skróć czas oczekiwania na kombinację klawiszy
vim.opt.inccommand = 'split'      -- Podgląd zmian podczas wprowadzania komendy zamiany
vim.opt.splitright = true         -- Podziały okien: nowe okna po prawej
vim.opt.splitbelow = true         -- Podziały okien: nowe okna na dole
vim.opt.scrolloff = 10            -- Minimalna liczba linii wokół kursora

-- [[ Mapowania klawiszy ]]
vim.keymap.set({ 'n', 'v' }, 'j', 'h', { desc = 'Ruch w lewo' })
vim.keymap.set({ 'n', 'v' }, 'k', 'j', { desc = 'Ruch w dół' })
vim.keymap.set({ 'n', 'v' }, 'l', 'k', { desc = 'Ruch w górę' })
vim.keymap.set({ 'n', 'v' }, ';', 'l', { desc = 'Ruch w prawo' })

vim.keymap.set('n', '\'', ';', { desc = 'Powtórz ostatni ruch f/t/F/T' })
vim.keymap.set('v', 'p', 'P', { desc = 'Wklej bez nadpisywania schowka' })
vim.keymap.set({ 'n', 'v' }, 'd', '"_d', { desc = 'Usuń bez nadpisywania schowka' })
vim.keymap.set({ 'n', 'v' }, 'dd', '"_dd', { desc = 'Usuń całą linię bez nadpisywania schowka' })
vim.keymap.set('n', 'U', '<C-r>', { desc = 'Cofnij operację (redo)' })
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true, desc = 'Wychodzenie z INSERT za pomocą jj' })
vim.keymap.set('i', 'jk', '<Esc>:w<CR>', { noremap = true, silent = true, desc = 'Wyjdź z INSERT i zapisz plik' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Usuń podświetlenie wyszukiwania' })
vim.keymap.set('n', '<C-j>', '<C-w><C-h>', { desc = 'Przejdź do okna po lewej' })
vim.keymap.set('n', '<C-k>', '<C-w><C-j>', { desc = 'Przejdź do okna poniżej' })
vim.keymap.set('n', '<C-l>', '<C-w><C-k>', { desc = 'Przejdź do okna powyżej' })
vim.keymap.set('n', '<C-;>', '<C-w><C-l>', { desc = 'Przejdź do okna po prawej' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Wyjście z trybu terminala' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Otwórz listę diagnostyczną' })
vim.keymap.set('n', '<leader>s', ':w<CR>', { desc = 'Zapisz plik' })

-- [[ Automatyczne podświetlenie podczas kopiowania ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Podświetl tekst po skopiowaniu',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Instalacja i konfiguracja Lazy.nvim ]]
require('lazy').setup({
 {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  },
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = { 'pyright', 'ts_ls' },
      }
    end,
  },
  {
    'Shatur/neovim-ayu',
    config = function()
        require('ayu').setup({
            mirage = false, -- Użyj `dark` jako domyślnego wariantu
            terminal = true, -- Kolory terminala zarządzane przez motyw
        })
        require('ayu').colorscheme() -- Ustawienia motywu kolorów
    end,
  },
  {
    'mg979/vim-visual-multi',
    branch = 'master',
  }
})

-- [[ Konfiguracja LSP ]]
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.ts_ls.setup {}

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Ustawienia LSP dla bufora',
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  end,
})

-- [[ Konfiguracja multi-cursor ]]
-- Plugin "vim-visual-multi" umożliwia używanie wielu kursorów.
-- Kluczowe mapowania:
-- 1. W trybie wizualnym zaznacz kilka linii, a następnie:
--    - Naciśnij `mi`, aby dodać kursor na początku każdej zaznaczonej linii.
--    - Naciśnij `ma`, aby dodać kursor na końcu każdej zaznaczonej linii.
-- 2. Użyj standardowych poleceń edycyjnych, aby zmienić tekst dla wszystkich kursorów jednocześnie.
vim.keymap.set('v', 'mi', ':<C-u>call VM_Start({"cursor_positions": "start"})<CR>', { desc = 'Dodaj multi-cursory na początku linii' })
vim.keymap.set('v', 'ma', ':<C-u>call VM_Start({"cursor_positions": "end"})<CR>', { desc = 'Dodaj multi-cursory na końcu linii' })
