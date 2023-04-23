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

-- Save
vim.keymap.set('n', '<leader>s', ':update<CR>', { desc = '(s)ave' })

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

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>")
vim.keymap.set("n", "<S-h>", ":bprevious<CR>")

-- Clear highlights
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>")

-- Close buffers
vim.keymap.set("n", "<S-q>", "<cmd>bdelete!<CR>")

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- LSP
-- https://github.com/neovim/nvim-lspconfig/blob/master/README.md#suggested-configuration
-- TODO: Should we pass in buffer number like the following example shows?
-- https://github.com/LunarVim/nvim-basic-ide/blob/3d2b182a3cffe4d3a4490fd6b8b49e8aad023c4a/lua/user/lsp.lua#L19-L48
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition)
vim.keymap.set("n", "<leader>rn", ":IncRename ")
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<cr>")
vim.keymap.set('n', 'gW', "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
vim.keymap.set('n', '<leader>lf', function()
  vim.lsp.buf.format { async = true }
end)

-- NvimTree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>', { desc = '(e)xplorer' })


-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
