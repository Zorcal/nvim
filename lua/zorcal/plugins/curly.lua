return {
  dir = '~/Projects/nvim/curly.nvim',
  -- https://github.com/m-demare/attempt.nvim/blob/main/lua/attempt/manager.lua
  config = function()
    require('curly').setup {}
  end,
}
