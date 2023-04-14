return require('packer').startup(function(use)
    -- package manager
    use 'wbthomason/packer.nvim'
    use 'mfussenegger/nvim-jdtls'
    use 'lunarvim/darkplus.nvim'
    -- Download FiraCode Nerd Font
    -- https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }
    use 'max397574/better-escape.nvim'
    use 'windwp/nvim-autopairs'
    use 'tpope/vim-surround'

    -- telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'nvim-telescope/telescope-ui-select.nvim'
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    -- completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'saadparwaiz1/cmp_luasnip'

    -- snippets
    use { 'L3MON4D3/LuaSnip', tag = "v1.*" }
end)
