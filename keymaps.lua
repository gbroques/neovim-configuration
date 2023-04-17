-- Leader Key
-- -----------------
vim.g.mapleader = ' '
---------------------

-- Modes
-- ------------
-- 'n' - Normal
-- 'v' - Visual
-- ------------

-- 'dh' is a convenient escape from Insert mode in Colemak.
require("better_escape").setup { mapping = { "dh" } }

vim.keymap.set('n', '<leader>s', ':update<CR>', { desc = '(s)ave'})

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- LSP
-- https://github.com/neovim/nvim-lspconfig/blob/master/README.md#suggested-configuration
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<cr>")
vim.keymap.set('n', 'gW', "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
vim.keymap.set('n', '<leader>f', function()
  vim.lsp.buf.format { async = true }
end)

-- NvimTree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>', { desc = '(e)xplorer' })
