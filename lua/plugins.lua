local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Automatically run :PackerCompile whenever this file is saved.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  -- Package Manager
  use 'wbthomason/packer.nvim'

  -- Theme
  use 'folke/tokyonight.nvim'

  use 'nvim-tree/nvim-web-devicons'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }
  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons'
  }

  -- Miscellaneous
  use 'max397574/better-escape.nvim'
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-surround'
  use 'folke/which-key.nvim'
  use 'smjonas/inc-rename.nvim'
  -- TODO:
  -- use 'andymass/vim-matchup'
  -- Editor Pane
  use 'lukas-reineke/indent-blankline.nvim'
  use 'RRethy/vim-illuminate'
  use 'petertriho/nvim-scrollbar'
  -- TODO: SmiteshP/nvim-navic

  -- Comment
  use { "numToStr/Comment.nvim" }
  use { "JoosepAlviste/nvim-ts-context-commentstring" }

  -- LSP
  use 'neovim/nvim-lspconfig' -- Configs for nvim LSP client
  use 'LuaLS/lua-language-server'
  -- Java
  use 'mfussenegger/nvim-jdtls' -- Java Development Tools Language Server
  -- Lua (Neovim Plugin Development)
  use 'folke/neodev.nvim'
  -- TODO:
  -- use 'ray-x/lsp_signature.nvim'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  -- for nvim-jdtls
  -- https://github.com/mfussenegger/nvim-jdtls/wiki/UI-Extensions
  use 'nvim-telescope/telescope-ui-select.nvim'
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'

  -- Snippets
  use { 'L3MON4D3/LuaSnip', tag = "v1.*" }
  use 'rafamadriz/friendly-snippets'

  -- Tree-sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    -- Update installed parsers when upgrading plugin
    run = ':TSUpdate'
  }
  use 'windwp/nvim-ts-autotag'
  -- TODO: mrjones2014/nvim-ts-rainbow

  -- Git
  use 'lewis6991/gitsigns.nvim'
  -- TODO:
  -- use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  if packer_bootstrap then
    require('packer').sync()
  end
end)
