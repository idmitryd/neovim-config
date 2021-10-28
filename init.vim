call plug#begin()

" Plug 'machakann/vim-sandwich'
Plug 'blackcauldron7/surround.nvim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'famiu/bufdelete.nvim'
" Plug 'ggandor/lightspeed.nvim'

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
let g:vimtex_syntax_conceal_disable = 1
let g:vimtex_quickfix_enabled = 0

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
Plug 'rcarriga/nvim-dap-ui'
Plug 'karb94/neoscroll.nvim'

Plug 'lukas-reineke/indent-blankline.nvim'
let g:indent_blankline_char = '▏'
let g:indent_blankline_show_first_indent_level = v:false

call plug#end()

inoremap jk <Esc>
inoremap kj <Esc>

nnoremap <Space> <Nop>
let mapleader = "\<Space>"
nnoremap \\ <Nop>
let maplocalleader = "\\"
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ft <cmd>Telescope treesitter<cr>

lua << EOF
require('surround').setup{}
require('nvim_comment').setup{}

require('lualine').setup{
	options = {
		icons_enabled=true,
		theme='gruvbox-material',
        --section_separators='',
        component_separators='',
	}
}
require('bufferline').setup{}
require('range-highlight').setup{}
require('neoscroll').setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                '<C-y>', '<C-e>'},--, 'zt', 'zz', 'zb'},
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,        -- Default easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,              -- Function to run after the scrolling animation ends
})

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
  buf_set_keymap("n", "<LocalLeader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<LocalLeader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<LocalLeader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
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
        },
        handlers = {
           ["textDocument/publishDiagnostics"] = vim.lsp.with(
             vim.lsp.diagnostic.on_publish_diagnostics, {
               -- Disable virtual_text
               virtual_text = false
             }
           ),
        },
    }
end
nvim_lsp.clangd.setup{
    on_attach = on_attach,
    cmd = {"clangd-10", "--background-index", "--fallback-style=google"},
    flags = {
        debounce_text_changes = 150,
    },
    handlers = {
       ["textDocument/publishDiagnostics"] = vim.lsp.with(
         vim.lsp.diagnostic.on_publish_diagnostics, {
           -- Disable virtual_text
           virtual_text = false
         }
       ),
     },
}

require('trouble').setup {
    height = 8,
    auto_preview = false,
    auto_fold = true,
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}
vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)
-- vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>",
--   {silent = true, noremap = true}
-- )
-- vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>",
--   {silent = true, noremap = true}
-- )
-- vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
--   {silent = true, noremap = true}
-- )
-- vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
--   {silent = true, noremap = true}
-- )
-- vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
--   {silent = true, noremap = true}
-- )

require('nvim-treesitter.configs').setup {
	ensure_installed = { "bash", "fish", "latex", "cpp", "python",
                        "cmake", "bibtex", "yaml", "lua" },
	highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
    },
    indent = {
        enable = true,
    },
}
-- vim.api.nvim_exec([[
--     set foldmethod=expr
--     set foldexpr=nvim_treesitter#foldexpr()
--     set foldminlines=5
--     set foldnestmax=3
-- ]], true)

local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode-10', -- adjust as needed
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
    args = {},

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
    env = function()
      local variables = {}
      for k, v in pairs(vim.fn.environ()) do
        table.insert(variables, string.format("%s=%s", k, v))
      end
      return variables
    end,
  },
}

require("dapui").setup({
  icons = {
    expanded = "▾",
    collapsed = "▸"
  },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = {"<CR>", "<2-LeftMouse>"},
    open = "o",
    remove = "d",
    edit = "e",
  },
  sidebar = {
    elements = {
      -- You can change the order of elements in the sidebar
      "scopes",
      "breakpoints",
      "stacks",
      "watches"
    },
    size = 40,
    position = "left" -- Can be "left" or "right"
  },
  tray = {
    elements = {
      "repl"
    },
    size = 10,
    position = "bottom" -- Can be "bottom" or "top"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil   -- Floats will be treated as percentage of your screen.
  }
})
EOF

nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

" Change default commentstring=\*%s*\ for cpp files
au FileType cpp setlocal commentstring=//\ %s
au FileType c setlocal tabstop=2
au FileType c setlocal shiftwidth=2
au FileType c setlocal expandtab
au FileType tex setlocal tabstop=2
au FileType tex setlocal shiftwidth=2
au FileType tex setlocal expandtab
au FileType tex setlocal spelllang=en_us,ru_ru
au FileType tex setlocal spell

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
