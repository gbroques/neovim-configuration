require("bufferline").setup {
  options = {
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    show_buffer_close_icons = false,
    separator_style = "thin"
  },
  highlights = { buffer_selected = { italic = false } }
}
