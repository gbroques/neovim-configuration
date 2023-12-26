-- UI element to remember keymaps
return {
  {
    'folke/which-key.nvim',
    tag = 'v1.4.3',
    event = 'VeryLazy',
    config = function()
      local wk = require('which-key')
      wk.setup({})
      wk.register({
        d = {
          name = 'debug'
        },
        da = {
          name = 'debug adapters'
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
    end
  }
}
