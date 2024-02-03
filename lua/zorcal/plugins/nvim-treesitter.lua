return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require 'nvim-treesitter.configs'

      -- configure treesitter
      treesitter.setup { -- enable syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        ensure_installed = {},
        auto_install = true, -- need the `tree-sitter` CLI installed locally
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<M-n>',
            node_incremental = '<M-n>',
            scope_incremental = '<M-c>',
            node_decremental = '<M-p>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['aa'] = '@parameter..outer', -- 'a' for argument
              ['ia'] = '@parameter..inner',
              ['ac'] = '@comment.outer',
              ['ic'] = '@comment.inner',
              ['as'] = '@class.outer', -- 's' for struct
              ['is'] = '@class.inner',
              ['al'] = '@loop.outer',
              ['il'] = '@loop.inner',
              ['ai'] = '@call.outer', -- 'i' for invocation
              ['ii'] = '@call.inner',
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']f'] = '@function.outer',
              [']a'] = '@parameter.inner',
              [']c'] = '@comment.outer',
              [']s'] = '@class.outer',
              [']l'] = '@loop.outer',
              [']i'] = '@call.inner',
            },
            goto_next_end = {},
            goto_previous_start = {
              ['[f'] = '@function.outer',
              ['[a'] = '@parameter.inner',
              ['[c'] = '@comment.outer',
              ['[s'] = '@struct.outer',
              ['[l'] = '@loop.outer',
              ['[i'] = '@call.inner',
            },
            goto_previous_end = {},
            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            -- Make it even more gradual by adding multiple queries and regex.
            goto_next = {},
            goto_previous = {},
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>za'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>zA'] = '@parameter.inner',
            },
          },
        },
      }

      local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'
      -- vim way: ; goes to the direction you were moving.
      vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
      vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)
      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
      vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
      vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
      vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
    end,
  },
}
