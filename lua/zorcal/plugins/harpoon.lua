return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    vim.keymap.set('n', '<leader>A', mark.add_file, { desc = 'Add bookmark' })
    vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu, { desc = 'Bookmark menu' })

    vim.keymap.set('n', '<leader>1', function()
      ui.nav_file(1)
    end, { desc = 'Go 1st bookmark' })
    vim.keymap.set('n', '<leader>2', function()
      ui.nav_file(2)
    end, { desc = 'Go 2nd bookmark' })
    vim.keymap.set('n', '<leader>3', function()
      ui.nav_file(3)
    end, { desc = 'Go 3rd bookmark' })
    vim.keymap.set('n', '<leader>4', function()
      ui.nav_file(4)
    end, { desc = 'Go 4th bookmark' })
  end,
}
