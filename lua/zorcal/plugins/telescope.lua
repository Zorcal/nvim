return {
  'nvim-telescope/telescope.nvim',
  -- branch = "0.1.x",
  commit = '2d92125620417fbea82ec30303823e3cd69e90e8', -- supports sort_by for diagnostics
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'

    telescope.setup {
      selection_strategy = 'reset',
      sorting_strategy = 'descending',
      scroll_strategy = 'cycle',
      color_devicons = true,
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      history = {
        path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
        limit = 100,
      },
      pickers = {
        find_files = {
          find_command = vim.fn.executable 'fd' == 1 and {
            'fd',
            '--strip-cwd-prefix',
            '-t',
            'f',
            '-t',
            'l',
            '-H',
            '-E',
            '.git',
            '-E',
            'node_modules',
            '-E',
            'vendor',
            '-E',
            '.cache',
            '-E',
            '.vscode',
            '-E',
            '*/tmp/*',
            '-E',
            'Cargo.lock',
            '-E',
            '*pycache',
            '-E',
            '*.o',
            '-E',
            'package-lock.json',
          } or nil,
        },

        git_branches = {
          mappings = {
            i = {
              ['<C-a>'] = false,
            },
          },
        },

        buffers = {
          sort_lastused = true,
          sort_mru = true,
        },
      },

      extensions = {
        fzy_native = {
          override_generic_sorter = true,
          override_file_sorter = true,
        },

        fzf_writer = {
          use_highlighter = false,
          minimum_grep_characters = 6,
        },
      },
    }

    telescope.load_extension 'fzf'

    local function git_cwd_opts()
      vim.fn.system 'git rev-parse --is-inside-work-tree'
      local is_git_repo = vim.v.shell_error == 0

      local opts = {}
      if is_git_repo then
        local dot_git_path = vim.fn.finddir('.git', '.;')
        opts = {
          cwd = vim.fn.fnamemodify(dot_git_path, ':h'),
        }
      end

      return opts
    end

    local no_preview_opts = function()
      return require('telescope.themes').get_ivy { previewer = false }
    end

    vim.keymap.set('n', '<leader>f', function()
      local opts = vim.tbl_deep_extend('force', no_preview_opts(), git_cwd_opts())
      require('telescope.builtin').find_files(opts)
    end, { desc = 'Find files' })

    vim.keymap.set('n', '<leader>bf', function()
      require('telescope.builtin').buffers(no_preview_opts())
    end, { desc = 'Find open buffers' })

    vim.keymap.set('n', '<leader>gs', function()
      require('telescope.builtin').live_grep(git_cwd_opts())
    end, { desc = 'Live grep' })

    vim.keymap.set('n', '<leader>/', function()
      local opts = vim.tbl_deep_extend('force', git_cwd_opts(), { search = vim.fn.input 'Grep > ' })
      builtin.grep_string(opts)
    end)

    vim.keymap.set('n', '<leader>bs', function()
      require('telescope.builtin').current_buffer_fuzzy_find {}
    end, { desc = 'Search current buffer' })

    vim.keymap.set('n', '<leader>mf', function()
      require('telescope.builtin').marks {}
    end, { desc = 'Search marks' })

    vim.keymap.set('n', '<leader>?', builtin.help_tags, { desc = 'Help' })

    vim.keymap.set('n', '<leader>gfb', '<cmd>Telescope git_branches<CR>', { desc = 'Checkout git branch' })
    vim.keymap.set('n', '<leader>gfc', '<cmd>Telescope git_commits<CR>', { desc = 'Checkout git commit' })
    vim.keymap.set('n', '<leader>gfs', '<cmd>Telescope git_stash<CR>', { desc = 'Apply git stash' })
  end,
}
