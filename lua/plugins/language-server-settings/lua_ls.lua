return {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          path ~= vim.fn.stdpath('config')
          and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end
  end,
  settings = {
    Lua = {
      version = 'LuaJIT',
      -- Tell the language server how to find Lua modules same way as Neovim
      -- (see `:h lua-module-load`)
      path = {
        'lua/?.lua',
        'lua/?/init.lua'
      },
      workspace = {
        -- Disable pop-ups about 3rd parties.
        -- https://github.com/LuaLS/lua-language-server/discussions/1688
        checkThirdParty = false,
        libary = {
          -- Make the server aware of Neovim runtime files
          vim.env.VIMRUNTIME
        }
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      -- https://github.com/LuaLS/lua-language-server/issues/2214
      diagnostics = {
        disable = { "missing-fields" },
      }
    },
  }
}
