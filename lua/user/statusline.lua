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
