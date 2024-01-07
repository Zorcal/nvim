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
        },
        -- ensure these language parsers are installed
        ensure_installed = {
          'go',
          'gomod',
          'gosum',
          'gowork',
          'rust',
          'ron',
          'sql',
          'python',
          'c',
          'cpp',
          'haskell',
          'zig',
          'hcl',
          'terraform',
          'proto',
          'json',
          'javascript',
          'typescript',
          'tsx',
          'yaml',
          'toml',
          'html',
          'css',
          'tsv',
          'csv',
          'xml',
          'markdown',
          'markdown_inline',
          'graphql',
          'bash',
          'lua',
          'vim',
          'dockerfile',
          'gitignore',
          'git_config',
          'git_rebase',
          'gitcommit',
          'diff',
          'ssh_config',
          'sxhkdrc',
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<M-n>',
            node_incremental = '<M-n>',
            scope_incremental = false,
            node_decremental = '<M-p>',
          },
        },
        -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      }
    end,
  },
}
