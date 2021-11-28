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

      -- mappings.
      local opts = { noremap=true, silent=true }

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap("n", "<LocalLeader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      --buf_set_keymap('n', '<LocalLeader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      --buf_set_keymap('n', '<LocalLeader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      --buf_set_keymap('n', '<LocalLeader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      --buf_set_keymap('n', '<LocalLeader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap('n', '<LocalLocalLeader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      buf_set_keymap('n', '<LocalLocalLeader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      --buf_set_keymap('n', '<LocalLeader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
      --buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
      --buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
      --buf_set_keymap('n', '<LocalLeader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    end

    local function make_config()
      return {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        },
        handlers = {
           ['textDocument/publishDiagnostics'] = vim.lsp.with(
             vim.lsp.diagnostic.on_publish_diagnostics, {
               -- Disable virtual_text
               virtual_text = false
             }
           ),
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
        config.filetypes = { 'c', 'cpp' }
        config.cmd = server:get_default_options().cmd
        table.insert(config.cmd, '--fallback-style=google')
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

    local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
    for type, icon in pairs(signs) do
        local hl = "LspDiagnosticsSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

return {
    setup = setup,
    run = run
}
