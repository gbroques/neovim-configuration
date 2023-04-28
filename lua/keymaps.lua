-- Overview of categorized default Vim keymaps:
-- https://devhints.io/vim

-- TODO: Consider slient remap for commands like (u)ndo / (R)edo
-- which display messages in the last command line.

-- Modes
-- ------------
-- 'n' - Normal
-- 'v' - Visual
-- ------------

-- 'dh' is a convenient escape from Insert mode in Colemak.
require("better_escape").setup { mapping = { "dh" } }

-- Normal --

vim.keymap.set('n', '<leader>w', ':silent update<CR>', { desc = 'Write', silent = true })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Buffers
-- TODO: Should these be more ergonomic? Helix uses gn and gp for next / pervious buffer.
--       Square brackets are a bit of a stretch for such a commonly performed action.
vim.keymap.set("n", "]b", ":bnext<CR>", { desc = 'Next buffer' })
vim.keymap.set("n", "[b", ":bprevious<CR>", { desc = 'Previous buffer' })
vim.keymap.set("n", "<S-q>", "<cmd>bdelete!<CR>", { desc = 'Close buffer' })

-- Diagnostics
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })

-- Clear highlights
vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<CR>", { desc = 'Clear search highlighting' })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Commands' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Diagnostics' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Grep' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help' })
vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = 'Jumplist' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = 'Marks' })
vim.keymap.set('n', '<leader>fp', ':Telescope projects<cr>', { desc = 'Projects' })
vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = 'Quickfix' })
vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = 'Registers' })

-- LSP
-- https://github.com/neovim/nvim-lspconfig/blob/master/README.md#suggested-configuration
-- TODO: Should we pass in buffer number like the following example shows?
-- https://github.com/LunarVim/nvim-basic-ide/blob/3d2b182a3cffe4d3a4490fd6b8b49e8aad023c4a/lua/user/lsp.lua#L19-L48
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto declaration' })
vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = 'Goto implementation' })
vim.keymap.set('n', 'gl', function()
  vim.diagnostic.open_float({
    scope = 'line',
    header = '',
  })
end, { desc = 'Show line diagnostics' })
vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { desc = 'Goto references' })
vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = 'Show signature help' })
vim.keymap.set('n', 'gW', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>')
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Goto t(y)pe definition' })
vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, { desc = 'Actions' })
vim.keymap.set('n', '<leader>lf', function()
  vim.lsp.buf.format { async = true }
end, { desc = 'Format' })
vim.keymap.set('n', '<leader>rn', ':IncRename ', { desc = 'Rename' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover keyword' })

-- UI
vim.keymap.set('n', '<leader>us', function()
  vim.opt.laststatus = vim.o.laststatus == 3 and 0 or 3
end, { desc = 'Toggle statusline' })
vim.keymap.set('n', '<leader>ut', function()
  vim.opt.showtabline = vim.o.showtabline == 2 and 0 or 2
end, { desc = 'Toggle tabline' })
vim.keymap.set('n', '<leader>uw', function()
  vim.wo.wrap = not vim.wo.wrap -- local to window
end, { desc = 'Toggle wrap' })
-- NvimTree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>', { desc = 'Explorer' })

-- Git
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Branches' })
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Commits' })
vim.keymap.set('n', '<leader>gC', builtin.git_bcommits, { desc = 'Commits for buffer' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Status' })

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
