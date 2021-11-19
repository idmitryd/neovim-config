local g = vim.g
local o = vim.o
local wo = vim.wo
local bo = vim.bo
local map = vim.api.nvim_set_keymap

-- Need to make nvim to recognize .fish files
vim.cmd('au! BufRead,BufNewFile *.fish set filetype=fish')

-- Set colorsheme
vim.cmd('colorscheme gruvbox-material')

-- Map leaders
map('n', '<Space>', '', {})
map('o', '<Space>', '', {})
g.mapleader = ' '
map('n', '\\', '', {})
g.maplocalleader = '\\'

-- global options and variables
o.termguicolors = true
o.background = 'dark'

o.splitbelow = true
o.splitright = true
o.completeopt = 'menuone,preview,noinsert,noselect'
o.wildmenu = true
o.wildmode = 'longest:full,full'

-- buffer-local options
bo.keymap = 'russian-jcukenwin'
bo.iminsert = 0
bo.imsearch = -1

-- window-local options
wo.number = true
wo.colorcolumn='101'
