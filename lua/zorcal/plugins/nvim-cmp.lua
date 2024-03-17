return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
  },
  config = function()
    local cmp = require 'cmp'

    local luasnip = require 'luasnip'

    -- loads vscode style snippets
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_vscode').lazy_load { paths = { './snippets' } }

    local compare = cmp.config.compare

    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup {
      completion = {
        completeopt = 'menu,menuone,preview,noselect',
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = nil,
        ['<S-Tab>'] = nil,
      },
      -- sources for autocompletion
      sources = cmp.config.sources {
        { name = 'nvim_lsp', priority = 4 },
        { name = 'luasnip', priority = 3 }, -- snippets
        { name = 'buffer', priority = 2 }, -- text within current buffer
        { name = 'path', priority = 1 }, -- file system paths
      },
      sorting = {
        priority_weight = 1.0,
        comparators = {
          compare.order,
          compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
          compare.locality,
          compare.recently_used,
          compare.offset,
        },
      },
    }
  end,
}
