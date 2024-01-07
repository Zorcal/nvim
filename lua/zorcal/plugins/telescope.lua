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
      defaults = {
        file_ignore_patterns = { '.git/', 'node_modules/', 'vendor/', '.cache/', '.vscode/', '*/tmp/*', 'Cargo.lock', '*pycache', '*.o' },
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

    vim.keymap.set('n', '<leader>b', function()
      require('telescope.builtin').buffers(no_preview_opts())
    end, { desc = 'Search buffers' })

    vim.keymap.set('n', '<leader>/', function()
      require('telescope.builtin').live_grep(git_cwd_opts())
    end, { desc = 'Live grep' })

    vim.keymap.set('n', '<leader>?', builtin.help_tags, { desc = 'Help' })

    vim.keymap.set('n', '<leader>gfb', '<cmd>Telescope git_branches<CR>', { desc = 'Checkout git branch' })
    vim.keymap.set('n', '<leader>gfc', '<cmd>Telescope git_commits<CR>', { desc = 'Checkout git commit' })
    vim.keymap.set('n', '<leader>gfs', '<cmd>Telescope git_stash<CR>', { desc = 'Apply git stash' })
  end,
}
