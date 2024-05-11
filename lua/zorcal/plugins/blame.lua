return {
  'FabijanZulj/blame.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('blame').setup()

    vim.keymap.set('n', '<leader>gb', '<cmd>BlameToggle window<CR>', { desc = 'Toggle Git blame' })
  end,
}
