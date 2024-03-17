return {
  'ray-x/lsp_signature.nvim',
  config = function()
    require('lsp_signature').setup {}
    vim.keymap.set({ 'n' }, '<leader>K', function()
      require('lsp_signature').toggle_float_win()
    end, { silent = true, noremap = true, desc = 'toggle signature' })
  end,
}
