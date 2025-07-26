-- Copied from https://github.com/folke/tokyonight.nvim/blob/v4.11.0/lua/tokyonight/util.lua#L3-L51
-- TODO: extract to common module for statusline.lua
---@param c  string
local function rgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---@param foreground string foreground color
---@param background string background color
---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
local function blend(foreground, alpha, background)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = rgb(background)
  local fg = rgb(foreground)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

local function darken(hex, amount)
  return blend(hex, 1 - amount, '#000000')
end

local function lighten(hex, amount)
  return blend(hex, 1 - amount, '#FFFFFF')
end

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
        colors.comment = lighten(colors.comment, 0.20)
        -- Lighten unused symbols (DiagnosticUnnecessary)
        colors.terminal_black = lighten(colors.terminal_black, 0.30)
        colors.fg = lighten(colors.fg, 0.20) -- #d3dcf7
        colors.bg = darken(colors.bg, 0.20) -- #1b1d2b
        colors.bg_dark = darken(colors.bg_dark, 0.20) -- #181a26
      end,
      on_highlights = function(hl, c)
        hl.LineNr = { fg = c.fg_dark }
        hl.CursorLineNr = { fg = c.fg }
      end
    })

    vim.cmd('colorscheme tokyonight-moon')
  end
}
