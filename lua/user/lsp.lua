---------------------------------------------------------------------
-- Language Server Protocol Configuration
---------------------------------------------------------------------
local null_ls = require("null-ls")
local icons = require("icons")

null_ls.setup({
  debug = true,
  sources = {
    -- TODO: Switch to eslint_d for performance.
    null_ls.builtins.diagnostics.eslint.with({
      timeout = 10000,
    }),
    -- TODO: Switch to eslint_d for performance.
    null_ls.builtins.formatting.eslint.with({
      timeout = 10000,
      -- extra_args = { '--debug' }
    }),
  },
})

require("neodev").setup { -- for Lua Neovim Plugin development

}

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- JavaScript
-- TODO: Should we replace this with typescript.nvim to support tsserver's off-spec features?
--       https://github.com/jose-elias-alvarez/typescript.nvim
--       https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    if client.name == "tsserver" then
      -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
    -- TODO: Bind keymaps to bufnr.
  end
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

---------------------------------------------------------------------
-- Diagnostics
---------------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = false
})
local function define_diagnostic_sign(name, icon)
  local highlight = 'DiagnosticSign' .. name
  vim.fn.sign_define(
    highlight,
    { text = icon, texthl = highlight }
  )
end
define_diagnostic_sign('Error', icons.diagnostics.error)
define_diagnostic_sign('Hint', icons.diagnostics.hint)
define_diagnostic_sign('Info', icons.diagnostics.info)
define_diagnostic_sign('Warn', icons.diagnostics.warning)

