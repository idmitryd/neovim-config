vim.cmd("setlocal shiftwidth=2 tabstop=2 expandtab")
vim.cmd("setlocal commentstring=//\\ %s")

-- Need to set specific indentation for GNA project
if string.find(vim.api.nvim_buf_get_name(0), 'gna') then
    vim.cmd("setlocal shiftwidth=4 tabstop=4 expandtab")
end

local dap = require'dap'
dap.adapters.lldb = {
  type = 'executable',
  attach = {
      pidProperty = "pid",
      pidSelect = "ask",
  },
  command = '/usr/bin/lldb-vscode-12', -- adjust as needed
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
  },
  name = "lldb",
}
dap.set_log_level('DEBUG')

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    args = {},
    stopOnEntry = false,
    runInTerminal = false,
  },
}

dap.configurations.c = dap.configurations.cpp
