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
        sql = { 'sql_formatter' },
        sh = { 'shellcheck', 'shfmt' },
        bash = { 'shellcheck', 'shfmt' },
        tf = { 'terraform_fmt' },
      },
      format_on_save = function(bufnr)
        local ignore_filetypes = { 'sql' }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match '/node_modules/' then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true, async = false }
      end,
    }

    vim.api.nvim_create_user_command('Format', function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ['end'] = { args.line2, end_line:len() },
        }
      end
      require('conform').format { async = true, lsp_fallback = true, range = range }
    end, { range = true })

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
