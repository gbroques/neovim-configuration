require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
-- TODO: Renable folding once telescope bug is fixed.
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/1337#issuecomment-864442660
-- https://github.com/nvim-treesitter/nvim-treesitter#folding
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

