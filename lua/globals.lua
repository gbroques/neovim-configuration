-- Inspired from TJ DeVries' config:
-- https://github.com/tjdevries/config_manager/blob/b1bd25a063326d4a1d35439c2c3af42c465347ab/xdg_config/nvim/lua/tj/globals.lua#L10-L13
-- See 'Neovim Lua Plugin From Scratch':
-- https://youtu.be/n4Lp4cV8YR0?t=2067
-- See also:
-- https://www.reddit.com/r/neovim/comments/yzfpx3/til_you_can_type_lua_code_instead_of_lua/
-- https://www.reddit.com/r/neovim/comments/zhweuc/whats_a_fast_way_to_load_the_output_of_a_command/
--
P = function(value)
  local lines = vim.split(vim.inspect(value), '\n', { plain = true })
  vim.cmd('vnew')
  vim.cmd('set filetype=lua')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.opt_local.modified = false
  return value
end
