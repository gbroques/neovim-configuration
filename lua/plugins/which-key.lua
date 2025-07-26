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
        { '<leader>e', icon = { icon = '󰍍', color = 'azure' } },
        { '<leader>g', group = 'git', icon = { icon = '󰊢', color = 'orange' } },
        { '<leader>h', group = 'hunk', icon = { icon = '', color = 'red' } },
        { '<leader>s', icon = { icon = '', color = 'blue' } },
        { '<leader>l', group = 'lsp', icon = { icon = '', color = 'yellow' } },
        { '<leader>p', group = 'pickers', icon = { icon = "", color = "blue" } },
        { '<leader>r', group = 'refactor' },
        { '<leader>u', group = 'ui' },
        { '<leader>w', icon = '' }
      })
    end
  }
}
