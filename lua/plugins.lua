return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'mfussenegger/nvim-jdtls'
    use 'navarasu/onedark.nvim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use 'max397574/better-escape.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'nvim-telescope/telescope-ui-select.nvim'
    use 'tpope/vim-surround'
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }
    use 'windwp/nvim-autopairs'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use { 'L3MON4D3/LuaSnip', tag = "v1.*" }
    use 'saadparwaiz1/cmp_luasnip'
end)
