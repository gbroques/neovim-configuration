-- Language Server Protocol Configuration
-- --------------------------------------
require("neodev").setup { -- for Lua Neovim Plugin development

}

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- JavaScript
-- TODO: Should we replace this with typescript.nvim to support tsserver's off-spec features?
--       https://github.com/jose-elias-alvarez/typescript.nvim
--       https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins
lspconfig.tsserver.setup {
  capabilities = capabilities
}

-- Lua
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      workspace = {
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
