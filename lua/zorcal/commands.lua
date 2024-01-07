local toggle = require 'zorcal.funcs.toggle'

vim.api.nvim_create_user_command('ToggleRelativeNumber', toggle.relativenumber, { nargs = 0 })
vim.api.nvim_create_user_command('ToggleBackground', toggle.background, { nargs = 0 })
