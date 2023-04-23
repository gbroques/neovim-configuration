local wk = require('which-key')
wk.setup({})
wk.register({
  f = {
    name = "find",
  },
  l = {
    name = 'lsp'
  },
  u = {
    name = 'ui'
  }
}, { prefix = "<leader>" })
