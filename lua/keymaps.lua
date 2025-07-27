-- Overview of categorized default Vim keymaps:
-- https://devhints.io/vim

-- TODO: Thoughts on a single keymaps module, or defining keymaps
-- for each plugin
-- https://www.reddit.com/r/neovim/comments/13p5m5h/how_do_you_structure_keymappings/
-- https://www.reddit.com/r/neovim/comments/11m3575/howwhere_to_set_plugin_keymaps_with_lazynvim/

-- TODO: Consider slient remap for commands like (u)ndo / (R)edo
-- which display messages in the last command line.

-- Modes
-- ------------
-- 'n' - Normal
-- 'v' - Visual
-- ------------

-- Normal --

vim.keymap.set('n', '<leader>w', ':silent update<CR>', { desc = 'Write', silent = true })
-- Make undo and redo silent
vim.keymap.set('n', 'u', ':silent undo<CR>', { desc = 'Undo', silent = true })
vim.keymap.set('n', '<C-r>', ':silent redo<CR>', { desc = 'Redo', silent = true })

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Resize with arrows
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- Map Y to y$ for consistency with C and D.
vim.keymap.set('n', 'Y', 'y$')

-- Buffers
-- TODO: Should these be more ergonomic? Helix uses gn and gp for next / pervious buffer.
--       Square brackets are a bit of a stretch for such a commonly performed action.
--       gnn used by treesitter for incremental selection
vim.keymap.set('n', '<S-q>', '<cmd>bdelete!<CR>', { desc = 'Close buffer' })
-- Inspired by LazyVim
-- https://www.lazyvim.org/keymaps#general
-- H and L effectively do nothing due to scrolloff option set to 999 in options.lua
vim.keymap.set('n', 'H', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', 'L', '<cmd>bnext<CR>', { desc = 'Next buffer' })

-- Clear highlights
vim.keymap.set('n', '<leader>/', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlighting' })

-- Replace currently selected text with default register without yanking it
-- " is blackhole register
vim.keymap.set('v', '<leader>p', '"_dP')

-- LSP
-- Starting from 0.11, Neovim unconditionally sets global gr* default keymaps.
-- See https://neovim.io/doc/user/lsp.html#_global-defaults
-- We unset these in favor of 'gr' for 'get references' using telescope.
vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'grr')

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(event)
    -- LSP
    -- https://github.com/neovim/nvim-lspconfig/blob/master/README.md#suggested-configuration
    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer

    local set_lsp_keymap = function(mode, lhs, rhs, opts)
      local keymap_opts = vim.tbl_extend('force', { buffer = event.buf }, opts)
      vim.keymap.set(mode, lhs, rhs, keymap_opts)
    end
    set_lsp_keymap('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto definition' })
    set_lsp_keymap('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto declaration' })
    set_lsp_keymap('n', 'gI', vim.lsp.buf.implementation, { desc = 'Goto implementation' })
    set_lsp_keymap('n', 'gl', function()
      vim.diagnostic.open_float({
        scope = 'line',
        header = '',
        source = true
      })
    end, { buffer = event.buf, desc = 'Show line diagnostics' })
    -- gs overlaps with 'go substitute'
    -- set_lsp_keymap('n', 'gs', vim.lsp.buf.signature_help, { desc = 'Show signature help' })
    set_lsp_keymap('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Goto t(y)pe definition' })
    -- TODO
    -- Consider lspsaga https://nvimdev.github.io/lspsaga/codeaction/
    -- which offers a preview of the code action.
    -- Also consider https://github.com/aznhe21/actions-preview.nvim
    set_lsp_keymap({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, { desc = 'Actions' })
    set_lsp_keymap('n', '<leader>lf', function()
      vim.lsp.buf.format { async = true }
    end, { desc = 'Format' })
    set_lsp_keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' });
  end,
})

-- UI
-- Inspired by AstroNvim
-- https://docs.astronvim.com/basic-usage/mappings/
-- TODO: us for toggle spell?
vim.keymap.set('n', '<leader>ur', function()
  vim.opt.relativenumber = not vim.o.relativenumber
end, { desc = 'Toggle relative line numbers' })
vim.keymap.set('n', '<leader>uw', function()
  vim.wo.wrap = not vim.wo.wrap -- local to window
end, { desc = 'Toggle wrap' })

-- NvimTree
-- TODO: Add <leader>ee and <leader>ef for NvimTreeFindFileToggl?
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>', { desc = 'Explorer' })

vim.keymap.set('n', '<leader>x', '<cmd>source %<CR>', { desc = 'Execute / source file (vim)' })

-- Visual --
-- Stay in indent mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

local root_dir = require('jdtls.setup').find_root({ 'pom.xml', '.git' })
-- see :h filename-modifiers for %:p:h
local terminal_start_dir = root_dir ~= nil and root_dir or '%:p:h'
vim.keymap.set('n', '<leader>t', ':edit term://' .. terminal_start_dir .. '//fish<CR>', { desc = 'Terminal' })
