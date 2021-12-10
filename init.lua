-- {{{ Plugins
-- {{{2 Install packer
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
--- }}}2
-- {{{2 Plugins load and setup
local use = require('packer').use
require('packer').startup({
    function()
        -- {{{3 Package manager
        use 'wbthomason/packer.nvim'
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
                        -- description = { "  Find File          " },
                        description = { "  Find File" },
                        command = "Telescope find_files",
                    },
                    b = {
                        -- description = { "  New File           " },
                        description = { "  New File" },
                        command = ":ene!",
                    },
                    c = {
                        -- description = { "  Recent Projects    " },
                        description = { "  Recent Projects" },
                        command = "Telescope projects",
                    },
                    d = {
                        -- description = { "  Recently Used Files" },
                        description = { "  Recently Used Files" },
                        command = "Telescope oldfiles",
                    },
                    e = {
                        -- description = { "  Find Word          " },
                        description = { "  Find Word" },
                        command = "Telescope live_grep",
                    },
                    f = {
                        -- description = { "  Configuration      " },
                        description = { "  Configuration" },
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
                'nvim-telescope/telescope-dap.nvim',
                'nvim-telescope/telescope-project.nvim',
            },
            config = function()
                require('telescope')
                require('telescope').load_extension('dap')
                require('telescope').load_extension('project')
                require('telescope').load_extension('projects')
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
        -- {{{3 Colorschemes
        use {
            'sainnhe/gruvbox-material',
            config = function()
                vim.g.gruvbox_material_palette='mix'
                vim.g.gruvbox_material_background='medium'
                vim.g.gruvbox_material_enable_bold=1
                vim.g.gruvbox_material_enable_italic=1
            end,
        }
        use {
            'idmitryd/gruvqueen',
            config = function()
                local c = require("gruvqueen/palette").get_dark_theme_palette().common
                -- local common = {
                --     none =             "NONE",
                --     bg0 =              "#10151a",
                --     bg1 =              "#282828",
                --     bg2 =              "#282828",
                --     bg3 =              "#3c3836",
                --     bg4 =              "#3c3836",
                --     bg5 =              "#504945",
                --     bg_statusline1 =   "#282828",
                --     bg_statusline2 =   "#32302f",
                --     bg_statusline3 =   "#504945",
                --     bg_diff_green =    "#32361a",
                --     bg_visual_green =  "#333e34",
                --     bg_diff_red =      "#3c1f1e",
                --     bg_visual_red =    "#442e2d",
                --     bg_visual_aqua =   '#253a1f',
                --     bg_diff_blue =     "#0d3138",
                --     bg_visual_blue =   "#2e3b3b",
                --     bg_visual_yellow = "#473c29",
                --     bg_visual_aqua =   "#253a1f"
                --     bg_current_word =  "#32302f",
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
                    config = {
                        disable_bold = false,
                        italic_comments = true,
                        -- italic_keywords = true,
                        -- italic_functions = true,
                        -- italic_variables = true,
                        bg_color = c.bg1,
                        style = 'mix',
                        invert_selection = false,
                    },
                    base = {
                        LineNr = { fg = c.grey1, }, -- #928374
                        ColorColumn = { bg = c.bg_statusline2, }, -- #32302f
                        CursorLine = { bg = c.bg_statusline2, }, -- #32302f
                        StatusLine = { fg = "#e2cca9", bg = c.bg_statusline2, },
                        Pmenu = { fg = "#e2cca9", bg = "#45403d", },
                        CursorLineNr = { fg = "#e2cca9", },
                        FloatBorder = { fg = "#928374", bg = "#282828", },
                        -- NormalFloat = {},
                    },
                    plugins = {
                        -- BarBar
                        BufferCurrent = { fg = "#e2cca9", bg = "#5a524c", },
                        BufferCurrentIndex = { fg = "#e2cca9", bg = "#5a524c", },
                        BufferCurrentMod = { fg = "#80aa9e", bg = "#5a524c", },
                        BufferCurrentSign = { fg = "#a89984", bg = "#5a524c"},
                        BufferCurrentTarget = { fg = "#f2594b", bg = "#5a524c", style = "bold", },
                        BufferVisible = { fg = "#e2cca9", bg = "#45403d", },
                        BufferVisibleIndex = { fg = "#e2cca9", bg = "#45403d", },
                        BufferVisibleMod = { fg = "#80aa9e", bg = "#45403d", },
                        BufferVisibleSign = { fg = "#a89984", bg = "#45403d", },
                        BufferVisibleTarget = { fg = "#e9b143", bg = "#45403d", style = "bold", },
                        BufferInactive = { fg = "#928374", bg = "#45403d", },
                        BufferInactiveIndex = { fg = "#928374", bg = "#45403d", },
                        BufferInactiveMod = { fg = "#928374", bg = "#45403d", },
                        BufferInactiveSign = { fg = "#7c6f64", bg = "#45403d"},
                        BufferInactiveTarget = { fg = "#e9b143", bg = "#45403d", style = "bold"},

                        -- dapui
                        DapUIVariable = { fg = "#e2cca9", bg = "#282828" },
                        DapUIScope = { fg = "#b0b846", },
                        DapUIType = { fg = "#e9b143", },
                        DapUIValue = { fg = "#d3869b", bg = "#282828" },
                        DapUIModifiedValue = { fg = "#8bba7f", style = "bold", },
                        DapUIDecoration = { fg = "#b0b846", },
                        DapUIThread = { fg = "#d3869b", },
                        DapUIStoppedThread = { fg = "#b0b846", },
                        DapUIFrameName = { fg = "#e2cca9", bg = "#282828" },
                        DapUISource = { fg = "#e9b143", },
                        DapUILineNumber = { fg = "#8bba7f", },
                        DapUIFloatBorder = { fg = "#504945", },
                        DapUIWatchesEmpty = { fg = "#f2594b", },
                        DapUIWatchesValue = { fg = "#d3869b", },
                        DapUIWatchesError = { fg = "#f2594b", },
                        DapUIBreakpointsPath = { fg = "#b0b846", },
                        DapUIBreakpointsInfo = { fg = "#d3869b", },
                        DapUIBreakpointsCurrentLine = { fg = "#8bba7f", style = "bold", },
                        DapUIBreakpointsLine = { fg = "#8bba7f", },

                        -- lspsaga
                        LspSagaBorderTitle = { fg = mix.orange },
                        LspSagaHoverBorder = { fg = "#928374", bg = "#282828", },
                        LspSagaRenameBorder = { fg = mix.aqua },
                        LspSagaDefPreviewBorder = { fg = "#928374", bg = "#282828", },
                        LspSagaCodeActionBorder = { fg = mix.green, },
                        LspSagaFinderSelection = { fg = mix.fg0 },
                        LspSagaCodeActionTitle = { fg = mix.orange },
                        LspSagaCodeActionContent = { fg = mix.fg0 },
                        LspSagaSignatureHelpBorder = { fg = "#928374", bg = "#282828", },
                        LspSagaDiagnosticBorder = { fg = mix.fg0 },
                        LspSagaDiagnosticTruncateLine = { fg = mix.fg0 },
                        LspSagaLspFinderBorder = { fg = mix.blue },
                        LspSagaShTruncateLine = { fg = mix.fg0, },
                        LspSagaDocTruncateLine = { fg = mix.fg0, },
                        LspSagaCodeActionTruncateLine = { fg = mix.fg0, },
                    },
                })
            end
        }
        --}}}3
        -- {{{3 Comments
        use {
            'terrortylor/nvim-comment',
            config = function()
                require('nvim_comment').setup({comment_empty = false})
            end,
        }
        -- }}}3
        -- {{{3 Movement
        use {
            "phaazon/hop.nvim",
            event = "BufRead",
            config = function()
                require("hop").setup()
                -- Orange and blue
                vim.api.nvim_command('highlight HopNextKey  guifg=#f28534 gui=bold ctermfg=198 cterm=bold')
                vim.api.nvim_command('highlight HopNextKey1 guifg=#34a1f2 gui=bold ctermfg=45 cterm=bold')
                vim.api.nvim_command('highlight HopNextKey2 guifg=#0f89e4 ctermfg=33')
            end,
        }
        -- }}}3
        -- {{{3 Identation guides
        use {
            "lukas-reineke/indent-blankline.nvim",
            event = "BufRead",
            setup = function()
                vim.g.indentLine_enabled = 1
                vim.g.indent_blankline_char = "▏"
                vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
                vim.g.indent_blankline_buftype_exclude = {"terminal"}
                vim.g.indent_blankline_show_trailing_blankline_indent = false
                vim.g.indent_blankline_show_first_indent_level = false
            end
        }
        -- }}}3
        -- {{{3 LaTeX support
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
        -- {{{3 Status line
        use {
            'hoob3rt/lualine.nvim',
            config = function()
                local window_width_limit = 80
                local conditions = {
                    buffer_not_empty = function()
                        return vim.fn.empty(vim.fn.expand "%:t") ~= 1
                    end,
                    hide_in_width = function()
                        return vim.fn.winwidth(0) > window_width_limit
                    end,
                    }
                    require('lualine').setup{
                    options = {
                        icons_enabled=true,
                        theme='gruvbox-material',
                        section_separators='',
                        component_separators='',
                        disabled_filetypes = {"dashboard", "NvimTree", "Outline"},
                    },
                    sections = {
                        lualine_a = {
                            {
                                function() return " " end,
                                padding = { left = 0, right = 0 },
                                cond = nil,
                                -- color = {},
                            }
                        },
                        lualine_b = {
                            {
                                'branch',
                                cond = conditions.hide_in_width,
                            },
                            {
                                'filename',
                                cond = nil
                            }
                        },
                        lualine_c = {
                            {
                                'diff',
                                symbols = { added = "  ", modified = "柳", removed = " " },
                                cond = nil
                            },
                        },
                        lualine_x = {
                            {
                                'diagnostics',
                                sources = {'nvim_diagnostic'},
                                symbols = { error = " ", warn = " ", info = " ", hint = " " },
                                cond = conditions.hide_in_width,
                            },
                            {
                                function()
                                    local b = vim.api.nvim_get_current_buf()
                                    if next(vim.treesitter.highlighter.active[b]) then
                                        return "  "
                                    end
                                    return ""
                                end,
                                color = { fg = '#98be65' },
                                cond = conditions.hide_in_width,
                            },
                            {
                                function()
                                    local msg = 'LSP Incative'
                                    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                                    local clients = vim.lsp.get_active_clients()
                                    if next(clients) == nil then
                                        return msg
                                    end
                                    for _, client in ipairs(clients) do
                                        local filetypes = client.config.filetypes
                                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                            return client.name
                                        end
                                    end
                                    return msg
                                end,
                                icon = ' ',
                                cond = conditions.hide_in_width,
                            },
                            {
                                'filetype',
                                cond = conditions.hide_in_width,
                            },
                        },
                        lualine_y = {
                            {
                                'location',
                                cond = nil,
                            }
                        },
                        lualine_z = {
                            {
                                'progress',
                                cond = nil,
                            }
                        },
                    },
                    extensions = {'nvim-tree'},
                }
            end,
        }
        -- }}}3
        -- {{{3 Surrounding
        use {
            "blackcauldron7/surround.nvim",
            config = function()
                require('surround').setup{}
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
vim.cmd('au! BufRead,BufNewFile *.fish set filetype=fish')
-- Need to setlocal foldmethod=marker for init.lua
vim.api.nvim_exec(
[[
augroup mine
autocmd!
autocmd BufEnter init.lua setlocal foldmethod=marker
augroup end
]],
false
)
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
g.bufferline = {
    closable = false,
    clickable = false,
    letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
}
o.cmdheight = 2
o.showtabline = 2
o.hidden = true
o.timeoutlen = 300
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
