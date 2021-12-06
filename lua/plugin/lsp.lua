local run = function()
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
end

local setup = function()
    local nvim_lsp = require('lspconfig')

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      --Enable completion triggered by <c-x><c-o>
      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      local opts = { noremap=true, silent=true }
      buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    end

    local function make_config()
      return {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 250,
        },
      }
    end

    local lsp_installer = require("nvim-lsp-installer")
    lsp_installer.settings({
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗"
            }
        }
    })

    for _, server in pairs(lsp_installer.get_installed_servers()) do
      local config = make_config()
      if server.name == 'clangd' then
        config.filetypes = { 'c', 'cpp', }
        config.cmd = server:get_default_options().cmd
        config.cmd[1] = config.cmd[1] .. "_13.0.0/bin/clangd"
        table.insert(config.cmd, "--fallback-style=Google")
        table.insert(config.cmd, "--background-index")
      end
      if server.name == 'sumneko_lua' then
          config.settings = {
              Lua = {
                  diagnostics = {
                      globals = { 'vim' },
                  },
              },
          }
      end
      server:setup(config)
    end

    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
    vim.diagnostic.config({
        virtual_text = false,
        -- update_in_insert = true,
        -- float = { border='single', },
    })
    vim.lsp.set_log_level 'trace'
end

return {
    setup = setup,
    run = run
}
