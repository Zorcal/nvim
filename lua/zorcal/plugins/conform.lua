return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        javascript = { { 'prettierd', 'prettier' }, 'eslint_d' },
        typescript = { { 'prettierd', 'prettier' }, 'eslint_d' },
        javascriptreact = { { 'prettierd', 'prettier' }, 'eslint_d' },
        typescriptreact = { { 'prettierd', 'prettier' }, 'eslint_d' },
        css = { { 'prettierd', 'prettier' } },
        html = { { 'prettierd', 'prettier' } },
        json = { { 'prettierd', 'prettier' } },
        yaml = { { 'prettierd', 'prettier' } },
        markdown = { { 'prettierd', 'prettier' } },
        graphql = { { 'prettierd', 'prettier' } },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        go = {
          -- See formatter_args below. golines is a wrapper around gofumpt.
          'golines',
          'goimports',
        },
        rust = { 'rustfmt' },
        toml = { 'taplo' },
        -- sql = { 'sql_formatter' },
        sh = { 'shellcheck', 'shfmt' },
        bash = { 'shellcheck', 'shfmt' },
        tf = { 'terraform_fmt' },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    }

    local util = require 'conform.util'
    util.add_formatter_args(require 'conform.formatters.goimports', {
      '-local',
      'github.com/formulatehq',
    })
    util.add_formatter_args(require 'conform.formatters.golines', {
      '--base-formatter',
      'gofumpt',
      '-m',
      '250',
    })
  end,
}
