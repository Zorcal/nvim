local M = {}

M.relativenumber = function()
  local opt = 'relativenumber'
  local v = vim.api.nvim_get_option_value(opt, {})
  vim.api.nvim_set_option_value(opt, not v, {})
end

M.background = function()
  local opt = 'background'
  local v = vim.api.nvim_get_option_value(opt, {})
  if v == 'dark' then
    vim.api.nvim_set_option_value(opt, 'light', {})
  else
    vim.api.nvim_set_option_value(opt, 'dark', {})
  end
end

return M
