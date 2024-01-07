return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
  },
  config = function()
    local lspconfig = require 'lspconfig'

    local custom_init = function(client)
      client.config.flags = client.config.flags or {}
      client.config.flags.allow_incremental_sync = true
    end

    local custom_attach = function(_, bufnr)
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
              return not (string.find(v.uri, 'mock_') or string.find(v.uri, 'mocks_') or string.find(v.uri, 'mock/') or string.find(v.uri, 'mocks/'))
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

    local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
    updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
    updated_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

    -- Completion configuration
    vim.tbl_deep_extend('force', updated_capabilities, require('cmp_nvim_lsp').default_capabilities())
    updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

    updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

    -- Change the Diagnostic symbols in the sign column (gutter).
    local signs = { Error = 'E', Warn = 'W', Hint = 'H', Info = 'I' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    local servers = {
      bashls = true,
      lua_ls = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
        },
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
      },
      html = true,
      tsserver = true,
      cssls = true,
      tailwindcss = {
        filetypes = {
          'templ',
          -- include any other filetypes where you need tailwindcss
        },
        init_options = {
          userLanguages = {
            templ = 'html',
          },
        },
      },
      graphql = {
        filetypes = { 'graphql', 'gql', 'svelte', 'typescriptreact', 'javascriptreact' },
      },
      emmet_ls = {
        filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' },
      },
      pyright = true,
      vimls = true,
      yamlls = true,
      jsonls = true,
      clangd = {
        cmd = {
          'clangd',
          '--background-index',
          '--suggest-missing-includes',
          '--clang-tidy',
          '--header-insertion=iwyu',
        },
        init_options = {
          clangdFileStatus = true,
        },
        filetypes = {
          'c',
        },
      },
      gopls = {
        settings = {
          gopls = {
            codelenses = { test = true },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },

        flags = {
          debounce_text_changes = 200,
        },
      },
      templ = true,
      rust_analyzer = {
        cmd = { 'rustup', 'run', 'nightly', 'rust-analyzer' },
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
            },
          },
        },
      },
      dockerls = true,
      docker_compose_language_service = true,
      marksman = true,
      awk_ls = true,
      zls = true,
      sqlls = true,
      terraformls = true,
    }
    for server, config in pairs(servers) do
      if not config then
        return
      end

      if type(config) ~= 'table' then
        config = {}
      end

      config = vim.tbl_deep_extend('force', {
        on_init = custom_init,
        on_attach = custom_attach,
        capabilities = updated_capabilities,
      }, config)

      lspconfig[server].setup(config)
    end
  end,
}
