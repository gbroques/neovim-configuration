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
      "%<%{pathshorten(expand('%:~'))}"
    },
    lualine_c = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
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
