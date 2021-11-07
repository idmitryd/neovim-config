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

  -- LSP
  use 'kabouzeid/nvim-lspinstall'
  use {
    'neovim/nvim-lspconfig',
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

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-telescope/telescope-dap.nvim',
    config = function() require('plugin/telescope') end,
  }

  -- Debug
  use {
    'mfussenegger/nvim-dap',
    requires = 'rcarriga/nvim-dap-ui',
    ft = 'cpp',
    config = function() require('plugin/dap') end,
  }

  -- Registers
  use 'tversteeg/registers.nvim'

  -- Colorscheme
  use 'sainnhe/gruvbox-material'

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
  use 'lukas-reineke/indent-blankline.nvim'

  -- LaTeX support
  use 'lervag/vimtex'

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
  use 'ntpeters/vim-better-whitespace'

  -- Better buffers delete
  use 'famiu/bufdelete.nvim'
end)
