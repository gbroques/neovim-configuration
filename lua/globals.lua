-- From TJ DeVries' config:
-- https://github.com/tjdevries/config_manager/blob/b1bd25a063326d4a1d35439c2c3af42c465347ab/xdg_config/nvim/lua/tj/globals.lua#L10-L13
-- See 'Neovim Lua Plugin From Scratch':
-- https://youtu.be/n4Lp4cV8YR0?t=2067
P = function(value)
  print(vim.inspect(value))
  return value
end

