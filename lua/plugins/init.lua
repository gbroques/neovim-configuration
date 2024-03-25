-- TODO: Better organize plugins into groups by concern like LazyVim.
-- See https://www.lazyvim.org/plugins
-- See also https://www.reddit.com/r/neovim/comments/zow2u9/which_structure_of_neovim_config_files_do_you/
-- TODO: See the following link for a reference of how to lazy-load various plugins
-- https://github.com/2KAbhishek/nvim2k/blob/main/lua/plugins/list.lua
return {
  -- Project management
  {
    'ahmedkhalf/project.nvim',
    commit = '8c6bad7d22eef1b71144b401c9f74ed01526a4fb',
    event = 'VimEnter',
    cmd = 'Telescope projects',
    config = function()
      require('project_nvim').setup({})
    end
  },
  {
    -- Reopen files at last edit position.
    'farmergreg/vim-lastplace',
    commit = 'cef9d62165cd26c3c2b881528a5290a84347059e',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  -- Editing
  {
    'max397574/better-escape.nvim',
    commit = 'd62cf3c04163a46f3895c70cc807f5ae68dd8ca1',
    event = 'InsertEnter',
    config = function()
      -- 'dh' is a convenient escape from Insert mode in Colemak.
      require('better_escape').setup({ mapping = { 'dh' } })
    end
  },
  {
    'chrishrb/gx.nvim',
    commit = '38d776a0b35b9daee5020bf3336564571dc785af',
    event = { 'BufEnter' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true
  },
  -- TODO:
  -- Try a new surround plugin like echasnovski/mini.surround or
  -- kylechui/nvim-surround with dot repeat builtin?
  {
    'tpope/vim-surround',
    tag = 'v2.2',
    keys = { 'cs', 'ds', 'ys' }
  },
  {
    'tpope/vim-repeat',
    tag = 'v1.2'
  },
  {
    'smjonas/live-command.nvim',
    commit = 'd460067d47948725a6f25b20f31ea8bbfdfe4622',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('live-command').setup {
        commands = {
          Norm = { cmd = 'norm' },
        },
      }
      -- https://vim.fandom.com/wiki/Unused_keys
      vim.keymap.set('v', '<C-N>', ':Norm ', { desc = 'norm (live-preview)' })
    end,
  },
  {
    -- TODO: consider lspsaga instead of dressing.nvim for LSP rename input
    'stevearc/dressing.nvim',
    commit = '8b7ae53d7f04f33be3439a441db8071c96092d19',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('dressing').setup({
        select = { enabled = false }
      })
    end
  },
  -- TODO: Plugins under consideration:
  -- { 'ggandor/leap.nvim' },
  -- { 'andymas/vim-matchup' },
  --
  -- smooth scrolling
  -- { 'karb94/neoscroll.nvim' },
  -- { 'psliwka/vim-smoothie' },
  --
  -- { 'SmiteshP/nvim-navic' },
  -- { 'chentoast/marks.nvim' },
  -- { 'chrisgrieser/nvim-alt-substitute' },
  -- { 'chrisgrieser/nvim-spider' }, -- camel case / snake case motions
  -- Add custom text objects
  -- Read https://thevaluable.dev/vim-create-text-objects/
  -- { 'Julian/vim-textobj-variable-segment' },
  -- { 'chrisgrieser/nvim-various-textobjs' },
  -- { 'wellle/targets.vim' },
  -- ciq - change in quotes "" '' or ``
  -- { 'echasnovski/mini.ai' },
  -- { 'gbprod/substitute.nvim' },
  -- gs is taken by vim.lsp.buf.signature_help currently
  -- s will be used for leap
  -- { 'simrat39/symbols-outline.nvim' },
  -- { 'kosayoda/nvim-lightbulb' },

  -- Java
  {
    -- Java Development Tools Language Server
    'mfussenegger/nvim-jdtls',
    commit = '8eb5f0dbe6e126b392ddcaf45893358619893e45',
    ft = { 'java ' }
  },
  -- YAML & JSON
  -- TODO:
  -- YAML Language Server doesn't work with openapi 3.0
  -- See: https://github.com/redhat-developer/yaml-language-server/issues/7
  -- swagger-ui-watcher needs to bump swagger-editor-dist to 5.x for openapi 3.1:
  -- See: https://github.com/swagger-api/swagger-editor/releases/tag/v4.10.0
  -- {
  --   'vinnymeller/swagger-preview.nvim',
  --   commit = '4e1db32e7934c57d653846d5d297f7ea9ddb6ee8',
  --   build = 'npm install -g swagger-ui-watcher',
  --   config = function()
  --     require("swagger-preview").setup({
  --       -- The port to run the preview server on
  --       port = 8000,
  --       -- The host to run the preview server on
  --       host = "localhost",
  --     })
  --   end
  -- },

  -- Utility
  {
    'nvim-lua/plenary.nvim',
    commit = '1a6a7c929628566cf406aa7da1d048a1ddc7e9a8',
    lazy = true
  },
  {
    'nvim-tree/nvim-web-devicons',
    commit = '14b3a5ba63b82b60cde98d0a40319d80f25e8301',
    lazy = true
  },
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function()
      vim.g.startuptime_tries = 10
    end,
  }
}
