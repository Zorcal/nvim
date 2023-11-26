vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.textwidth = 0

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.local/state/nvim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'

-- Treat special characters as words so that we can jump to them with w and b.
vim.opt.iskeyword:append '?'
vim.opt.iskeyword:append '&'
vim.opt.iskeyword:append '!'

vim.opt.updatetime = 50

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.cmd [[ set nofoldenable foldmethod=manual foldlevelstart=99 ]]

-- .templ files not recognized with my current version.
vim.filetype.add {
  extension = {
    templ = 'templ',
  },
}
