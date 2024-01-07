local qf = require 'zorcal.funcs.qf'
local str = require 'zorcal.funcs.str'

local opts = { noremap = true, silent = true, buffer = true }

vim.keymap.set('n', 'dd', qf.delete_entry, opts)
vim.keymap.set('v', 'd', qf.delete_visual_selection, opts)
vim.keymap.set('n', 'ft', function()
  qf.filter(function(entry)
    local test_file_suffixes = {
      -- Go.
      '_test.go',
      -- JavaScript ecosystem.
      'test.ts',
      'test.js',
      'test.jsx',
      'test.tsx',
      'spec.js',
      'spec.jsx',
      'spec.ts',
      'spec.tsx',
    }

    local testdata_dirs = {
      -- Go
      'testdata/',
      -- JavaScript ecosystem.
      '__tests__/',
      '__snapshots__/',
    }

    local path = entry.text
    return not str.ends_with_any(path, test_file_suffixes) and not str.contains_any(path, testdata_dirs)
  end)
end, opts)
