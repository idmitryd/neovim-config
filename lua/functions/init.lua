local functions = {}

-- toggle_completion()
vim.b.cmp_toggle_flag = true -- initialize
local normal_buftype = function()
  return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
end
functions.toggle_completion = function()
  local ok, cmp = xpcall(require, debug.traceback, "cmp")
  if ok then
    if vim.b.cmp_toggle_flag==nil then
        vim.b.cmp_toggle_flag = true
    end
    local next_cmp_toggle_flag = not vim.b.cmp_toggle_flag
    if next_cmp_toggle_flag then
      print("completion on")
    else
      print("completion off")
    end
    cmp.setup.buffer({
      enabled = function()
        vim.b.cmp_toggle_flag = next_cmp_toggle_flag
        if next_cmp_toggle_flag then
          return normal_buftype
        else
          return next_cmp_toggle_flag
        end
      end,
    })
  else
    print("completion not available")
  end
end

functions.grep_string_current_buffer = function(word)
    -- require'telescope.builtin'.grep_string({search_dirs = {vim.fn.expand(':%p')}})
    local current_word = word or vim.fn.expand("<cword>")
    local ok, telescope = pcall(require, "telescope.builtin")
    if ok then
        telescope.current_buffer_fuzzy_find()
    end
    -- Add ' to the current non-empty word for exact-match
    if current_word ~= "" then
        current_word = "'" .. current_word
    end
    vim.cmd("normal i" .. current_word .. " ")
    vim.cmd("normal $")
end

functions.find_file = function(file)
    local file_to_search = file or vim.fn.expand("<cword>")
    local ok, telescope = pcall(require, "telescope.builtin")
    if ok then
        telescope.find_files({
            find_command = { "find", "-L", ".", "-name", "*" .. file_to_search .. "*" },
        })
    end
end

return functions
