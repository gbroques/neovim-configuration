-- TODO: Better organize plugins into groups by concern like LazyVim.
-- See https://www.lazyvim.org/plugins
-- See also https://www.reddit.com/r/neovim/comments/zow2u9/which_structure_of_neovim_config_files_do_you/
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
  -- Explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    commit = 'c3c6544ee00333b0f1d6a13735d0dd302dba4f70'
  },
  -- Startup screen
  {
    'goolord/alpha-nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    commit = '9e33db324b8bb7a147bce9ea5496686ee859461d'
  },
  -- Project management
  {
    'ahmedkhalf/project.nvim',
    commit = '8c6bad7d22eef1b71144b401c9f74ed01526a4fb'
  },
  -- UI element to remember keymaps
  {
    'folke/which-key.nvim',
    tag = 'v1.4.3'
  },
  -- Project-wide find and replace
  {
    'nvim-pack/nvim-spectre',
    commit = 'f4dc98ec45ecded2344aa3aac2d7cc43ad236858'
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
  },
  {
    'RRethy/vim-illuminate',
    commit = 'a2907275a6899c570d16e95b9db5fd921c167502'
  },
  {
    'petertriho/nvim-scrollbar',
    commit = '35f99d559041c7c0eff3a41f9093581ceea534e8'
  },
  -- Editing
  {
    'max397574/better-escape.nvim',
    commit = '7031dc734add47bb71c010e0551829fa5799375f'
  },
  {
    'windwp/nvim-autopairs',
    commit = 'e8f7dd7a72de3e7b6626c050a802000e69d53ff0'
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
    tag = 'v2.2'
  },
  {
    'tpope/vim-repeat',
    tag = 'v1.2'
  },
  -- TODO: lspsaga or dressing.nvim for rename popup
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

  -- Comment
  {
    'numToStr/Comment.nvim',
    tag = 'v0.8.0'
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    commit = '7f625207f225eea97ef7a6abe7611e556c396d2f'
  },

  -- LSP
  {
    -- Configuration for Neovim's LSP client.
    'neovim/nvim-lspconfig',
    commit = 'b6b34b9acf84949f0ac1c00747765e62b81fb38d'
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
  },
  {
    -- TODO: Migrate to doums/lswip.nvim
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
  },
  -- Lua Debug Adapter
  {
    'jbyuki/one-small-step-for-vimkind',
    commit = '5cacc816153c66a50de92c9cee29077b4a380254'
  },
  -- Lua 5.1 Reference Manual converted to Vim help docs
  -- https://www.lua.org/manual/5.1/manual.html
  {
    'milisims/nvim-luaref',
    commit = '9cd3ed50d5752ffd56d88dd9e395ddd3dc2c7127'
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

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    commit = '2ea8dcd17b4f9b7714354965a28ae4fef4139c71',
    dependencies = {
      {
        'nvim-lua/plenary.nvim',
        commit = '1a6a7c929628566cf406aa7da1d048a1ddc7e9a8'
      }
    }
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

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    commit = 'e1f1b40790a8cb7e64091fb12cc5ffe350363aa0'
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    commit = '44b16d11215dce86f253ce0c30949813c0a90765'
  },
  {
    'hrsh7th/cmp-buffer',
    commit = '3022dbc9166796b644a841a02de8dd1cc1d311fa'
  },
  {
    'hrsh7th/cmp-path',
    commit = '91ff86cd9c29299a64f968ebb45846c485725f23'
  },
  {
    'hrsh7th/cmp-cmdline',
    commit = '8ee981b4a91f536f52add291594e89fb6645e451'
  },
  {
    'dmitmel/cmp-cmdline-history',
    commit = '003573b72d4635ce636234a826fa8c4ba2895ffe'
  },
  {
    'hrsh7th/cmp-nvim-lsp-signature-help',
    commit = '3d8912ebeb56e5ae08ef0906e3a54de1c66b92f1'
  },
  {
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    commit = 'f0f53f704c08ea501f9d222b23491b0d354644b0'
  },
  {
    'saadparwaiz1/cmp_luasnip',
    commit = '18095520391186d634a0045dacaa346291096566'
  },

  -- Snippets
  {
    'L3MON4D3/LuaSnip',
    tag = "v1.2.1"
  },
  {
    'rafamadriz/friendly-snippets',
    commit = '5749f093759c29e3694053d048ceb940fe12c3d3'
  },

  -- Tree-sitter
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
  -- TODO: nvim-treesitter/nvim-treesitter-context for easier function navigation
  --       with relative line numbers.
  --       See https://youtu.be/uL9oOZStezw?t=291

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    commit = 'a36bc3360d584d39b4fb076d855c4180842d4444'
  },
  -- TODO:
  -- { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' }
}
