-- UI element to remember keymaps
return {
  {
    'folke/which-key.nvim',
    tag = 'v3.17.0',
    event = 'VeryLazy',
    triggers = {
      { '<leader>', mode = { 'n', 'v' } },
    },
    win = {
      -- Show all the mappings without scrolling
      height = { min = 4, max = 999 },
    },
    config = function()
      local wk = require('which-key')
      wk.add({
        { '<leader>d', group = 'debug' },
        { '<leader>da', group = 'debug adapters' },
        { '<leader>g', group = 'git' },
        { '<leader>h', group = 'hunk' },
        { '<leader>l', group = 'lsp' },
        { '<leader>p', group = 'pickers' },
        { '<leader>r', group = 'refactor' },
        { '<leader>u', group = 'ui' },
      })
    end
  }
}
