---------------------------------------------------------------------
-- Language Server Protocol Configuration
---------------------------------------------------------------------
local icons = require('icons')

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
