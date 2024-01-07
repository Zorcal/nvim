return {
  'Shatur/neovim-ayu',
  config = function()
    local colors = require 'ayu.colors'
    colors.generate() -- Pass `true` to enable mirage

    require('ayu').setup {
      overrides = function()
        -- (`bg`, `fg`, `sp` and `style`) and colors in hex.
        return {
          -- Disable italic for comments:
          Comment = { fg = colors.comment },
          -- Transparent:
          Normal = { bg = 'None' },
          ColorColumn = { bg = 'None' },
          SignColumn = { bg = 'None' },
          Folded = { bg = 'None' },
          FoldColumn = { bg = 'None' },
          CursorLine = { bg = 'None' },
          CursorColumn = { bg = 'None' },
          WhichKeyFloat = { bg = 'None' },
          VertSplit = { bg = 'None' },
        }
      end,
    }

    vim.cmd [[ colorscheme ayu-dark ]]
    vim.cmd [[ highlight LineNr guifg=white ]]
  end,
}
