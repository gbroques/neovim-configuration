---------------------------------------------------------------------
-- Diagnostics
---------------------------------------------------------------------
local icons = require('icons')
vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.info,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.warning,
    }
  }
})
