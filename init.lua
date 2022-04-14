-- {{{ Plugins
-- {{{2 Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- vim.api.nvim_exec(
-- [[
-- augroup Packer
-- autocmd!
-- autocmd BufWritePost init.lua PackerCompile
-- augroup end
-- ]],
-- false
-- )
--- }}}2
-- {{{2 Plugins load and setup
local use = require('packer').use
require('packer').startup({
    function()
        -- {{{3 Package manager
        use 'wbthomason/packer.nvim'
        -- }}}3
        -- {{{3 Colorschemes
        -- use {
        --     '~/.config/nvim/lua/my_theme/',
        --     config = function()
        --         require'gruvqueen'.setup()
        --     end,
        -- }
        use {
            "junegunn/seoul256.vim"
        }
        use {
            "mcchrish/zenbones.nvim",
            -- Optionally install Lush. Allows for more configuration or extending the colorscheme
            -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
            -- In Vim, compat mode is turned on as Lush only works in Neovim.
            requires = "rktjmp/lush.nvim"
        }
        use {
            "rebelot/kanagawa.nvim",
            -- config = function()
                --     require'kanagawa'.setup()
                --     vim.cmd("colorscheme kanagawa")
                -- end,
            }
        use {
            "catppuccin/nvim",
            as = "catppuccin",
        }
        use {
            "lukas-reineke/onedark.nvim",
        }
        use {
            'idmitryd/gruvqueen',
            config = function()
                local c = require("gruvqueen/palette").get_dark_theme_palette().common
                -- local common = {
                --     none =             "NONE",
                --     bg0 =              "#282828",
                --     bg1 =              "#32302f",
                --     bg2 =              "#32302f",
                --     bg3 =              "#45403d",
                --     bg4 =              "#45403d",
                --     bg5 =              "#5a544c",
                --     bg_statusline1 =   "#32302f",
                --     bg_statusline2 =   "#3a3735",
                --     bg_statusline3 =   "#504945",
                --     bg_diff_green =    "#34381b",
                --     bg_visual_green =  "#3b4439",
                --     bg_diff_red =      "#402120",
                --     bg_visual_red =    "#4c3432",
                --     bg_diff_blue =     "#0e363e",
                --     bg_visual_blue =   "#374141",
                --     bg_visual_yellow = "#4f422e",
                --     bg_visual_aqua =   '#253a1f',
                --     bg_current_word =  "#3c3836",
                --     grey0 =            "#7c6f64",
                --     grey1 =            "#928374",
                --     grey2 =            "#a89984",
                -- }
                local mix = require("gruvqueen/palette").get_dark_theme_palette().mix
                -- local mix = {
                --     fg0 =       "#e2cca9",
                --     fg1 =       "#e2cca9",
                --     red =       "#f2594b",
                --     orange =    "#f28534",
                --     yellow =    "#e9b143",
                --     green =     "#b0b846",
                --     aqua =      "#8bba7f",
                --     blue =      "#80aa9e",
                --     purple =    "#d3869b",
                --     bg_red =    "#db4740",
                --     bg_green =  "#b0b846",
                --     bg_yellow = "#e9b143",
                -- }

                require("gruvqueen").setup({
                    palette = {
                    },
                    config = {
                        disable_bold = false,
                        italic_comments = true,
                        -- italic_keywords = true,
                        -- italic_functions = true,
                        -- italic_variables = true,
                        bg_color = c.bg0,
                        style = 'mix',
                        invert_selection = false,
                    },
                    base = {
                        LineNr = { fg = c.grey1, }, -- #928374
                        CursorLineNr = { fg = mix.fg0, },
                        FloatBorder = { fg = c.grey1, bg = c.bg0, },
                        EndOfBuffer = { fg = c.bg0 },--, bg = c.bg0 },
                        VertSplit = { fg = c.bg0, bg = c.grey2 },
                        NormalFloat = { bg = c.bg0 },
                        TabLineFill = {fg = c.fg1, bg = c.bg0, style = "NONE", },
                    },
                    plugins = {
                        TreesitterContext = { bg = c.bg1 },
                    },
                })
            end
        }
        --}}}3
        -- {{{3 Status line
        use {
            'hoob3rt/lualine.nvim',
            after = 'gruvqueen',
            -- lua/plugin/lualine
            config = function() require('plugin.lualine').setup() end,
        }
        -- }}}3
        -- {{{3 Buffer line
        use {
            'romgrk/barbar.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            event = "BufWinEnter",
        }
        -- }}}3
        -- {{{3 Which-key
        use {
            'folke/which-key.nvim',
            event = 'BufWinEnter',
            config = function()
                  -- lua/plugin/which-key
                  require "plugin.which-key".setup()
            end,
        }
        -- }}}3
        -- {{{3 DashBoard
        use {
            'ChristianChiarulli/dashboard-nvim',
            event = 'BufWinEnter',
            config = function()
                vim.g.dashboard_custom_section = {
                    a = {
                        description = { "  Find File          " },
                        -- description = { "  Find File" },
                        command = "Telescope find_files",
                    },
                    b = {
                        description = { "  New File           " },
                        -- description = { "  New File" },
                        command = ":ene!",
                    },
                    c = {
                        description = { "  Recent Projects    " },
                        -- description = { "  Recent Projects" },
                        command = "Telescope projects",
                    },
                    d = {
                        description = { "  Recently Used Files" },
                        -- description = { "  Recently Used Files" },
                        command = "Telescope oldfiles",
                    },
                    e = {
                        description = { "  Find Word          " },
                        -- description = { "  Find Word" },
                        command = "Telescope live_grep",
                    },
                    f = {
                        description = { "  Configuration      " },
                        -- description = { "  Configuration" },
                        command = ":e " .. vim.fn.stdpath('config') .. '/init.lua',
                    },
                }
                vim.g.dashboard_custom_header = {
                    '    ⢰⣧⣼⣯⠄⣸⣠⣶⣶⣦⣾⠄     ⢀⣿⣿   ⢸⡇⠄⠄                                                         ⣿⣿⣷⡁⢆⠈⠕⢕⢂⢕⢂⢕⢂⢔⢂⢕⢄⠂⣂⠂⠆⢂⢕⢂⢕⢂⢕⢂⢕⢂ ',
                    '    ⣾⣿⠿⠿⠶⠿⢿⣿⣿⣿⣿⣦⣤⣄⢀ ⢠⣾⣛⡉   ⠸⢀⣿⠄                                                         ⣿⣿⣿⡷⠊⡢⡹⣦⡑⢂⢕⢂⢕⢂⢕⢂⠕⠔⠌⠝⠛⠶⠶⢶⣦⣄⢂⢕⢂⢕ ',
                    '   ⢀⡋⣡⣴⣶⣶⡀⠄⠄⠙⢿⣿⣿⣿⣿⣿⣴⣿⣿⣿⢃⣤⣄⣀⣥⣿⣿⠄                                                         ⣿⣿⠏⣠⣾⣦⡐⢌⢿⣷⣦⣅⡑⠕⠡⠐⢿⠿⣛⠟⠛⠛⠛⠛⠡⢷⡈⢂⢕⢂ ',
                    '   ⢸⣇⠻⣿⣿⣿⣧⣀⢀⣠⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⠄                                                         ⠟⣡⣾⣿⣿⣿⣿⣦⣑⠝⢿⣿⣿⣿⣿⣿⡵⢁⣤⣶⣶⣿⢿⢿⢿⡟⢻⣤⢑⢂ ',
                    '  ⢀⢸⣿⣷⣤⣤⣤⣬⣙⣛⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡍⠄⠄⢀⣤⣄⠉⠋⣰  ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗ ⣾⣿⣿⡿⢟⣛⣻⣿⣿⣿⣦⣬⣙⣻⣿⣿⣷⣿⣿⢟⢝⢕⢕⢕⢕⢽⣿⣿⣷⣔ ',
                    '  ⣼⣖⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⢇⣿⣿⡷⠶⠶⢿⣿⣿⠇⢀⣤  ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║ ⣿⣿⠵⠚⠉⢀⣀⣀⣈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣗⢕⢕⢕⢕⢕⢕⣽⣿⣿⣿⣿ ',
                    ' ⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣷⣶⣥⣴⣿⡗  ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║ ⢷⣂⣠⣴⣾⡿⡿⡻⡻⣿⣿⣴⣿⣿⣿⣿⣿⣿⣷⣵⣵⣵⣷⣿⣿⣿⣿⣿⣿⡿ ',
                    ' ⢀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟   ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║  ⠻⣿⡿⡫⡪⡪⡪⡪⣺⣿⣿⣿⣿⣿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃ ',
                    ' ⢸⣿⣦⣌⣛⣻⣿⣿⣧⠙⠛⠛⡭⠅⠒⠦⠭⣭⡻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃   ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║   ⠹⡪⡪⡪⡪⣪⣾⣿⣿⣿⣿⠋⠐⢉⢍⢄⢌⠻⣿⣿⣿⣿⣿⣿⣿⣿⠏  ',
                    ' ⠘⣿⣿⣿⣿⣿⣿⣿⣿⡆        ⠹⠈⢋⣽⣿⣿⣿⣿⣵⣾⠃   ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝    ⠙⣾⣾⣾⣿⣿⣿⣿⣿⣿⡀⢐⢕⢕⢕⢕⢕⡘⣿⣿⣿⣿⣿⣿⠏   ',
                    '  ⠘⣿⣿⣿⣿⣿⣿⣿⣿ ⣴⣿⣶⣄⠄⣴⣶⠄⢀⣾⣿⣿⣿⣿⣿⣿⠃                                                               ⠹⣿⣿⣿⣿⣿⣿⣿⣿⣧⢐⢕⢕⢕⢕⢕⢅⣿⣿⣿⣿⡿⢋⢜   ',
                    '   ⠈⠻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⠄⣿⣿⡀⣾⣿⣿⣿⣿⣛⠛⠁                                                                 ⠈⠻⣿⣿⣿⣿⣿⣿⣿⣷⣕⣑⣑⣑⣵⣿⣿⣿⡿⢋⢔⢕⣿   ',
                    '     ⠈⠛⢿⣿⣿⣿⠁⠞⢿⣿⣿⡄⢿⣿⡇⣸⣿⣿⠿⠛⠁                                                                      ⠉⠛⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢋⢔⢕⢕⣿⣿   ',
                    '        ⠉⠻⣿⣿⣾⣦⡙⠻⣷⣾⣿⠃⠿⠋⠁                                                                                ⠉⢍⢛⢛⢛⢋⢔⢕⢕⢕⣽⣿⣿   ',

--                     ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
--                     ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
--                     ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
--                     ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
--                     ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
--                     ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
                }
                vim.api.nvim_command('autocmd FileType dashboard set showtabline=0 | autocmd BufLeave <buffer> set showtabline=2')
                vim.api.nvim_command('autocmd FileType dashboard setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell  nolist  nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs= ')
                vim.api.nvim_command('autocmd FileType dashboard nnoremap <silent> <buffer> q :q<CR>')
            end,
        }
        -- }}}3
        -- {{{3 Neorg
        use {
            'nvim-neorg/neorg',
            config = function()
                require('neorg').setup {
                    -- Tell Neorg what modules to load
                    load = {
                        -- Load all the default modules
                        ["core.defaults"] = {},
                        -- Configure core.keybinds
                        ["core.keybinds"] = {
                            config = {
                                default_keybinds = true, -- Generate the default keybinds
                                neorg_leader = "<Leader>o" -- This is the default if unspecified
                            }
                        },
                        -- Allows for use of icons
                        ["core.norg.concealer"] = {},
                        -- Manage your directories with Neorg
                        ["core.norg.dirman"] = {
                            config = {
                                workspaces = {
                                    my_workspace = "~/neorg"
                                }
                            }
                        },
                        ["core.integrations.telescope"] = {},
                    },
                }
            end,
            requires = { 'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope' }
        }
        -- }}}3
        -- {{{3 nvim-cmp
        use {
            "hrsh7th/nvim-cmp",
            requires = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-nvim-lua',
                'saadparwaiz1/cmp_luasnip',
                'kdheepak/cmp-latex-symbols'
            },
            -- lua/plugin/cmp
            config = function()
                require('plugin.cmp').setup()
                vim.b.cmp_toggle_flag = true
            end,
        }
        -- }}}
        -- {{{3 LSP
        use {
            'neovim/nvim-lspconfig',
            requires = 'williamboman/nvim-lsp-installer',
            -- lua/plugin/lsp
            run = function() require('plugin.lsp').run() end,
            config = function() require('plugin.lsp').setup() end,
        }
        use {
            "tami5/lspsaga.nvim",
            config = function()
                require('lspsaga').setup()
                local options = { noremap = true }
                vim.api.nvim_set_keymap('n', '<C-d>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", options)
                vim.api.nvim_set_keymap('n', '<C-u>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", options)
            end,
        }
        -- }}}3
        -- {{{3 Tree-sitter
        use 'nvim-treesitter/nvim-treesitter-textobjects'
        use 'romgrk/nvim-treesitter-context'
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = function()
                -- lua/plugin/nvim-treesitter
                require'plugin.nvim-treesitter'.setup()
            end,
        }
        -- }}}3
        -- {{{3 Trouble
        use {
            'folke/trouble.nvim',
            requires = {
                'nvim-lua/popup.nvim',
                'nvim-lua/plenary.nvim',
            },
            config = function()
                require('trouble').setup {
                    height = 8,
                    auto_preview = false,
                    auto_fold = true,
                }
            end,
        }
        -- }}}3
        -- {{{3 Debug
        use {
            'mfussenegger/nvim-dap',
            requires = { 'rcarriga/nvim-dap-ui', 'Pocco81/DAPInstall.nvim'},
            -- ft = 'cpp',
            config = function()
                -- lua/plugin/dap
                require('plugin.dap').setup()
            end,
        }
        -- }}}3
        -- {{{3 Telescope
        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                'nvim-telescope/telescope-project.nvim',
                {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            },
            config = function()
                require('telescope').setup {
                    defaults = {
                        selection_caret = ' ',
                        prompt_prefix = " ",

                    },
                    extentions = {
                        fzf = {
                            fuzzy = true,                    -- false will only do exact matching
                            override_generic_sorter = true,  -- override the generic sorter
                            override_file_sorter = true,     -- override the file sorter
                            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        },
                    },
                }
                require('telescope').load_extension('fzf')
                require('telescope').load_extension('project')
                require('telescope').load_extension('projects')
                require("telescope").load_extension('notify')
            end,
        }
        -- }}}3
        -- {{{3 Project manager
        use {
            "ahmedkhalf/project.nvim",
            config = function()
                require("project_nvim").setup {
                    -- Manual mode doesn't automatically change your root directory, so you have
                    -- the option to manually do so using `:ProjectRoot` command.
                    manual_mode = false,

                    -- Methods of detecting the root directory. **"lsp"** uses the native neovim
                    -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
                    -- order matters: if one is not detected, the other is used as fallback. You
                    -- can also delete or rearangne the detection methods.
                    detection_methods = { "lsp", "pattern" },

                    -- All the patterns used to detect root dir, when **"pattern"** is in
                    -- detection_methods
                    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

                    -- Table of lsp clients to ignore by name
                    -- eg: { "efm", ... }
                    ignore_lsp = {},

                    -- Don't calculate root dir on specific directories
                    -- Ex: { "~/.cargo/*", ... }
                    exclude_dirs = {},

                    -- Show hidden files in telescope
                    show_hidden = false,

                    -- When set to false, you will get a message when project.nvim changes your
                    -- directory.
                    silent_chdir = true,

                    -- Path where project.nvim will store the project history for use in
                    -- telescope
                    datapath = vim.fn.stdpath("data"),
                }
            end,
        }
        -- }}}3
        -- {{{3 Comments
        use {
            "numToStr/Comment.nvim",
            event = "BufRead",
            config = function()
                require('Comment').setup({
                    ignore = '^$',
                    mappings = {
                        basic = true,
                        extra = true,
                    },
                })
            end,
        }
        -- }}}3
        -- {{{3 Motion
        use {
            "phaazon/hop.nvim",
            event = "BufRead",
            config = function() require("hop").setup() end,
        }
        -- use {
        --     "ggandor/leap.nvim",
        --     config = function() require("leap").setup{} end,
        -- }
        -- }}}3
        -- {{{3 Identation guides
        use {
            "lukas-reineke/indent-blankline.nvim",
            event = "BufRead",
            -- setup = function()
            --     vim.g.indentLine_enabled = 1
            --     vim.g.indent_blankline_char = "▏"
            --     vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
            --     vim.g.indent_blankline_buftype_exclude = {"terminal"}
            --     vim.g.indent_blankline_show_trailing_blankline_indent = false
            --     vim.g.indent_blankline_show_first_indent_level = false
            -- end,
            config = function()
                require("indent_blankline").setup {
                    char = "▏",
                    filetype_exclude = {"help", "terminal", "dashboard"},
                    buftype_exclude = {"terminal"},
                    show_trailing_blankline_indent = false,
                    show_first_indent_level = false,
                }
            end,
        }
        -- }}}3
        -- {{{3 LaTeX support
        use {
            'lervag/vimtex',
            config = function()
                vim.g.vimtex_view_general_viewer = 'okular'
                vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
                -- vim.g.vimtex_view_general_options_latexmk = '--unique'
                vim.g.vimtex_syntax_conceal_disable = 1
                vim.g.vimtex_quickfix_enabled = 0
            end,
        }
        -- }}}3
        -- {{{ File explorer
        use {
            'kyazdani42/nvim-tree.lua',
            requires = {
                'ryanoasis/vim-devicons',
                'kyazdani42/nvim-web-devicons',
            },
            config = function()
                -- lua/plugin/nvimtree
                require "plugin.nvimtree".setup()
            end,
        }
        -- }}}3
        -- {{{3 Surrounding
        use {
            "ur4ltz/surround.nvim",
            config = function()
                -- require('surround').setup{load_keymaps=false}
                require('surround').setup{}
                -- It is needed to use 's' character in select mode that snippets use
                -- vim.cmd('sunmap s')
            end,
        }
        -- }}}3
        -- {{{3 Better whitespace
        use {
            'ntpeters/vim-better-whitespace',
            config = function()
                vim.g.strip_whitespace_on_save = 1
                vim.g.better_whitespace_filetypes_blacklist = { 'diff', 'git', 'gitcommit', 'unite',
                'qf', 'help', 'markdown', 'fugitive', 'dashboard', 'terminal' }
            end,
        }
        -- }}}3
        --  {{{3 Terminal
        use {
            "akinsho/toggleterm.nvim",
            event = "BufWinEnter",
            config = function()
                require "toggleterm".setup({
                    hidden = true,
                    open_mapping = [[<c-t>]],
                    direction = "float",
                    shell = vim.o.shell,
                    close_on_exit = true,
                    float_opts = {
                        border = "curved",
                        winblend = 0,
                    },
                })
            end,
        }
        -- }}}3
        -- {{{3 Gitsigns
        use {
            'lewis6991/gitsigns.nvim',
            requires = {
                'nvim-lua/plenary.nvim',
            },
            -- after = 'gruvqueen',
            event = "BufRead",
            config = function()
                require('gitsigns').setup({
                    signs = {
                        add = {
                            hl = "GitSignsAdd",
                            text = "▎",
                            numhl = "GitSignsAddNr",
                            linehl = "GitSignsAddLn",
                        },
                        change = {
                            hl = "GitSignsChange",
                            text = "▎",
                            numhl = "GitSignsChangeNr",
                            linehl = "GitSignsChangeLn",
                        },
                        delete = {
                            hl = "GitSignsDelete",
                            text = "契",
                            numhl = "GitSignsDeleteNr",
                            linehl = "GitSignsDeleteLn",
                        },
                        topdelete = {
                            hl = "GitSignsDelete",
                            text = "契",
                            numhl = "GitSignsDeleteNr",
                            linehl = "GitSignsDeleteLn",
                        },
                        changedelete = {
                            hl = "GitSignsChange",
                            text = "▎",
                            numhl = "GitSignsChangeNr",
                            linehl = "GitSignsChangeLn",
                        },
                    },
                    numhl = false,
                    linehl = false,
                    keymaps = {
                        -- Default keymap options
                        noremap = true,
                        buffer = true,
                    },
                    watch_gitdir = { interval = 1000 },
                    sign_priority = 6,
                    update_debounce = 200,
                    status_formatter = nil, -- Use default
                })
            end,
        }
        -- }}}3
        -- {{{3 Colorizer
        use {
            "norcalli/nvim-colorizer.lua"
        }
        -- }}}3
        -- {{{3 Snippets
        use {
            "L3MON4D3/LuaSnip",
            requires = "rafamadriz/friendly-snippets",
            config = function() require("luasnip/loaders/from_vscode").lazy_load() end,
        }
        -- }}}
        -- {{{3 FixCursorHold
        use {
            "antoinemadec/FixCursorHold.nvim"
        }
        --- }}}
        -- {{{3 Notify
        use {
            "rcarriga/nvim-notify",
            config = function()
                local notify = require("notify")
                notify.setup({
                    -- Animation style (see below for details)
                    stages = "fade_in_slide_out",
                    -- Function called when a new window is opened, use for changing win settings/config
                    on_open = nil,
                    -- Function called when a window is closed
                    on_close = nil,
                    -- Render function for notifications. See notify-render()
                    render = "default",
                    -- Default timeout for notifications
                    timeout = 5000,
                    -- For stages that change opacity this is treated as the highlight behind the window
                    -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
                    background_colour = "#282828",
                    -- Minimum width for notification windows
                    minimum_width = 50,
                    -- Icons for the different levels
                    icons = {
                        ERROR = "",
                        WARN = "",
                        INFO = "",
                        DEBUG = "",
                        TRACE = "✎",
                    },
                })
                vim.notify = notify
            end,
        }
        -- }}}
        -- {{{3 UI helpers
        use {
            'stevearc/dressing.nvim',
            config = function()
                require('dressing').setup({
                    input = {
                        insert_only = false,
                    }
                })
            end,
        }
        -- }}}
    end,
    config = {
        -- {{{3 Packer config
        display = {
            open_fn = function()
                return require('packer.util').float({ border = "single" })
            end        }
            -- }}}3
        },
})
    --- }}}2
-- }}}
-- {{{ Settings
local g = vim.g
local o = vim.o
local wo = vim.wo
local bo = vim.bo
local map = vim.api.nvim_set_keymap

-- {{{2 Autogroups
-- Need to make nvim to recognize .fish files
-- vim.cmd('au! BufRead,BufNewFile *.fish set filetype=fish')
-- Need to setlocal foldmethod=marker for init.lua
-- vim.api.nvim_exec(
-- [[
-- augroup config
-- autocmd!
-- autocmd BufEnter init.lua setlocal foldmethod=marker
-- augroup end
-- ]],
-- false
-- )
-- }}}2
-- {{{2 Set colorsheme
-- }}}2
-- {{{2 Map leaders
map('n', '<Space>', '', {})
map('o', '<Space>', '', {})
g.mapleader = ' '
map('n', '\\', '', {})
g.maplocalleader = '\\'
-- }}}2
-- {{{2 options and variables
-- global options and variables
g.nvim_tree_respect_buf_cwd = 1
g.cursorhold_updatetime = 300
g.bufferline = {
    closable = false,
    clickable = false,
    letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
    icon_separator_active = '▌',
    icon_pinned = '車',
    -- icon_separator_inactive = '▌',
    -- icon_close_tab_modified = '●',
}

o.cmdheight = 2
o.showtabline = 2
o.hidden = true
o.timeoutlen = 300
-- o.updatetime = 300
-- o.swapfile = false
o.termguicolors = true
o.background = 'dark'
o.cursorline = true
o.splitbelow = true
o.splitright = true
o.completeopt = 'menuone,preview,noinsert,noselect'
o.wildmenu = true
o.wildmode = 'longest:full,full'
o.wrap = false
o.ignorecase = true
o.smartcase = true
o.scrolloff = 8
o.sidescrolloff = 8
o.signcolumn = "yes"
o.showmode = false

-- buffer-local options
bo.keymap = 'russian-jcukenwin'
bo.iminsert = 0
bo.imsearch = -1

-- window-local options
wo.number = true
wo.colorcolumn='101'
-- }}}2
--- }}}
-- {{{ Mappings
local options = { noremap = true }

-- {{{2 normal mode maps
map('n', '<C-l>', '<C-w>l', options)
map('n', '<C-h>', '<C-w>h', options)
map('n', '<C-j>', '<C-w>j', options)
map('n', '<C-k>', '<C-w>k', options)
-- }}}2
-- {{{2 insert mode maps
map('i', 'kj', '<Esc>', options)
map('i', 'jk', '<Esc>', options)
map('i', '<F3>', '<C-^>', options)
-- }}}2
-- {{{2 command-line mode maps
map('c', '<F3>', '<C-^>', options)
map('c', '%%', "getcmdtype() == ':' ? expand('%:h').'/' : '%%'", { expr = true })
-- vim.cmd("cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'")
-- }}}2
-- {{{2 terminal mode map
map('t', '<Esc>', '<C-\\><C-n>', options)
-- }}}2
-- }}}

-- vim: foldmethod=marker
