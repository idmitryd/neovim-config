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

return functions
