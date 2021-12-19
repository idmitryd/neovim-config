local breakpoint = {
    text = "",
    texthl = "DiagnosticError",
    linehl = "",
    numhl = "",
}

local breakpoint_rejected = {
    text = "",
    texthl = "DiagnosticHint",
    linehl = "",
    numhl = "",
}

local stopped = {
    text = "",
    texthl = "DiagnosticInfo",
    linehl = "",
    numhl = "DiagnosticInfo",
}

local setup = function()
    local dap = require('dap')

    vim.fn.sign_define("DapBreakpoint", breakpoint)
    vim.fn.sign_define("DapBreakpointRejected", breakpoint_rejected)
    vim.fn.sign_define("DapStopped", stopped)

    dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

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

--     dap.configurations.cpp = {
--       {
--         name = "Launch",
--         type = "lldb",
--         request = "launch",
--         program = function()
--           return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--         end,
--         cwd = '${workspaceFolder}',
--         stopOnEntry = true,
--         args = {},
--         runInTerminal = false,
--         env = function()
--           local variables = {}
--           for k, v in pairs(vim.fn.environ()) do
--             table.insert(variables, string.format("%s=%s", k, v))
--           end
--           return variables
--         end,
--       },
--     }

--     dap.configurations.c = dap.configurations.cpp

end

return {
    setup = setup
}
