local M = {}

M.relativenumber = function()
  local name = 'relativenumber'
  local v = vim.api.nvim_get_option_value(name, {})
  vim.api.nvim_set_option_value(name, not v, {})
end

M.background = function()
  local name = 'background'
  local v = vim.api.nvim_get_option_value(name, {})
  if v == 'dark' then
    vim.api.nvim_set_option_value(name, 'light', {})
  else
    vim.api.nvim_set_option_value(name, 'dark', {})
  end
end

return M
