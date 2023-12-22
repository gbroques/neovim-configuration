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

-- Map Y to y$ for consistency with C and D.
vim.keymap.set('n', 'Y', 'y$')

-- Buffers
-- TODO: Should these be more ergonomic? Helix uses gn and gp for next / pervious buffer.
--       Square brackets are a bit of a stretch for such a commonly performed action.
--       gnn used by treesitter for incremental selection
vim.keymap.set('n', ']b', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '[b', ':bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<S-q>', '<cmd>bdelete!<CR>', { desc = 'Close buffer' })


-- Clear highlights
vim.keymap.set('n', '<leader>/', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlighting' })

-- Folding
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- Replace currently selected text with default register without yanking it
-- " is blackhole register
vim.keymap.set('v', '<leader>p', '"_dP')

-- LSP
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
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
    vim.keymap.set('n', 'gd', goto_definition, { buffer = ev.buf, desc = 'Goto definition' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = 'Goto declaration' })
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { buffer = ev.buf, desc = 'Goto implementation' })
    vim.keymap.set('n', 'gl', function()
      vim.diagnostic.open_float({
        scope = 'line',
        header = '',
      })
    end, { buffer = ev.buf, desc = 'Show line diagnostics' })
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = 'Show signature help' })
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = 'Goto t(y)pe definition' })
    -- TODO
    -- Consider lspsaga https://nvimdev.github.io/lspsaga/codeaction/
    -- which offers a preview of the code action.
    -- Also consider https://github.com/aznhe21/actions-preview.nvim
    vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, { buffer = ev.buf, desc = 'Actions' })
    vim.keymap.set('n', '<leader>lf', function()
      vim.lsp.buf.format { async = true }
    end, { buffer = ev.buf, desc = 'Format' })
    vim.keymap.set('n', '<leader>rn', function()
      return ':IncRename ' .. vim.fn.expand('<cword>')
    end, { buffer = ev.buf, expr = true, desc = 'Rename' })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = 'Hover keyword' })
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

-- Visual --
-- Stay in indent mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
