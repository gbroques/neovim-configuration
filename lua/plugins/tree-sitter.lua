return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- Update installed parsers when upgrading plugin
    commit = '42fc28ba918343ebfd5565147a42a26580579482',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'windwp/nvim-ts-autotag',
        commit = 'a1d526af391f6aebb25a8795cbc05351ed3620b5'
      },
      {
        'HiPhish/rainbow-delimiters.nvim',
        commit = '55ad4fb76ab68460f700599b7449385f0c4e858e'
      },
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        commit = '89ebe73cd2836db80a22d9748999ace0241917a5'
      },
      {
        'JoosepAlviste/nvim-ts-context-commentstring'
      }
      -- TODO: nvim-treesitter/nvim-treesitter-context for easier function navigation
      --       with relative line numbers.
      --       See https://youtu.be/uL9oOZStezw?t=291
    },
    config = function()
      local function ends_with(str, ending)
        return ending == '' or str:sub(- #ending) == ending
      end
      require('nvim-treesitter.configs').setup({
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true },
        autopairs = { enable = true },
        autotag = { enable = true },
        rainbow = { enable = true },
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              ['aa'] = { query = '@parameter.outer', desc = 'an argument' },
              ['ia'] = { query = '@parameter.inner', desc = 'inner argument' },
              ['ac'] = { query = '@class.outer', desc = 'a class' },
              ['ic'] = { query = '@class.inner', desc = 'inner class' },
              ['ad'] = { query = '@conditional.outer', desc = 'a con(d)itional' },
              ['id'] = { query = '@conditional.inner', desc = 'inner con(d)itional' },
              ['af'] = { query = '@function.outer', desc = 'a function' },
              ['if'] = { query = '@function.inner', desc = 'inner function' },
              ['al'] = { query = '@loop.outer', desc = 'a loop' },
              ['il'] = { query = '@loop.inner', desc = 'inner loop' },
            },
            include_surrounding_whitespace = function(table)
              if ends_with(table.query_string, 'outer') then
                return false
              end
              return false
            end
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              -- Override builtin gf 'goto file' as it's more ergonomic than ]m
              ['gf'] = { query = '@function.outer', desc = 'Goto next function' },
              [']]'] = { query = '@class.outer', desc = 'Next class start' },
            },
            goto_next_end = {
              [']M'] = { query = '@function.outer', desc = 'Next method end' },
              [']['] = { query = '@class.outer', desc = 'Next class end' },
            },
            goto_previous_start = {
              -- Override builtin gF 'goto file' as it's more ergonomic than [m
              ['gF'] = { query = '@function.outer', desc = 'Goto previous function' },
              ['[['] = { query = '@class.outer', desc = 'Previous class start' },
            },
            goto_previous_end = {
              ['[M'] = { query = '@function.outer', desc = 'Previous method end' },
              ['[]'] = { query = '@class.outer', desc = 'Previous class end' },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>rs'] = { query = '@parameter.inner', desc = 'Swap next' },
            },
            swap_previous = {
              ['<leader>rS'] = { query = '@parameter.inner', desc = 'Swap previous' },
            },
          },
        }
      })
      local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')
      -- Repeat movement with ; and ,
      -- ensure ; goes forward and , goes backward regardless of the last direction
      vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
      vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)
      -- These override default ; and , behavior for builtin f, F, t, and T.
      -- The following mappings break with operator pending mode (e.g. press ct or dt).
      -- Seem to conflict with my statusline and whichkey somehow.
      -- vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
      -- vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
      -- vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
      -- vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
      -- TODO: Try ghostbuster91/nvim-next

      -- Diagnostics
      local next_diagnostic_repeat, prev_diagnostic_repeat = ts_repeat_move.make_repeatable_move_pair(
        vim.diagnostic.goto_next, vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', next_diagnostic_repeat, { desc = 'Next diagnostic' })
      vim.keymap.set('n', '[d', prev_diagnostic_repeat, { desc = 'Previous diagnostic' })
    end
  },

}
