return {
  settings = {
    Lua = {
      workspace = {
        -- Disable pop-ups about 3rd parties.
        -- https://github.com/LuaLS/lua-language-server/discussions/1688
        checkThirdParty = false
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
