-- General
-- -------
vim.wo.relativenumber = true

-- Plugins
-- -------
require('plugins')

-- Language Server Protocol
-- ------------------------
-- https://github.com/neovim/nvim-lspconfig/blob/master/README.md#suggested-configuration
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
