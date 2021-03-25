call plug#begin()

Plug 'sheerun/vim-polyglot'

Plug 'morhetz/gruvbox'

Plug 'vim-airline/vim-airline'

Plug 'preservim/nerdtree'

Plug 'preservim/nerdcommenter'

Plug 'Yggdroot/indentLine'

Plug 'lervag/vimtex'

call plug#end()

set splitbelow
set splitright

let g:airline#extensions#tabline#enabled = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

let g:indentLine_char = '⎸'
let g:indentLine_enabled = 1

tnoremap <Esc> <C-\><C-n>
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

highlight ColorColumn ctermbg=darkgray
call matchadd('ColorColumn', '\%81v.', 100)
call matchadd('ErrorMsg', '\%101v.', 100)

syntax on
set termguicolors
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_italic=1
colorscheme gruvbox
set number
" set relativenumber

filetype plugin on
