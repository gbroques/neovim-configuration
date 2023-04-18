local colors = require("tokyonight.colors").setup()

require("scrollbar").setup({
  hide_if_all_visible = true,
  handlers = {
    cursor = true,
    handle = true,
    diagnostic = true,
    gitsigns = true,
  },
  handle = {
    color = colors.dark3,
  },
  marks = {
    Cursor = {
      text = '█',
      color = colors.fg_dark
    },
    Search = { color = colors.orange },
    Error = { color = colors.error },
    Warn = { color = colors.warning },
    Info = { color = colors.info },
    Hint = { color = colors.hint },
    Misc = { color = colors.purple },
    GitAdd = {
      text = '━'
    },
    GitChange = {
      text = '━'
    }
  },
  excluded_filetypes = {
    "prompt",
    "TelescopePrompt",
    "noice",
    "NvimTree"
  },
})
