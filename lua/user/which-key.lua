local wk = require('which-key')
wk.setup({})
wk.register({
  f = {
    name = 'find',
  },
  g = {
    name = 'git'
  },
  h = {
    name = 'hunk'
  },
  l = {
    name = 'lsp'
  },
  u = {
    name = 'ui'
  }
}, { prefix = '<leader>' })
