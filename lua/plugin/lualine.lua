local setup = function()
    local get_color = require'lualine.utils.utils'.extract_highlight_colors

    local diff_source = function()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
            return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed
            }
        end
    end

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
            theme='gruvqueen-medium',
            section_separators='',
            -- component_separators='',
            component_separators = '',
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
                    -- 'branch',
                    'b:gitsigns_head',
                    cond = conditions.hide_in_width,
                    -- icon =  '',
                },
                {
                    'filename',
                    cond = nil
                }
            },
            lualine_c = {
                {
                    'diff',
                    diff_color = {
                        added = { fg = get_color('GitSignsAdd', 'fg') },
                        modified = { fg = get_color('GitSignsChange', 'fg') },
                        removed = { fg = get_color('GitSignsDelete', 'fg') },
                    },
                    source = diff_source,
                    symbols = { added = "  ", modified = "柳", removed = " " },
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
                    color = { fg = '#8bba7f' },
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
                },
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
end

return { setup = setup }
