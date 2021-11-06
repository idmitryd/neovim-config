local g = vim.g
local o = vim.o
local wo = vim.wo
local bo = vim.bo
local map = vim.api.nvim_set_keymap

-- Set colorsheme
vim.cmd('colorscheme gruvbox-material')

-- Need to make nvim to recognize .fish files
vim.cmd('au! BufRead,BufNewFile *.fish set filetype=fish')

-- Map leaders
map('n', '<Space>', '', {})
g.mapleader = ' '
map('n', '\\', '', {})
g.maplocalleader = '\\'

-- global options and variables

o.splitbelow = true
o.splitright = true
o.completeopt = 'menuone,preview,noinsert,noselect'
o.wildmenu = true
o.wildmode = 'longest:full,full'

o.termguicolors = true
g.gruvbox_material_palette='mix'
g.gruvbox_material_background='medium'
g.gruvbox_material_enable_bold=1
g.gruvbox_material_enable_italic=1

g.vimtex_view_general_viewer = 'okular'
g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
g.vimtex_view_general_options_latexmk = '--unique'
g.vimtex_syntax_conceal_disable = 1
g.vimtex_quickfix_enabled = 0

g.indent_blankline_char = '▏'
g.indent_blankline_show_first_indent_level = false

-- buffer-local options
bo.keymap = 'russian-jcukenwin'
bo.iminsert = 0
bo.imsearch = -1

-- window-local options
wo.number = true
wo.colorcolumn='101'
