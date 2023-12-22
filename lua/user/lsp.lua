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
