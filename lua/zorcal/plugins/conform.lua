return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        go = { 'gofumpt', 'goimports' },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    }

    -- Add -local argument to goimports.
    local modname = require('zorcal.lsp.go').module_name()
    if modname ~= nil then
      if modname:find('github.com/formulatehq', 1, true) == 1 then
        modname = 'github.com/formulatehq'
      end
      local util = require 'conform.util'
      util.add_formatter_args(require 'conform.formatters.goimports', { '-local', modname })
    end
  end,
}
