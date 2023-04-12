-- General
-- -------
-- Set relative line numbers.
vim.wo.relativenumber = true
-- Highlight cursor line.
vim.o.cursorline = true

-- Plugins
-- -------
require('plugins')

-- Theme
-- -----
local onedark = require('onedark')
onedark.setup  {
    style = 'cool', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = true, -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    code_style = {
        comments = 'none'
    },
    colors = {
        -- Override grey with tint for lighter line numbers.
        -- https://github.com/navarasu/onedark.nvim/blob/932a86846d51f3d39a99f7e4d0c0ec34d4e404d3/lua/onedark/palette.lua#L75
        -- https://www.color-hex.com/color/546178
        grey = "#8790A0",
        -- Override bg1 with shade for darker cursor line.
        -- https://github.com/navarasu/onedark.nvim/blob/932a86846d51f3d39a99f7e4d0c0ec34d4e404d3/lua/onedark/palette.lua#L61
        -- https://www.color-hex.com/color/2d3343
        bg1 = '#242835',
        -- Override foreground with tint.
        -- https://github.com/navarasu/onedark.nvim/blob/932a86846d51f3d39a99f7e4d0c0ec34d4e404d3/lua/onedark/palette.lua#L67
        -- https://www.color-hex.com/color/a5b0c5
        fg = '#b7bfd0'
    }
}
onedark.load()

require('lualine').setup {
    options = {
      theme = 'onedark'
    }
  }

-- Language Server Protocol
-- ------------------------
-- https://github.com/neovim/nvim-lspconfig/blob/master/README.md#suggested-configuration
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
