return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('ts_context_commentstring').setup {}
    vim.g.skip_ts_context_commentstring_module = true
  end,
}
