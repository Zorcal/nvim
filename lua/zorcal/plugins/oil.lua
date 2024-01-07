return {
  'stevearc/oil.nvim',
  opts = {},
  config = function()
    require('oil').setup {}
    vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
