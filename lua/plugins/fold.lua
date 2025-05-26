return {
  {
    'kevinhwang91/nvim-ufo',
    commit = '3c7a3570e9c9dc198a2ad4491b0b0e51c4d4ba08',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'kevinhwang91/promise-async',
        commit = '119e8961014c9bfaf1487bf3c2a393d254f337e2'
      }
    },
    config = function()
      vim.o.foldcolumn = '0'
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      local ufo = require('ufo')
      ufo.setup()

      -- Keymaps
      vim.keymap.set('n', 'zR', ufo.openAllFolds)
      vim.keymap.set('n', 'zM', ufo.closeAllFolds)
    end
  },
}
