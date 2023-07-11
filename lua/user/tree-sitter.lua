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
  playground = {
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
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = { query = "@function.outer", desc = "Next method start" },
        ["]]"] = { query = "@class.outer", desc = "Next class start" },
      },
      goto_next_end = {
        ["]M"] = { query = "@function.outer", desc = "Next method end" },
        ["]["] = { query = "@class.outer", desc = "Next class end" },
      },
      goto_previous_start = {
        ["[m"] = { query = "@function.outer", desc = "Previous method start" },
        ["[["] = { query = "@class.outer", desc = "Previous class start" },
      },
      goto_previous_end = {
        ["[M"] = { query = "@function.outer", desc = "Previous method end" },
        ["[]"] = { query = "@class.outer", desc = "Previous class end" },
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>rs"] = { query = "@parameter.inner", desc = "Swap next" },
      },
      swap_previous = {
        ["<leader>rS"] = { query = "@parameter.inner", desc = "Swap previous" },
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
