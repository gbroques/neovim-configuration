local dap = require('dap')

dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = 'Attach to running Neovim instance',
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 })
end

local dapui = require('dapui')
dapui.setup()

local icons = require('icons')

-- Customize breakpoint
-- https://github.com/LunarVim/LunarVim/blob/76040d25ff61400317640347e5d5d551ca8cc2d0/lua/lvim/core/dap.lua#L107C1-L107C1
local breakpoint = {
  text = icons.ui.Breakpoint,
  texthl = 'DiagnosticSignError',
  linehl = '',
  numhl = '',
}
vim.fn.sign_define('DapBreakpoint', breakpoint)

local conditional_breakpoint = {
  text = icons.ui.Breakpoint,
  texthl = 'DiagnosticSignWarn',
  linehl = '',
  numhl = '',
}
vim.fn.sign_define('DapBreakpointCondition', conditional_breakpoint)

-- Open and close dapui automatically.
-- Comment out because DAP UI briefly shows up when running JDTLS tests.
-- dap.listeners.after.event_initialized['dapui_config'] = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated['dapui_config'] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited['dapui_config'] = function()
--   dapui.close()
-- end
