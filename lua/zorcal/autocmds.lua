local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local zorcal_group = augroup('zorcal', {})
local yank_group = augroup('highlight-yank', {})

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  desc = 'Highlight yank',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 40,
    }
  end,
})

autocmd('VimResized', {
  group = zorcal_group,
  pattern = '*',
  desc = 'Auto equalize splits when Vim is resized',
  command = 'wincmd =',
})

autocmd({ 'BufWritePre' }, {
  group = zorcal_group,
  pattern = '*',
  desc = 'Remove extra whitespace',
  command = [[%s/\s\+$//e]],
})

autocmd({ 'filetype' }, {
    group = zorcal_group,
    pattern = { 'netrw' },
    desc = 'Cosier mappings for netrw',
    callback = function()
        local bind = function(lhs, rhs)
            vim.keymap.set('n', lhs, rhs, { remap = true, buffer = true })
        end

        bind('H', 'u') -- "go back" in history
        bind('h', '-^') -- "go up" a directory
        bind('l', '<CR>:Lexplore<CR>') -- Open file and close Netrw
        bind('.', 'gh') -- toggle dotfiles
        bind('r', 'R') -- Rename file

        -- Useful key maps we didn't bind to anything else.
        -- % Let's you create a new a file in cwd.
        -- d Creates a directory.
        -- D Deletes file or empty directory
        -- mt Assign the "target directory" used by the move and copy commands.
        -- mf Marks a file or directory.
        -- mc Copy the marked files in the target directory.
        -- mm Move the marked files to the target directory.
        -- mx Runs an external command on the marked files.
        -- I to toggle banner
        -- s to change sort mode
    end,
})
