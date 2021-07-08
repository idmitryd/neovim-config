call plug#begin()

Plug 'sheerun/vim-polyglot'
Plug 'machakann/vim-sandwich'
Plug 'ntpeters/vim-better-whitespace'

Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

Plug 'hoob3rt/lualine.nvim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

Plug 'sainnhe/gruvbox-material'
set termguicolors
let g:gruvbox_material_palette='mix'
set background=dark
let g:gruvbox_material_background='medium'
let g:gruvbox_material_enable_bold=1
let g:gruvbox_material_enable_italic=1

Plug 'Yggdroot/indentLine'
let g:indentLine_char = '⎸'
let g:indentLine_enabled = 1

Plug 'lervag/vimtex'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_syntax_conceal_default = 0

Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/trouble.nvim'

call plug#end()

lua << EOF
require('lualine').setup{
	options = {
		icons_enabled=true,
		theme='gruvbox_material',
		section_separators='',
		component_separators='',
	}
}
require("bufferline").setup{
	--options = {
	--	show_buffer_icons=false,
	--}
}
EOF

" LSP things
lua << EOF
local nvim_lsp = require('lspconfig')
vim.lsp.set_log_level("debug")
require'lspinstall'.setup() -- important


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  --local opts = { noremap=true, silent=true }

  ---- See `:help vim.lsp.*` for documentation on any of the below functions
  --buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  --buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  --buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end
require'lspconfig'.clangd.setup{
	cmd = {"clangd-10", "--background-index"}
}

require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}
EOF
" Need to overwrite behaviour from /usr/local/share/nvim/runtime/ftplugin/c.vim
autocmd FileType c,cpp,python set omnifunc=v:lua.vim.lsp.omnifunc

" TreeSitter things
lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "bash", "fish", "latex", "cpp", "python", "cmake", "bibtex" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=-1
inoremap <F3> <C-^>
cnoremap <F3> <C-^>

set splitbelow
set splitright

tnoremap <Esc> <C-\><C-n>
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" Expand path to active files by pressing '%%'
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

highlight ColorColumn ctermbg=darkgray
call matchadd('ColorColumn', '\%81v.', 100)
call matchadd('ErrorMsg', '\%101v.', 100)

syntax on
colorscheme gruvbox-material
set number
" set relativenumber

set completeopt=menuone,longest,preview

set wildmenu
set wildmode=longest:full,full

filetype plugin on
