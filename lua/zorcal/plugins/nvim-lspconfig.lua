return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
  },
  config = function()
    local lspconfig = require 'lspconfig'

    local on_attach = function(_, bufnr)
      local opts = function(desc)
        return {
          buffer = bufnr,
          remap = false,
          desc = desc,
        }
      end

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts 'Go to definition')
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts 'Rename')
      vim.keymap.set('n', '<leader>i', vim.diagnostic.open_float, opts 'Hover diagnostics')
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts 'Set location list')
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts 'Go to references')
      vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts 'Code actions')
      vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts 'Hover')
      vim.keymap.set('n', '<leader>s', '<cmd>Telescope lsp_document_symbols<CR>', opts 'File symbols')
      vim.keymap.set('n', '<leader>d', '<cmd>Telescope diagnostics bufnr=0 sort_by=severity<CR>', opts 'File diagnostics')
      vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics sort_by=severity<CR>', opts 'Project diagnostics')
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts 'Next diagnostic')
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts 'Previous diagnostic')
      vim.keymap.set('n', 'gi', function()
        local params = vim.lsp.util.make_position_params()
        vim.lsp.buf_request(0, 'textDocument/implementation', params, function(err, result, ctx, config)
          if result == nil then
            return
          end

          local ft = vim.api.nvim_buf_get_option(ctx.bufnr, 'filetype')

          -- In Go code, I do not like to see any mocks for impls...
          if ft == 'go' then
            local new_result = vim.tbl_filter(function(v)
              return not (string.find(v.uri, 'mock_') or string.find(v.uri, 'mock/') or string.find(v.uri, 'mocks/'))
            end, result)
            if #new_result > 0 then
              result = new_result
            end
          end

          vim.lsp.handlers['textDocument/implementation'](err, result, ctx, config)
          vim.cmd [[normal! zz]]
        end)
      end, opts 'Go to implementation')
    end

    -- Used to enable autocompletion (assign to every lsp server config).
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter).
    local signs = { Error = 'E', Warn = 'W', Hint = 'H', Info = 'I' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    lspconfig['html'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['tsserver'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['cssls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['tailwindcss'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['graphql'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { 'graphql', 'gql', 'svelte', 'typescriptreact', 'javascriptreact' },
    }

    lspconfig['emmet_ls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' },
    }

    lspconfig['pyright'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- golangci_lint_ls?
    lspconfig['gopls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['bashls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['clangd'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['dockerls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['docker_compose_language_service'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['marksman'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['awk_ls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['jsonls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['yamlls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['rust_analyzer'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['zls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['sqlls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['terraformls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['lua_ls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = {
              [vim.fn.expand '$VIMRUNTIME/lua'] = true,
              [vim.fn.stdpath 'config' .. '/lua'] = true,
            },
          },
        },
      },
    }
  end,
}
