require("dapui").setup()
local icons = require('icons')

-- https://github.com/LunarVim/LunarVim/blob/76040d25ff61400317640347e5d5d551ca8cc2d0/lua/lvim/core/dap.lua#L107C1-L107C1
local breakpoint = {
  text = icons.ui.Breakpoint,
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
}
vim.fn.sign_define("DapBreakpoint", breakpoint)
