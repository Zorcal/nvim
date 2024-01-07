return {
  'tpope/vim-fugitive',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git blame' })
    vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit!<CR>', { desc = 'Git diff split' })
    vim.keymap.set('n', '<leader>gs', ':G<CR>', { desc = 'Git status' })
  end,
}
