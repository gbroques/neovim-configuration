require("tokyonight").setup({
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
    functions = {},
    variables = {},
  },
  on_colors = function(colors)
    colors.comment = colors.dark5
  end
})

vim.cmd("colorscheme tokyonight-night")

