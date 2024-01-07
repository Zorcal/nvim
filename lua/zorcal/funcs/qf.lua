local M = {}

local function is_qf_buffer()
  return vim.bo.filetype == 'qf'
end

M.delete_entry = function()
  if not is_qf_buffer() then
    return
  end

  local current = vim.fn.line '.'
  local qflist = vim.fn.getqflist()
  table.remove(qflist, current)
  vim.fn.setqflist(qflist, 'r')
  vim.fn.execute(':' .. tostring(current))
end

M.delete_visual_selection = function()
  if not is_qf_buffer() then
    return
  end

  -- Calculate line range of visual selection.
  local start_row = vim.fn.line '.'
  local end_row = vim.fn.line 'v'
  if start_row > end_row then
    start_row, end_row = end_row, start_row
  end

  -- Remove the visually selected entries from the quickfix list.
  local qflist = vim.fn.getqflist()
  for i = end_row, start_row, -1 do
    table.remove(qflist, i)
  end
  vim.fn.setqflist(qflist, 'r')

  -- Break out of visual selection.
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', false, true, true), 'nx', false)

  -- Go to the start of the visual selection.
  vim.fn.execute(':' .. tostring(start_row))
end

M.filter = function(predicate)
  if not is_qf_buffer() then
    return
  end

  local current = vim.fn.line '.'

  local qf_filtered = {}
  for _, entry in ipairs(vim.fn.getqflist()) do
    if predicate(entry) then
      table.insert(qf_filtered, entry)
    end
  end
  vim.fn.setqflist(qf_filtered, 'r')

  -- Go to the same line as before.
  vim.fn.execute(':' .. tostring(current))
end

return M
