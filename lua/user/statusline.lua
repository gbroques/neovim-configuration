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
        -- icons duplicated in explorer
        symbols = { error = " ", warn = " " },
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
