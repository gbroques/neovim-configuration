local cmp = require('cmp')
local luasnip = require('luasnip')

-- snippet engine required for JDTLS completions
luasnip.config.setup {}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'buffer',  option = { keyword_length = 5 } }, -- increase from default of 3
    { name = 'path' }
  }),
  -- TODO: Should this be in keymaps?
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
})

-- for friendly snippets
require("luasnip.loaders.from_vscode").lazy_load()

