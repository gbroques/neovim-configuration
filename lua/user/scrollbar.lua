local colors = require("tokyonight.colors").setup()

require("scrollbar").setup({
  hide_if_all_visible = true,
  handlers = {
    cursor = false,
    handle = true,
    diagnostic = true,
    gitsigns = true,
  },
  handle = {
    color = colors.bg_highlight,
  },
  marks = {
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
