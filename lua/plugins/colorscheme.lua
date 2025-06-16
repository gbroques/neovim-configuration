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
      on_colors = function(colors)
        -- https://maketintsandshades.com
        colors.comment = colors.dark5
        -- Brighten unused symbols (DiagnosticUnnecessary)
        colors.terminal_black = colors.dark5
        colors.fg = '#d3dcf7'
        colors.bg = '#1a1b26'
        colors.bg_dark = '#16161e'
      end,
      on_highlights = function(hl, c)
        hl.LineNr = { fg = c.fg_dark }
        hl.CursorLineNr = { fg = c.fg }
      end
    })

    vim.cmd('colorscheme tokyonight-moon')
  end
}
