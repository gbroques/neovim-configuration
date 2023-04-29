-- TODO:
-- Build my own statusline.
-- https://jip.dev/posts/a-simpler-vim-statusline/
-- https://zignar.net/2022/01/21/a-boring-statusline-for-neovim/
-- Ideas of things to include from the above articles:
-- - mode - possibly shortened to 1 or 3 letters.
-- - filename
--   - with containing directories
--   - relative to current working directory
--   - should shorten path based on max length
--   - work with JDT URIs and other buffer names
-- - whether the file is modified or read only
-- - diagnostics - warnings & errors
-- - fileformat & encoding if not unix or utf-8
-- - nvim-dap status - whether there's an active debugging sessios
-- - column number
local icons = require('icons')

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
    lualine_b = {
      -- TODO: Show 3 full length dirs, and shorten the rest; like fish
      -- Example: prompt_pwd --full-length-dirs 3
      "%<%{pathshorten(expand('%:~'))}"
    },
    lualine_c = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = {
          error = icons.diagnostics.error .. ' ',
          warn = icons.diagnostics.warning .. ' '
        },
        colored = true,
        always_visible = false,
      }
    },
    lualine_x = {
      {
        "%m" -- show file modified symbol [+]
      },
      "location"
    },
    lualine_y = {
      {
        "filetype",
        icon_only = true,
        padding = 1
      }
    },
    lualine_z = { { "branch", icons_enabled = false } },
  },
}
