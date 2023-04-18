-- TODO: Investigate theme / colorscheme support.
--       Does darkplus support scrollbar?
--       Should we switch to folke/tokyonight.nvim?
require("scrollbar").setup({
  handlers = {
    gitsigns = true,     -- Requires gitsigns
  },
})
