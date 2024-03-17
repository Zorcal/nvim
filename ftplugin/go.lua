local vo = vim.opt_local
vo.tabstop = 4
vo.shiftwidth = 4
vo.softtabstop = 4
vo.expandtab = false

vim.keymap.set('n', '<leader>xt', function()
  require('dap-go').debug_test()
end, { desc = 'Debug closest test' })

vim.cmd 'Copilot disable'
