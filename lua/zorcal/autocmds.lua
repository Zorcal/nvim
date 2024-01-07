local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local zorcal_group = augroup('zorcal', {})

autocmd('TextYankPost', {
  group = zorcal_group,
  pattern = '*',
  desc = 'Highlight yank',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 40,
    }
  end,
})

autocmd('VimResized', {
  group = zorcal_group,
  pattern = '*',
  desc = 'Auto equalize splits when Vim is resized',
  command = 'wincmd =',
})

autocmd({ 'BufWritePre' }, {
  group = zorcal_group,
  pattern = '*',
  desc = 'Remove extra whitespace',
  command = [[%s/\s\+$//e]],
})

autocmd({ 'BufRead', 'BufNewFile' }, {
  group = zorcal_group,
  pattern = '*',
  desc = 'Those damn format options...',
  command = [[setlocal formatoptions-=cro]],
})

-- vim-dadbod-completion
vim.cmd [[
  autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
]]
vim.cmd [[
  autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
]]
