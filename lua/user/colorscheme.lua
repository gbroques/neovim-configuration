require("tokyonight").setup({
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
    functions = {},
    variables = {},
  },
  -- test
  on_colors = function(colors)
    colors.comment = colors.dark5
    colors.fg = '#d3dcf7'
    colors.bg = "#1a1b26"
    colors.bg_dark = "#16161e"
  end,
  on_highlights = function(hl, c)
    hl.LineNr = { fg = c.fg_dark }
    hl.CursorLineNr = { fg = c.fg }
  end
})

vim.cmd("colorscheme tokyonight-moon")
