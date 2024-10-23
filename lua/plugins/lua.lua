return {
  -- Debug Adapter
  {
    'jbyuki/one-small-step-for-vimkind',
    commit = 'ad065ad2c814249cfb9e344ce5b2b35d36fbc09f',
    ft = { 'lua', 'vim' },
    dependencies = {
      'mfussenegger/nvim-dap'
    },
    config = function()
      local osv = require('osv')
      local dap = require('dap')
      dap.configurations.lua = {
        {
          type = 'nlua',
          request = 'attach',
          name = 'Attach to running Neovim instance',
        }
      }

      dap.adapters.nlua = function(callback, config)
        callback({ type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 })
      end

      vim.keymap.set('n', '<leader>dal', osv.run_this, { desc = 'Debug lua' })
    end
  },
  -- Lua 5.1 Reference Manual converted to Vim help docs
  -- https://www.lua.org/manual/5.1/manual.html
  {
    'milisims/nvim-luaref',
    commit = '9cd3ed50d5752ffd56d88dd9e395ddd3dc2c7127'
  },
}
