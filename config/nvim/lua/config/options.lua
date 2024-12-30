local opt = vim.opt
local g = vim.g

-- Podstawowe ustawienia
g.mapleader = ' '
g.maplocalleader = ' '
g.have_nerd_font = true

-- Interfejs
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.termguicolors = true
opt.signcolumn = 'yes'

-- Edycja
opt.mouse = 'a'
opt.breakindent = true
opt.clipboard = 'unnamedplus'
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true

-- Wydajność i UX
opt.updatetime = 250
opt.timeoutlen = 300
opt.scrolloff = 10

-- Podział okien
opt.splitright = true
opt.splitbelow = true
opt.inccommand = 'split'
