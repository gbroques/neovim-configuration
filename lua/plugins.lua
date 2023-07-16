local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader Key
-- ----------------------------------------------------
-- Set `mapleader` before lazy so mappings are correct.
-- Article on why space for the leader key:
-- https://raindev.io/blog/space-leader/
vim.g.mapleader = ' '
-------------------------------------------------------
-- TODO: Refactor into plugins directory.
-- See https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/plugins
-- require("lazy").setup("plugins")

-- TODO: Better organize plugins into groups by concern like LazyVim.
-- See https://www.lazyvim.org/plugins
return require('lazy').setup({

  -- Theme
  {
    'folke/tokyonight.nvim',
    tag = 'v2.0.0'
  },

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

  -- Miscellaneous
  {
    'max397574/better-escape.nvim',
    commit = '7031dc734add47bb71c010e0551829fa5799375f'
  },
  {
    'windwp/nvim-autopairs',
    commit = 'e8f7dd7a72de3e7b6626c050a802000e69d53ff0'
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
  {
    'folke/which-key.nvim',
    tag = 'v1.4.3'
  },
  {
    'smjonas/inc-rename.nvim',
    commit = 'ed0f6f2b917cac4eb3259f907da0a481b27a3b7e'
  },
  {
    'nvim-pack/nvim-spectre',
    commit = 'f4dc98ec45ecded2344aa3aac2d7cc43ad236858'
  },
  -- TODO:
  -- 'andymass/vim-matchup'
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
  -- TODO: karb94/neoscroll.nvim for smooth scrolling
  -- TODO: SmiteshP/nvim-navic
  -- TODO: chentoast/marks.nvim
  -- TODO: Add custom text objects
  --       https://youtu.be/wlR5gYd6um0?t=1793
  --       Indent, Entire, Line
  -- TODO: This plugin errors.
  -- { "kana/vim-textobj-entire" },
  --       wellle/targets.vim
  --       echasnovski/mini.ai
  -- TODO: The following "replace with register" plugin uses 'gr' to 'go replace'.
  -- We don't want to use this mapping because it conflicts with "goto references" for LSP.
  -- https://github.com/inkarkat/vim-ReplaceWithRegister
  -- See https://youtu.be/wlR5gYd6um0?t=1608 for an introduction.

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
     -- Configs for nvim LSP client
    'neovim/nvim-lspconfig',
    commit = 'b6b34b9acf84949f0ac1c00747765e62b81fb38d'
  },
  {
    -- Adapts linters / formatters to Neovim's LSP client.
    'jose-elias-alvarez/null-ls.nvim',
    commit = 'bbaf5a96913aa92281f154b08732be2f57021c45'
  },
  {
    -- TODO: Migrate to doums/lswip.nvim
    'doums/lsp_spinner.nvim',
    commit = '172be3f5570c06ccaf82ebb67ed233bf07647cc4'
  },
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
  -- TODO:
  -- 'simrat39/symbols-outline.nvim'
  -- 'kosayoda/nvim-lightbulb'

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
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
    'hrsh7th/cmp-nvim-lsp-signature-help',
    commit = '3d8912ebeb56e5ae08ef0906e3a54de1c66b92f1'
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
    tag = 'v0.9.0'
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

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    commit = 'a36bc3360d584d39b4fb076d855c4180842d4444'
  },
  -- TODO:
  -- { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' }
}, { git = { timeout = 600 } })
