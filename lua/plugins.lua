return require('packer').startup(function(use)
    -- Package Manager
    use 'wbthomason/packer.nvim'
    -- Theme
    use 'lunarvim/darkplus.nvim'

    -- Download FiraCode Nerd Font
    -- https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
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

    -- LSP
    use 'mfussenegger/nvim-jdtls' -- Java Development Tools Language Server

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
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
end)
