require('nvim-treesitter.configs').setup {
	ensure_installed = { "bash", "fish", "latex", "cpp", "python",
                        "cmake", "bibtex", "yaml", "lua" },
	highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
    },
    indent = {
        enable = true,
    },
}
require('nvim-treesitter-textobjects')
-- vim.api.nvim_exec([[
--     set foldmethod=expr
--     set foldexpr=nvim_treesitter#foldexpr()
--     set foldminlines=5
--     set foldnestmax=3
-- ]], true)
