---------------------------------------------------------------------
-- Diagnostics
---------------------------------------------------------------------
local icons = require('icons')
-- TODO: Consider https://github.com/folke/trouble.nvim to view diagnostics for LSP workspace
vim.diagnostic.config({
  virtual_text = { current_line = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.info,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.warning,
    }
  }
})
