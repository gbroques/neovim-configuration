local wk = require('which-key')
wk.setup({})
wk.register({
  d = {
    name = 'debug'
  },
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
  r = {
    name = 'refactor'
  },
  u = {
    name = 'ui'
  }
}, { prefix = '<leader>' })
