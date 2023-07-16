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
require('better_escape').setup { mapping = { 'dh' } }

-- Normal --

vim.keymap.set('n', '<leader>w', ':silent update<CR>', { desc = 'Write', silent = true })

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

-- Buffers
-- TODO: Should these be more ergonomic? Helix uses gn and gp for next / pervious buffer.
--       Square brackets are a bit of a stretch for such a commonly performed action.
--       gnn used by treesitter for incremental selection
vim.keymap.set('n', ']b', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '[b', ':bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<S-q>', '<cmd>bdelete!<CR>', { desc = 'Close buffer' })

-- Diagnostics
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })

-- Clear highlights
vim.keymap.set('n', '<leader>/', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlighting' })

-- Folding
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- Telescope
local builtin = require('telescope.builtin')
-- TODO Try telescope-frecency
-- nvim-telescope/telescope-frecency.nvim
vim.keymap.set('n', '<leader>f', function()
  -- find_root duplicated in ftplugin/java.lua
  local cwd = require('jdtls.setup').find_root({ 'pom.xml', '.git' })
  builtin.find_files({ cwd = cwd })
end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = 'Commands' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Diagnostics' })
vim.keymap.set('n', '<leader>ss', builtin.live_grep, { desc = 'Search' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help' })
vim.keymap.set('n', '<leader>sj', builtin.jumplist, { desc = 'Jumplist' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = 'Marks' })
vim.keymap.set('n', '<leader>sp', ':Telescope projects<cr>', { desc = 'Projects' })
vim.keymap.set('n', '<leader>sq', builtin.quickfix, { desc = 'Quickfix' })
vim.keymap.set('n', '<leader>sr', builtin.registers, { desc = 'Registers' })

-- LSP
-- https://github.com/neovim/nvim-lspconfig/blob/master/README.md#suggested-configuration
-- TODO: Should we pass in buffer number like the following example shows?
-- https://github.com/LunarVim/nvim-basic-ide/blob/3d2b182a3cffe4d3a4490fd6b8b49e8aad023c4a/lua/user/lsp.lua#L19-L48
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer

-- Center screen after goto definition.
-- References:
-- https://www.reddit.com/r/neovim/comments/r756ur/comment/hmz7nrf/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
-- https://www.reddit.com/r/neovim/comments/11frjpb/comment/jal86gg/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
local lsp_util = require('vim.lsp.util')
local default_definition_handler = require('vim.lsp.handlers')['textDocument/definition']
local handle_definition = function(err, result, ctx, config)
  default_definition_handler(err, result, ctx, config)
  vim.cmd('norm zz')
end
local goto_definition = function()
  local params = lsp_util.make_position_params()
  vim.lsp.buf_request(0, 'textDocument/definition', params, handle_definition)
end
vim.keymap.set('n', 'gd', goto_definition, { desc = 'Goto definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto declaration' })
vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = 'Goto implementation' })
vim.keymap.set('n', 'gl', function()
  vim.diagnostic.open_float({
    scope = 'line',
    header = '',
  })
end, { desc = 'Show line diagnostics' })
-- TODO: Write function that goes to reference automatically if there's only 1,
-- and open Telescope if there's more than 1 reference.
-- https://matrix.to/#/!cxlVvaAjYkBpQTKumW:gitter.im/$XuhOCs-CBTyGDT5cSSrwFvDUVlxbtlSISmztUEbG1Bo?via=matrix.org&via=gitter.im
-- This appears to be a bug, with a neglected / stale PR to fix it:
-- https://github.com/nvim-telescope/telescope.nvim/pull/2281
vim.keymap.set('n', 'gr', function()
  builtin.lsp_references({ include_declaration = false })
end, { desc = 'Goto references' })
vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = 'Show signature help' })
vim.keymap.set('n', 'gW', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>')
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Goto t(y)pe definition' })
vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, { desc = 'Actions' })
vim.keymap.set('n', '<leader>lf', function()
  vim.lsp.buf.format { async = true }
end, { desc = 'Format' })
vim.keymap.set('n', '<leader>rn', function()
  return ':IncRename ' .. vim.fn.expand('<cword>')
end, { expr = true, desc = 'Rename' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover keyword' })

-- UI
-- Inspired by AstroNvim
-- https://astronvim.com/Basic%20Usage/mappings#ui-mappings
-- TODO: us for toggle spell?
local toggle_statusline = function()
  vim.opt.laststatus = vim.o.laststatus == 3 and 0 or 3
  vim.opt.showmode = not vim.o.showmode
end
vim.keymap.set('n', '<leader>us', toggle_statusline, { desc = 'Toggle statusline' })
local gitsigns = require('gitsigns')
vim.keymap.set('n', '<leader>ug', gitsigns.toggle_signs, { desc = 'Toggle gitsigns' })
vim.keymap.set('n', '<leader>ur', function()
  vim.opt.relativenumber = not vim.o.relativenumber
end, { desc = 'Toggle relative line numbers' })
vim.keymap.set('n', '<leader>uw', function()
  vim.wo.wrap = not vim.wo.wrap -- local to window
end, { desc = 'Toggle wrap' })
local toggle_zen_mode = function()
  toggle_statusline()
  gitsigns.toggle_signs()
  vim.cmd('echo') -- clear any text in the last line
end
vim.keymap.set('n', '<leader>uz', toggle_zen_mode, { desc = 'Toggle zen mode' })

-- NvimTree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>', { desc = 'Explorer' })

-- Debugging & DAP
-- Inspired by AstroNvim, LazyVIM, and mfussenegger's config
-- https://astronvim.com/Basic%20Usage/mappings#debugger-mappings
-- https://www.lazyvim.org/keymaps#nvim-dap
-- https://github.com/mfussenegger/dotfiles/blob/833d634251ebf3bf7e9899ed06ac710735d392da/vim/.config/nvim/lua/me/dap.lua#L118-L136
local dap = require('dap')
local dapui = require('dapui')
local osv = require('osv')
vim.keymap.set('n', '<leader>dal', osv.run_this, { desc = 'Debug lua' })
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<leader>dB', function()
  dap.toggle_breakpoint(vim.fn.input('Breakpoint condition: '), nil, nil, true)
end, { desc = 'Toggle conditional breakpoint' })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue (or start) (F5)' })
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debugger: Continue (or start)' })
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step into (F11)' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debugger: Step into' })
vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Step over (F10)' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debugger: Step over' })
vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Step out (F12)' })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debugger: Step out' })
vim.keymap.set('n', '<leader>dr', function()
  dap.repl.toggle({ height = 15 })
end, { desc = 'Toggle DAP repl' })
vim.keymap.set('n', '<leader>ds', dap.terminate, { desc = 'Stop' })
vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Toggle UI' })

vim.keymap.set('n', '<leader>x', '<cmd>source %<CR>', { desc = 'Execute / source file (vim)' })

-- Git
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Branches' })
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Commits' })
vim.keymap.set('n', '<leader>gC', builtin.git_bcommits, { desc = 'Commits for buffer' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Status' })

-- Visual --
-- Stay in indent mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
