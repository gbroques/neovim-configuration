-- TODO: Better organize plugins into groups by concern like LazyVim.
-- See https://www.lazyvim.org/plugins
-- See also https://www.reddit.com/r/neovim/comments/zow2u9/which_structure_of_neovim_config_files_do_you/
-- TODO: See the following link for a reference of how to lazy-load various plugins
-- https://github.com/2KAbhishek/nvim2k/blob/main/lua/plugins/list.lua
return {
  {
    'nvim-tree/nvim-web-devicons',
    commit = '14b3a5ba63b82b60cde98d0a40319d80f25e8301'
  },
  -- Statusline
  {
    'rebelot/heirline.nvim',
    commit = '2a151df2dc870e79b138a59ebaaaddf3d1b0d703'
  },
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    commit = '9e33db324b8bb7a147bce9ea5496686ee859461d'
  },
  -- Project management
  {
    'ahmedkhalf/project.nvim',
    commit = '8c6bad7d22eef1b71144b401c9f74ed01526a4fb'
  },
  {
    -- Reopen files at last edit position.
    'farmergreg/vim-lastplace',
    commit = 'cef9d62165cd26c3c2b881528a5290a84347059e'
  },
  -- Editor Pane
  {
    'lukas-reineke/indent-blankline.nvim',
    tag = 'v2.20.6'
    -- TODO: Lazy-load on event = { 'BufReadPre', 'BufNewFile' }
  },
  {
    'RRethy/vim-illuminate',
    commit = 'a2907275a6899c570d16e95b9db5fd921c167502'
  },
  -- Editing
  {
    'max397574/better-escape.nvim',
    commit = '7031dc734add47bb71c010e0551829fa5799375f'
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
  -- TODO: Lazy-load on keys = { 'cs', 'ds', 'ys' }
  {
    'tpope/vim-surround',
    tag = 'v2.2'
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
    commit = 'ed0f6f2b917cac4eb3259f907da0a481b27a3b7e'
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

  -- Folding
  {
    'kevinhwang91/nvim-ufo',
    commit = '43e39ec74cd57c45ca9d8229a796750f6083b850',
    dependencies = {
      {
        'kevinhwang91/promise-async',
        commit = 'e94f35161b8c5d4a4ca3b6ff93dd073eb9214c0e'
      }
    }
  },

  -- LSP
  {
    -- Configuration for Neovim's LSP client.
    'neovim/nvim-lspconfig',
    commit = 'b6b34b9acf84949f0ac1c00747765e62b81fb38d'
    -- TODO: Lazy-load on event = { 'BufReadPre', 'BufNewFile' }
  },
  {
    -- Adapts linters & formatters to Neovim's LSP client.
    -- TODO: null-ls is archived
    -- none-ls is a drop-in replacement
    -- conform.nvim is also suggested
    -- need to figure out eslint_d alternative
    -- See lsp.lua
    'jose-elias-alvarez/null-ls.nvim',
    commit = 'bbaf5a96913aa92281f154b08732be2f57021c45'
    -- TODO: Lazy-load on event = { 'BufReadPre', 'BufNewFile' }
  },
  {
    -- TODO: Migrate to doums/lswip.nvim
    -- TODO: Try linrongbin16/lsp-progress.nvim instead
    'doums/lsp_spinner.nvim',
    commit = '172be3f5570c06ccaf82ebb67ed233bf07647cc4'
  },
  -- Debugging
  {
    'mfussenegger/nvim-dap',
    tag = '0.6.0'
  },
  {
    'rcarriga/nvim-dap-ui',
    tag = 'v3.8.3'
  },
  -- TODO LiadOz/nvim-dap-repl-highlights
  -- Java
  {
    -- Java Development Tools Language Server
    'mfussenegger/nvim-jdtls',
    commit = 'c6a3c47a0c57c6c0c9b5fb92d3770bb59e92d9c6'
  },
  -- Lua (Neovim Plugin Development)
  {
    'folke/neodev.nvim',
    tag = 'v2.5.2'
    -- TODO: Lazy load on ft = { 'lua', 'vim' }
  },
  -- Lua Debug Adapter
  {
    'jbyuki/one-small-step-for-vimkind',
    commit = '5cacc816153c66a50de92c9cee29077b4a380254'
    -- TODO: Lazy load on ft = { 'lua', 'vim' }
  },
  -- Lua 5.1 Reference Manual converted to Vim help docs
  -- https://www.lua.org/manual/5.1/manual.html
  {
    'milisims/nvim-luaref',
    commit = '9cd3ed50d5752ffd56d88dd9e395ddd3dc2c7127'
    -- TODO: Lazy load on ft = { 'lua', 'vim' }
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

  -- Tree-sitter
  -- TODO: Lazy-load tree-sitter plugins on event = { 'BufReadPre', 'BufNewFile' }
  {
    'nvim-treesitter/nvim-treesitter',
    -- Update installed parsers when upgrading plugin
    build = ':TSUpdate',
    commit = '51ea343f705a89326cff8dd7a0542d7fe0e6699a'
  },
  {
    'windwp/nvim-ts-autotag',
    commit = '6be1192965df35f94b8ea6d323354f7dc7a557e4'
  },
  {
    'HiPhish/nvim-ts-rainbow2',
    tag = 'v2.2.0'
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    commit = '83c59ed1eeae70a55605990993cf4d208948fdf7'
  },
  {
    'nvim-treesitter/playground',
    commit = '2b81a018a49f8e476341dfcb228b7b808baba68b'
  },

  -- Utility
  {
    'nvim-lua/plenary.nvim',
    commit = '1a6a7c929628566cf406aa7da1d048a1ddc7e9a8'
  },

  -- TODO: nvim-treesitter/nvim-treesitter-context for easier function navigation
  --       with relative line numbers.
  --       See https://youtu.be/uL9oOZStezw?t=291
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime'
  }
}
