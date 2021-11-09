require('telescope')
require('telescope').load_extension('dap')
local map = vim.api.nvim_set_keymap
local options = { noremap = true }
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', options)
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', options)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>',  options)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>',    options)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>',  options)
map('n', '<leader>ft', '<cmd>Telescope treesitter<cr>', options)
