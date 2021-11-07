require('hop').setup()
local map = vim.api.nvim_set_keymap
local options = { noremap = true }
map('n', '<Leader>hc', '<cmd>HopChar1<cr>', options)
map('n', '<Leader>hd', '<cmd>HopChar2<cr>', options)
map('n', '<Leader>hl', '<cmd>HopLineStart<cr>', options)
map('n', '<Leader>hw', '<cmd>HopWord<cr>', options)
map('n', '<Leader>hp', '<cmd>HopPattern<cr>', options)

map('o', '<Leader>hc', '<cmd>HopChar1<cr>', options)
map('o', '<Leader>hd', '<cmd>HopChar2<cr>', options)
map('o', '<Leader>hl', '<cmd>HopLineStart<cr>', options)
map('o', '<Leader>hw', '<cmd>HopWord<cr>', options)
map('o', '<Leader>hp', '<cmd>HopPattern<cr>', options)
