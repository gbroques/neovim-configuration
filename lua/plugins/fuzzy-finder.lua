return {
  {
    'nvim-telescope/telescope.nvim',
    commit = 'da8b3d485975a8727bea127518b65c980521ae22',
    event = { 'LspAttach' }, -- telescope used as vim.ui.select for code actions
    cmd = { 'Telescope' },
    keys = {

      { '<leader>f',  ':Telescope frecency<CR>',     desc = 'Find files' },
      { '<leader>sb', ':Telescope buffers<CR>',      desc = 'Buffers' },
      { '<leader>sc', ':Telescope commands<CR>',     desc = 'Commands' },
      { '<leader>sd', ':Telescope diagnostics<CR>',  desc = 'Diagnostics' },
      { '<leader>ss', ':Telescope live_grep<CR>',    desc = 'Search' },
      { '<leader>S',  '<leader>ss',                  desc = 'Search',            remap = true },
      { '<leader>sh', ':Telescope help_tags<CR>',    desc = 'Help' },
      { '<leader>sj', ':Telescope jumplist<CR>',     desc = 'Jumplist' },
      { '<leader>sk', ':Telescope keymaps<CR>',      desc = 'Keymaps' },
      { '<leader>sm', ':Telescope marks<CR>',        desc = 'Marks' },
      -- TODO: Change to <leader> p if projects shortcut is common
      --       this is a taken keymap in keymaps.lua
      { '<leader>sp', ':Telescope projects<CR>',     desc = 'Projects' },
      { '<leader>sq', ':Telescope quickfix<CR>',     desc = 'Quickfix' },
      { '<leader>sr', ':Telescope registers<CR>',    desc = 'Registers' },
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
        commit = '62ea5e58c7bbe191297b983a9e7e89420f581369'
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        commit = '9bc8237565ded606e6c366a71c64c0af25cd7a50'
      },
      {
        -- Potential alternatives to telescope-frecency:
        -- * danielfalk/smart-open.nvim
        -- * prochri/telescope-all-recent.nvim
        -- * smartpde/telescope-recent-files
        'nvim-telescope/telescope-frecency.nvim',
        commit = '4f3e007ec28eb248811f9d7074315fe1f8852199'
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
      telescope.load_extension('projects')
      telescope.load_extension('fzf')
      telescope.load_extension('frecency')
    end
  },
}
