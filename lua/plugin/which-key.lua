local config = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ...
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
        spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}
local vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}
-- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
-- see https://neovim.io/doc/user/map.html#:map-cmd
local vmappings = {
    ["/"] = { "<ESC><CMD>lua ___comment_gc(vim.fn.visualmode())<CR>", "Comment" },
}
local mappings = {
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    ["/"] = { "<cmd>lua require('Comment').toggle()<CR>", "Comment" },
    ["c"] = { "<cmd>BufferClose!<CR>", "Close Buffer" },
    ["f"] = { "<cmd>Telescope find_files<CR>", "Find File" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    [";"] = { "<cmd>Dashboard<CR>", "Dashboard" },
    ["P"] = { "<cmd>Telescope projects<CR>", "Projects"},
    b = {
        name = "Buffers",
        j = { "<cmd>BufferPick<cr>", "Jump" },
        f = { "<cmd>Telescope buffers<cr>", "Find" },
        b = { "<cmd>b#<cr>", "Previous" },
        w = { "<cmd>BufferWipeout<cr>", "Wipeout" },
        e = {
            "<cmd>BufferCloseAllButCurrent<cr>",
            "Close all but current",
        },
        h = { "<cmd>BufferCloseBuffersLeft<cr>", "Close all to the left" },
        l = {
            "<cmd>BufferCloseBuffersRight<cr>",
            "Close all to the right",
        },
        D = {
            "<cmd>BufferOrderByDirectory<cr>",
            "Sort by directory",
        },
        L = {
            "<cmd>BufferOrderByLanguage<cr>",
            "Sort by language",
        },
    },
    p = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    g = {
        name = "Git",
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk",
        },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        C = {
            "<cmd>Telescope git_bcommits<cr>",
            "Checkout commit(for current file)",
        },
        d = {
            "<cmd>Gitsigns diffthis HEAD<cr>",
            "Git Diff",
        },
    },
    l = {
        name = "LSP",
        a = { "<cmd>lua require('lvim.core.telescope').code_actions()<cr>", "Code Action" },
        d = {
            "<cmd>Telescope lsp_document_diagnostics<cr>",
            "Document Diagnostics",
        },
        w = {
            "<cmd>Telescope lsp_workspace_diagnostics<cr>",
            "Workspace Diagnostics",
        },
        f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
        j = {
            "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
            "Next Diagnostic",
        },
        k = {
            "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
            "Prev Diagnostic",
        },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        p = {
            name = "Peek",
            d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
            t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
            i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
        },
        q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },
    },
    s = {
        name = "Search",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        t = { "<cmd>Telescope live_grep<cr>", "Text" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
        p = {
            "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
            "Colorscheme with Preview",
        },
    },
    T = {
        name = "Treesitter",
        i = { ":TSConfigInfo<cr>", "Info" },
    },
    t = {
        name = "+Trouble",
        t = { "<cmd>TroubleToggle<cr>", "Toggle"},
        r = { "<cmd>Trouble lsp_references<cr>", "References" },
        f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
        d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Document Diagnostics" },
        q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
        l = { "<cmd>Trouble loclist<cr>", "LocationList" },
        w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
    },
    ["<Space>"] = {
        name = "+Hop",
        w = { "<cmd>HopWord<cr>", "Word"},
        l = { "<cmd>HopLineStart<cr>", "Line Start"},
        c = { "<cmd>HopChar1<cr>", "One Char"},
        d = { "<cmd>HopChar2<cr>", "Two Chars"},
        p = { "<cmd>HopPattern<cr>", "Pattern"},
    },
    d = {
    name = "Debug",
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
    r = { "<cmd>lua require'dap'.repl.toggle(nil, \"10split new\")<cr>", "Toggle Repl" },
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    U = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle UI" },
    s = { "<cmd>lua require('dapui').float_element(\"scopes\", {enter=true})<cr>", "Show Scopes" },
    S = { "<cmd>lua require('dapui').float_element(\"stacks\", {enter=true})<cr>", "Show Stacks" },
    B = { "<cmd>lua require('dapui').float_element(\"breakpoints\", {enter=true})<cr>", "Show Breakpoints" },
    W = { "<cmd>lua require('dapui').float_element(\"watches\", {enter=true})<cr>", "Show Watches" },
    v = { "<cmd>lua require('dapui').eval()<cr>", "Eval Variable" },
    },
}

local setup = function()
    local which_key = require "which-key"
    which_key.setup(config)
    which_key.register(mappings, opts)
    which_key.register(vmappings, vopts)
end

return {
    setup = setup
}
