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
              -- Text objects
              ['aa'] = { query = '@parameter.outer', desc = 'an argument' },
              ['ia'] = { query = '@parameter.inner', desc = 'inner argument' },
              ['ac'] = { query = '@class.outer', desc = 'a class' },
              ['ic'] = { query = '@class.inner', desc = 'inner class' },
              -- TODO: d for decision?
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
              -- Also gd usually goes to the file with an LSP server
              ['gf'] = { query = '@function.outer', desc = 'Goto next function' },
              [']]'] = { query = '@class.outer', desc = 'Next class start' },
            },
            goto_next_end = {
              [']M'] = { query = '@function.outer', desc = 'Next method end' },
              [']['] = { query = '@class.outer', desc = 'Next class end' },
            },
            goto_previous_start = {
              -- Override builtin gF 'goto file' as it's more ergonomic than [m
              -- Also gd usually goes to the file with an LSP server
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
      -- TODO: Try ghostbuster91/nvim-next
    end
  },

}
