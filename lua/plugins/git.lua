return {
  {
    'lewis6991/gitsigns.nvim',
    commit = '88205953bd748322b49b26e1dfb0389932520dc9',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'petertriho/nvim-scrollbar',
    },
    config = function()
      local gitsigns = require('gitsigns')

      gitsigns.setup {
        signs = {
          add = { text = '▎' },
          change = { text = '▎' },
          delete = { text = '󰐊' },
          topdelete = { text = '󰐊' },
          changedelete = { text = '▎' },
        },
        attach_to_untracked = false,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            -- TODO: Should this be in keymaps?
            vim.keymap.set(mode, l, r, opts)
          end

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk, { desc = 'stage hunk' })
          map('n', '<leader>hr', gs.reset_hunk, { desc = 'reset hunk' })
          map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('n', '<leader>hS', gs.stage_buffer, { desc = 'stage buffer' })
          map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
          map('n', '<leader>hR', gs.reset_buffer, { desc = 'reset buffer' })
          map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview hunk' })
          map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = 'blame' })
          map('n', '<leader>gd', gs.diffthis, { desc = 'Diff' })

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'inner hunk' })

          local toggle_statusline = function()
            vim.opt.laststatus = vim.o.laststatus == 3 and 0 or 3
            vim.opt.showmode = not vim.o.showmode
          end
          map('n', '<leader>us', toggle_statusline, { desc = 'Toggle statusline' })
          map('n', '<leader>ug', gs.toggle_signs, { desc = 'Toggle gitsigns' })
          -- Consider the following plugins for zen mode
          -- https://github.com/koenverburg/peepsight.nvim
          -- https://github.com/junegunn/limelight.vim
          local toggle_zen_mode = function()
            toggle_statusline()
            gs.toggle_signs()
            vim.cmd('echo') -- clear any text in the last line
          end
          map('n', '<leader>uz', toggle_zen_mode, { desc = 'Toggle zen mode' })
        end
      }

      local function next_hunk()
        gitsigns.nav_hunk('next')
      end
      local function prev_hunk()
        gitsigns.nav_hunk('prev')
      end
      vim.keymap.set({ 'n', 'x', 'o' }, ']h', next_hunk, { desc = 'Next hunk' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[h', prev_hunk, { desc = 'Previous hunk' })

      require('scrollbar.handlers.gitsigns').setup()
    end
  },
  -- TODO:
  -- { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' }
}
