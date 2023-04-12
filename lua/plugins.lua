return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'mfussenegger/nvim-jdtls'
    use 'navarasu/onedark.nvim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
end)
