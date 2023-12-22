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
      require("project_nvim").setup({})
    end
  },
  {
    -- Reopen files at last edit position.
    'farmergreg/vim-lastplace',
    commit = 'cef9d62165cd26c3c2b881528a5290a84347059e'
  },
  -- Editing
  {
    'max397574/better-escape.nvim',
    commit = '7031dc734add47bb71c010e0551829fa5799375f',
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
  -- TODO: lspsaga or dressing.nvim for rename popup
  -- TODO: Also consider https://github.com/smjonas/live-command.nvim
  --       for live preview of commands like norm & g.
  {
    'smjonas/inc-rename.nvim',
    commit = 'ed0f6f2b917cac4eb3259f907da0a481b27a3b7e',
    config = true,
    event = 'LspAttach',
    cmd = 'IncRename'
  },
  -- TODO: Plugins under consideration:
  --       * andymas/vim-matchup
  --       * karb94/neoscroll.nvim - smooth scrolling
  --       * SmiteshP/nvim-navic
  --       * chentoast/marks.nvim
  --       * chrisgrieser/nvim-spider - camel case / snake case motions
  --       * Add custom text objects
  --         * Read https://thevaluable.dev/vim-create-text-objects/
  --         * Julian/vim-textobj-variable-segment
  --         * chrisgrieser/nvim-various-textobjs
  --         * wellle/targets.vim
  --         * ciq - change in quotes "" '' or ``
  --         * echasnovski/mini.ai
  --         * Watch https://youtu.be/wlR5gYd6um0?t=1793
  --           * Indent, Entire, Line
  --           * TODO: kana/vim-textobj-entire errors.
  --           * TODO: inkarkat/vim-ReplaceWithRegister
  --           * The above "replace with register" plugin uses 'gr' to 'go replace'.
  --           * We don't want to use this mapping because it conflicts with "goto references" for LSP.
  --           * See https://youtu.be/wlR5gYd6um0?t=1608 for an introduction.
  --           * There's also https://github.com/gbprod/substitute.nvim

  -- Java
  {
    -- Java Development Tools Language Server
    'mfussenegger/nvim-jdtls',
    commit = 'c6a3c47a0c57c6c0c9b5fb92d3770bb59e92d9c6',
    ft = { 'java ' }
  },
  -- Lua 5.1 Reference Manual converted to Vim help docs
  -- https://www.lua.org/manual/5.1/manual.html
  {
    'milisims/nvim-luaref',
    commit = '9cd3ed50d5752ffd56d88dd9e395ddd3dc2c7127',
    ft = { 'lua', 'vim' }
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
  -- TODO: Plugins under consideration:
  --       * simrat39/symbols-outline.nvim
  --       * kosayoda/nvim-lightbulb

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
  -- TODO: nvim-treesitter/nvim-treesitter-context for easier function navigation
  --       with relative line numbers.
  --       See https://youtu.be/uL9oOZStezw?t=291
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function()
      vim.g.startuptime_tries = 10
    end,
  }
}
