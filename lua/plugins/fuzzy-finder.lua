return {
  {
    'nvim-telescope/telescope.nvim',
    commit = 'b4da76be54691e854d3e0e02c36b0245f945c2c7',
    event = { 'LspAttach' }, -- telescope used as vim.ui.select for code actions
    cmd = { 'Telescope' },
    keys = {
      -- TODO: Cycle through history
      -- https://www.reddit.com/r/neovim/comments/phndpv/comment/hbl89xp/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

      -- TODO: Fix 'A' automatically inserted into Telescope picker
      -- Seems to only happen when first openting frecency,
      -- and doesn't occur when opening other pickers such as :Telescope find_files
      -- https://github.com/nvim-telescope/telescope-frecency.nvim/issues/270
      -- Running :FrecencyValidate to remove entries fixes it.
      --
      -- Related problem in Telescope:
      -- https://github.com/nvim-telescope/telescope-frecency.nvim/issues/270#issuecomment-2820374822
      -- https://github.com/nvim-telescope/telescope.nvim/issues/2195
      -- https://www.reddit.com/r/neovim/comments/1ed65xm/telescope_prompt_prefilled_with_a_when_using/?rdt=40029
      -- https://github.com/nvim-telescope/telescope.nvim/blob/b4da76be54691e854d3e0e02c36b0245f945c2c7/lua/telescope/pickers.lua#L601-L602
      { '<leader>f',  ':Telescope frecency<CR>',     desc = 'Find files' },
      { '<leader>s',  ':Telescope live_grep<CR>',    desc = 'Search',            remap = true },
      { '<leader>pb', ':Telescope buffers<CR>',      desc = 'Buffers' },
      { '<leader>pc', ':Telescope commands<CR>',     desc = 'Commands' },
      { '<leader>pd', ':Telescope diagnostics<CR>',  desc = 'Diagnostics' },
      { '<leader>ph', ':Telescope help_tags<CR>',    desc = 'Help' },
      { '<leader>pj', ':Telescope jumplist<CR>',     desc = 'Jumplist' },
      { '<leader>pk', ':Telescope keymaps<CR>',      desc = 'Keymaps' },
      { '<leader>pm', ':Telescope marks<CR>',        desc = 'Marks' },
      { '<leader>pp', ':Telescope resume<CR>',       desc = 'Resume' },
      { '<leader>pq', ':Telescope quickfix<CR>',     desc = 'Quickfix' },
      { '<leader>pr', ':Telescope registers<CR>',    desc = 'Registers' },
      -- Git
      { '<leader>gb', ':Telescope git_branches<CR>', desc = 'Branches' },
      { '<leader>gc', ':Telescope git_commits<CR>',  desc = 'Commits' },
      { '<leader>gC', ':Telescope git_bcommits<CR>', desc = 'Commits for buffer' },
      { '<leader>gs', ':Telescope git_status<CR>',   desc = 'Status' },
      -- LSP
      -- TODO: Write function that goes to reference automatically if there's only 1,
      -- and open Telescope if there's more than 1 reference.
      -- https://matrix.to/#/!cxlVvaAjYkBpQTKumW:gitter.im/$XuhOCs-CBTyGDT5cSSrwFvDUVlxbtlSISmztUEbG1Bo?via=matrix.org&via=gitter.im
      -- This appears to be a bug, with a neglected / stale PR to fix it:
      -- https://github.com/nvim-telescope/telescope.nvim/pull/2281
      { 'gr', function()
        -- Consider LSP Saga for references instead:
        -- https://nvimdev.github.io/lspsaga/finder/
        require('telescope.builtin').lsp_references({ include_declaration = false })
      end, { desc = 'Goto references' } },
      { 'gW', ':Telescope lsp_dynamic_workspace_symbols<CR>', desc = 'Workplace symbols' },
    },
    dependencies = {
      {
        'nvim-lua/plenary.nvim'
      },
      -- for nvim-jdtls
      -- https://github.com/mfussenegger/nvim-jdtls/wiki/UI-Extensions
      {
        'nvim-telescope/telescope-ui-select.nvim',
        commit = '6e51d7da30bd139a6950adf2a47fda6df9fa06d2'
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        commit = '1f08ed60cafc8f6168b72b80be2b2ea149813e55'
      },
      {
        -- Potential alternatives to telescope-frecency:
        -- * danielfalk/smart-open.nvim
        -- * prochri/telescope-all-recent.nvim
        -- * smartpde/telescope-recent-files
        'nvim-telescope/telescope-frecency.nvim',
        commit = '03a0efd1a8668b902bddef4b82cb7d46cd5ab22c'
      }
    },
    config = function()
      local telescope = require('telescope')

      telescope.setup({
        defaults = {
          wrap_results = true,
          results_title = false,
          file_ignore_patterns = {
            "^.git/"
          },
          layout_config = {
            -- Fullscreen
            width = { padding = 0 },
            height = { padding = 0 },
          },
          mappings = {
            i = {
              ['<C-Down>'] = require('telescope.actions').cycle_history_next,
              ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
            },
          },
        },
        pickers = {
          lsp_references = {
            prompt_title = 'References',
            preview_title = false,
            layout_strategy = 'vertical',
            layout_config = {
              prompt_position = 'top',
              preview_cutoff = 1,
              preview_height = 0.60,
              mirror = true
            },
          },
          find_files = {
            preview_title = false
          },
          live_grep = {
            preview_title = false,
            prompt_title = 'Search'
          }
        },
        extensions = {
          frecency = {
            default_workspace = 'CWD',
            prompt_title = 'Find Files',
            sorter = require('telescope.config').values.file_sorter()
          }
        }
      })
      telescope.load_extension('ui-select')
      telescope.load_extension('fzf')
      telescope.load_extension('frecency')
    end
  },
}
