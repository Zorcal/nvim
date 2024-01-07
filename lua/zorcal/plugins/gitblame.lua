return {
  -- See https://github.com/zorcal/gitblame.nvim.
  dir = os.getenv 'HOME' .. '/Projects/gitblame.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local gitblame = require 'gitblame'

    vim.keymap.set('n', '<leader>gb', gitblame.open_buffer, { desc = 'Open Git blame buffer' })
  end,
}
