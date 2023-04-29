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
  -- Startup screen
  {
    'goolord/alpha-nvim',
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  -- Project management
  'ahmedkhalf/project.nvim',

  -- Miscellaneous
  'max397574/better-escape.nvim',
  'windwp/nvim-autopairs',
  -- TODO:
  -- Try a new surround plugin like echasnovski/mini.surround or
  -- kylechui/nvim-surround with dot repeat builtin?
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'folke/which-key.nvim',
  'smjonas/inc-rename.nvim',
  -- TODO:
  -- 'andymass/vim-matchup'
  -- Editor Pane
  'lukas-reineke/indent-blankline.nvim',
  'RRethy/vim-illuminate',
  'petertriho/nvim-scrollbar',
  -- TODO: SmiteshP/nvim-navic
  -- TODO: chentoast/marks.nvim
  -- TODO: Add custom text objects
  --       https://youtu.be/wlR5gYd6um0?t=1793
  --       Indent, Entire, Line
  --       wellle/targets.vim
  --       echasnovski/mini.ai

  -- Comment
  { "numToStr/Comment.nvim" },
  { "JoosepAlviste/nvim-ts-context-commentstring" },

  -- LSP
  'neovim/nvim-lspconfig',           -- Configs for nvim LSP client
  'jose-elias-alvarez/null-ls.nvim', -- Adapts linters / formatters to Neovim's LSP client.
  'LuaLS/lua-language-server',
  -- Java
  'mfussenegger/nvim-jdtls', -- Java Development Tools Language Server
  -- Lua (Neovim Plugin Development)
  'folke/neodev.nvim',
  {
    -- Display language server progress in bottom right corner
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup({
        text = {
          spinner = 'line'
        }
      })
    end
  },
  -- TODO:
  -- 'simrat39/symbols-outline.nvim'
  -- 'kosayoda/nvim-lightbulb'

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.1',
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
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp-signature-help',
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
  'HiPhish/nvim-ts-rainbow2',
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  'nvim-treesitter/playground',

  -- Git
  'lewis6991/gitsigns.nvim',
  -- TODO:
  -- { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' }
}, { git = { timeout = 600 } })
