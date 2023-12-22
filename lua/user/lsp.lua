---------------------------------------------------------------------
-- Language Server Protocol Configuration
---------------------------------------------------------------------
local null_ls = require('null-ls')
local icons = require('icons')

local eslint_config_path = os.getenv('ESLINT_CONFIG_PATH')

null_ls.setup({
  debug = true,
  sources = {
    -- Pass --debug in extra_args to troubleshoot issues.
    null_ls.builtins.diagnostics.eslint_d.with({
      extra_args = { '--config', eslint_config_path }
    }),
    null_ls.builtins.formatting.eslint_d.with({
      extra_args = { '--config', eslint_config_path }
    }),
  },
})

-- Keymaps
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
