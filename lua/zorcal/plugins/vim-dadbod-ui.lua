--[[

See ~/.local/share/db_ui/connections.json for saved connections. Example:

[
  {"url": "postgresql://postgres@localhost:5432/mydbname", "name": "local_postgres"},
  {"url": "clickhouse:///", "name": "local_clickhouse"}
]

--]]
return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    vim.keymap.set('n', '<leader>X', '<cmd>DBUIToggle<CR>')
  end,
}
