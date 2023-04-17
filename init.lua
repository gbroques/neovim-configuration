
require('keymaps')
require('options')
require('plugins')
require('user.telescope')
require('user.autopairs')
require('user.completion')

-- theme
-- -----
vim.cmd("colorscheme darkplus")
-- https://github.com/LunarVim/darkplus.nvim/blob/master/lua/darkplus/theme.lua#L303
local c = require('darkplus.palette')

-- override italic to false
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = c.info, bg = 'NONE', bold = true, italic = false, })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = c.folder_blue, bg = 'NONE', bold = true, italic = false, })

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end
local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

-- lualine
require("lualine").setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " " },
      colored = true,
      always_visible = true,
    } },
    lualine_x = { {
      "diff",
      colored = false,
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      cond = hide_in_width,
    }, spaces, "encoding", {
      "filetype",
      icons_enabled = false,
    } },
    lualine_y = { { "location", padding = 1 } },
    lualine_z = { "progress" },
  },
}

-- nvim-tree
require('nvim-tree').setup {
  renderer = {
    -- for Java development
    group_empty = true,
  },
}

-- bufferline
require("bufferline").setup {
  options = {
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
  },
  highlights = { buffer_selected = { italic = false } }
}

-- Language Server Protocol
-- ------------------------
require 'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        -- Disable pop-ups about 3rd parties.
        -- https://github.com/LuaLS/lua-language-server/discussions/1688
        checkThirdParty = false
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
