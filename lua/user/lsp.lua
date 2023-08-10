---------------------------------------------------------------------
-- Language Server Protocol Configuration
---------------------------------------------------------------------
local null_ls = require('null-ls')
local icons = require('icons')

local eslint_config_path = os.getenv('ESLINT_CONFIG_PATH')

null_ls.setup({
  debug = true,
  sources = {
    -- Pass --debug in extra_args to troubleshoot issues.
    null_ls.builtins.diagnostics.eslint_d.with({
      extra_args = { '--config', eslint_config_path }
    }),
    null_ls.builtins.formatting.eslint_d.with({
      extra_args = { '--config', eslint_config_path }
    }),
  },
})

require('neodev').setup { -- for Lua Neovim Plugin development

}

-- TODO: Configure each LSP client using data-structure like LunarVim
--       https://github.com/LunarVim/nvim-basic-ide/blob/master/lua/user/lsp.lua#L65
local lspconfig = require('lspconfig')
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
-- turn on `window/workDoneProgress` capability
local lsp_spinner = require('lsp_spinner')
lsp_spinner.init_capabilities(client_capabilities)
local capabilities = require('cmp_nvim_lsp').default_capabilities(client_capabilities)
-- Folding
-- Advertise foldingRange client capability to server.
-- Neovim hasn't added foldingRange to default capabilities.
-- https://github.com/kevinhwang91/nvim-ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

lsp_spinner.setup({
  -- add space between spinner and LSP client name
  spinner = { ' -', ' \\', ' |', ' /' },
  -- placeholder displayed in place of the spinner when there is
  -- no activity for a given LSP client
  placeholder = '  ',
})

-- JavaScript
-- TODO: Should we replace this with typescript.nvim to support tsserver's off-spec features?
--       https://github.com/jose-elias-alvarez/typescript.nvim
--       https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    if client.name == 'tsserver' then
      -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
    lsp_spinner.on_attach(client, bufnr)
    -- TODO: Bind keymaps to bufnr.
  end
}

-- Lua
lspconfig.lua_ls.setup {
  capabilities = capabilities,
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
  on_attach = function(client, bufnr)
    lsp_spinner.on_attach(client, bufnr)
  end
}

-- YAML
-- TODO: Get OpenAPI workflow for Neovim working.
-- See plugins.lua. Need a swagger ui previewer.
-- require('lspconfig').yamlls.setup {
--   capabilities = capabilities,
--   settings = {
--     yaml = {
--       schemas = {
--         ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "/*.yaml",
--       },
--     },
--   }
-- }

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
