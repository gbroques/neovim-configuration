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
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        ["af"] = { query = "@function.outer", desc = 'a function' },
        ["if"] = { query = "@function.inner", desc = "inner function" },
        ["ac"] = { query = "@class.outer", desc = "a class" },
        ["ic"] = { query = "@class.inner", desc = "inner class" },
        ["aa"] = { query = "@parameter.outer", desc = "an argument" },
        ["ia"] = { query = "@parameter.inner", desc = "inner argument" },
        ["as"] = { query = "@scope", query_group = "locals", desc = "a scope" },
      },
    },
  },
  rainbow = {
    enable = true
  }
}
-- TODO: Renable folding once telescope bug is fixed.
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/1337#issuecomment-864442660
-- https://github.com/nvim-treesitter/nvim-treesitter#folding
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
