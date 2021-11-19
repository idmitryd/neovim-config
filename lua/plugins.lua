-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Neorg
    use {
        'nvim-neorg/neorg',
        config = function() require('plugin/neorg') end,
        requires = { 'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope' }
    }

    -- LSP
    use {
        'neovim/nvim-lspconfig',
        requires = 'williamboman/nvim-lsp-installer',
        run = function()
            local servers_to_install = { 'clangd', 'pyright', 'cmake',
                                         'texlab', 'sumneko_lua', 'vimls' }
            local lsp_installer = require'nvim-lsp-installer'
            for _, server_name in pairs(servers_to_install) do
                local ok, server = lsp_installer.get_server(server_name)
                if ok then
                    server:install()
                else
                    print('Cannot find server ' .. server_name)
                end
            end
        end,
        config = function() require('plugin/lsp') end,
    }

    -- Tree-sitter
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('plugin/nvim-treesitter') end,
    }

    -- Trouble
    use {
        'folke/trouble.nvim',
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
        },
        config = function() require('plugin/trouble') end,
    }

    -- Debug
    use {
        'mfussenegger/nvim-dap',
        requires = 'rcarriga/nvim-dap-ui',
        -- ft = 'cpp',
        config = function() require('plugin/dap') end,
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-telescope/telescope-dap.nvim',
        config = function() require('plugin/telescope') end,
    }

    -- Registers
    use 'tversteeg/registers.nvim'

    -- Colorscheme
    use {
        'sainnhe/gruvbox-material',
        config = function()
            vim.g.gruvbox_material_palette='mix'
            vim.g.gruvbox_material_background='medium'
            vim.g.gruvbox_material_enable_bold=1
            vim.g.gruvbox_material_enable_italic=1
            -- It is needed for reloading color scheme with the options set above
            if vim.g.colors_name == 'gruvbox-material' then
                vim.cmd('colorscheme gruvbox-material')
            end
        end,
    }

    -- Range Highlight
    use {
        'winston0410/range-highlight.nvim',
        requires = 'winston0410/cmd-parser.nvim',
        config = function() require('plugin/range-highlight') end,
    }

    -- Comments
    use {
        'terrortylor/nvim-comment',
        config = function() require('plugin/nvim-comment') end,
    }

    -- Smooth scrolling
    use {
        'karb94/neoscroll.nvim',
        config = function() require('plugin/neoscroll') end,
    }

    -- Movement
    use {
        'phaazon/hop.nvim',
        config = function() require('plugin/hop') end,
    }

    -- Identation guides
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            vim.g.indent_blankline_char = '▏'
            vim.g.indent_blankline_show_first_indent_level = false
        end,
    }

    -- LaTeX support
    use {
        'lervag/vimtex',
        config = function()
            vim.g.vimtex_view_general_viewer = 'okular'
            vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
            vim.g.vimtex_view_general_options_latexmk = '--unique'
            vim.g.vimtex_syntax_conceal_disable = 1
            vim.g.vimtex_quickfix_enabled = 0
        end,
    }

    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'ryanoasis/vim-devicons',
            'kyazdani42/nvim-web-devicons',
        }
    }

    -- Status line
    use {
        'hoob3rt/lualine.nvim',
        config = function() require('plugin/lualine') end,
    }

    -- Buffer line
    use {
        'akinsho/nvim-bufferline.lua',
        config = function() require('plugin/nvim-bufferline') end,
    }

    -- Surrounding
    use {
        'blackcauldron7/surround.nvim',
        config = function() require('plugin/surround') end,
    }

    -- Better whitespace
    use {
        'ntpeters/vim-better-whitespace',
        config = function() vim.g.strip_whitespace_on_save=1 end,
    }

    -- Better buffers delete
    use 'famiu/bufdelete.nvim'
end)
