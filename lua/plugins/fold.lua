return {
  {
    'kevinhwang91/nvim-ufo',
    commit = '43e39ec74cd57c45ca9d8229a796750f6083b850',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'kevinhwang91/promise-async',
        commit = 'e94f35161b8c5d4a4ca3b6ff93dd073eb9214c0e'
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
