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
vim.g.mapleader = ' '
-------------------------------------------------------
-- TODO: Refactor into plugins directory.
-- See https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/plugins
-- require("lazy").setup("plugins")

return require('lazy').setup({

  -- Theme
  'folke/tokyonight.nvim',

  'nvim-tree/nvim-web-devicons',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'akinsho/bufferline.nvim',
    version = "v3.*",
    dependencies = 'nvim-tree/nvim-web-devicons'
  },

  -- Miscellaneous
  'max397574/better-escape.nvim',
  'windwp/nvim-autopairs',
  'tpope/vim-surround',
  'folke/which-key.nvim',
  'smjonas/inc-rename.nvim',
  -- TODO:
  -- 'andymass/vim-matchup'
  -- Editor Pane
  'lukas-reineke/indent-blankline.nvim',
  'RRethy/vim-illuminate',
  'petertriho/nvim-scrollbar',
  -- TODO: SmiteshP/nvim-navic

  -- Comment
  { "numToStr/Comment.nvim" },
  { "JoosepAlviste/nvim-ts-context-commentstring" },

  -- LSP
  'neovim/nvim-lspconfig', -- Configs for nvim LSP client
  'LuaLS/lua-language-server',
  -- Java
  'mfussenegger/nvim-jdtls', -- Java Development Tools Language Server
  -- Lua (Neovim Plugin Development)
  'folke/neodev.nvim',
  -- TODO:
  -- 'ray-x/lsp_signature.nvim'

  -- Telescope
  {
    'nvim-telescope/telescope.nvim', version = '0.1.1',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  -- for nvim-jdtls
  -- https://github.com/mfussenegger/nvim-jdtls/wiki/UI-Extensions
  'nvim-telescope/telescope-ui-select.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },

  -- Completion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'saadparwaiz1/cmp_luasnip',

  -- Snippets
  { 'L3MON4D3/LuaSnip', version = "v1.*" },
  'rafamadriz/friendly-snippets',

  -- Tree-sitter
  {
    'nvim-treesitter/nvim-treesitter',
    -- Update installed parsers when upgrading plugin
    build = ':TSUpdate'
  },
  'windwp/nvim-ts-autotag',
  -- TODO: mrjones2014/nvim-ts-rainbow

  -- Git
  'lewis6991/gitsigns.nvim',
  -- TODO:
  -- { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' }
})
