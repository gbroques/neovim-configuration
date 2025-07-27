local colors_module = require('colors')

return {
  'folke/tokyonight.nvim',
  tag = 'v4.11.0',
  config = function()
    -- Troubleshooting
    -- ===============
    -- To see highlight groups, run :Inspect when cursor is over a symbol.
    -- Source:
    -- https://vi.stackexchange.com/questions/39781/how-to-get-the-highlight-group-of-the-word-under-the-cursor-in-neovim-with-trees
    require('tokyonight').setup({
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
      },
      -- Lighten light colors and darken dark colors for added contrast.
      on_colors = function(colors)
        colors.comment = colors_module.lighten(colors.comment, 0.20)
        -- Lighten unused symbols (DiagnosticUnnecessary)
        colors.terminal_black = colors_module.lighten(colors.terminal_black, 0.30)
        colors.fg = colors_module.lighten(colors.fg, 0.20) -- #d3dcf7
        colors.bg = colors_module.darken(colors.bg, 0.20) -- #1b1d2b
        colors.bg_dark = colors_module.darken(colors.bg_dark, 0.20) -- #181a26
      end,
      on_highlights = function(hl, c)
        hl.LineNr = { fg = c.fg_dark }
        hl.CursorLineNr = { fg = c.fg }
      end
    })

    vim.cmd('colorscheme tokyonight-moon')
  end
}
