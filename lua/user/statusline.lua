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
      {
        "filename",
        path = 3,                -- 3: Absolute path, with tilde as the home directory
        shorting_target = 10,    -- Shortens path to leave 10 spaces in the window
        symbols = {
          modified = '●',      -- Text to show when the file is modified.
          readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
          newfile = '[New]',     -- Text to show for newly created file before first write
        }
      },
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
    lualine_x = { "branch" },
    lualine_y = {
      {
        "filetype",
        icon_only = true,
      },
      { "location", padding = 1 },
    },
    lualine_z = { "progress" },
  },
}
