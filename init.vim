call plug#begin()

Plug 'machakann/vim-sandwich'
Plug 'ntpeters/vim-better-whitespace'

Plug 'hoob3rt/lualine.nvim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'sainnhe/gruvbox-material'
set termguicolors
let g:gruvbox_material_palette='mix'
let g:gruvbox_material_background='medium'
let g:gruvbox_material_enable_bold=1
let g:gruvbox_material_enable_italic=1

Plug 'lervag/vimtex'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_syntax_conceal_default = 0

Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/trouble.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
Plug 'winston0410/cmd-parser.nvim'
Plug 'winston0410/range-highlight.nvim'
Plug 'terrortylor/nvim-comment'
Plug 'mfussenegger/nvim-dap'

Plug 'lukas-reineke/indent-blankline.nvim'
let g:indent_blankline_char = '▏'
let g:indent_blankline_show_first_indent_level = v:false

call plug#end()

nnoremap <Space> <Nop>
let mapleader = "\<Space>"

lua << EOF
require('nvim_comment').setup{}

require('lualine').setup{
	options = {
		icons_enabled=true,
		theme='gruvbox_material',
        --section_separators='',
        component_separators='',
	}
}
require('bufferline').setup{}
require('range-highlight').setup{}

local nvim_lsp = require('lspconfig')
require('lspinstall').setup{}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap("n", "<Leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  --buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

local servers = require('lspinstall').installed_servers()
for _, server in pairs(servers) do
    nvim_lsp[server].setup{
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }
end
nvim_lsp.clangd.setup{
    on_attach = on_attach,
	cmd = {"clangd-10", "--background-index"},
    flags = {
        debounce_text_changes = 150,
    }
}

require('trouble').setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}

require('nvim-treesitter.configs').setup {
	ensure_installed = { "bash", "fish", "latex", "cpp", "python",
                        "cmake", "bibtex", "yaml", "lua" },
	highlight = {
	enable = true,
  },
}

--/usr/bin/lldb
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb', -- adjust as needed
  name = "lldb"
}
dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    args = {'1'},

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  },
}
EOF

" Change default commentstring=\*%s*\ for cpp files
au FileType cpp setlocal commentstring=//\ %s

" Need to make nvim to recognize .fish files
au! BufRead,BufNewFile *.fish set filetype=fish

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

colorscheme gruvbox-material
set number

" set completeopt=menuone,longest,preview
set completeopt=menuone,preview,noinsert,noselect
set wildmenu
set wildmode=longest:full,full
" 'v:lua.vim.lsp.omnifunc')
