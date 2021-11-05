local map = vim.api.nvim_set_keymap
local options = { noremap = true }

-- normal mode maps
map('n', '<C-l>', '<C-w>l', options)
map('n', '<C-h>', '<C-w>h', options)
map('n', '<C-j>', '<C-w>j', options)
map('n', '<C-k>', '<C-w>k', options)

-- insert mode maps
map('i', 'kj', '<Esc>', options)
map('i', 'jk', '<Esc>', options)
map('i', '<F3>', '<C-^>', options)

-- command-line mode maps
map('c', '<F3>', '<C-^>', options)
map('c', '%%', "getcmdtype() == ':' ? expand('%:h').'/' : '%%'", { expr = true })
-- vim.cmd("cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'")

-- terminal mode map
map('t', '<Esc>', '<C-\\><C-n>', options)

