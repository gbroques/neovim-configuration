
require('keymaps')
require('options')
require('plugins')
require('user.telescope')
require('user.autopairs')
require('user.completion')
require('user.colorscheme')
require('user.statusline')
require('user.explorer')
require('user.tabline')

-- Language Server Protocol
-- ------------------------
require 'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        -- Disable pop-ups about 3rd parties.
        -- https://github.com/LuaLS/lua-language-server/discussions/1688
        checkThirdParty = false
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
