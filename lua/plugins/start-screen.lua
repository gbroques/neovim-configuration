return {
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    commit = '9e33db324b8bb7a147bce9ea5496686ee859461d',
    event = 'VimEnter',
    config = function()
      local alpha = require('alpha')
      local startify = require('alpha.themes.startify')
      startify.section.header.val = {} -- Remove default 'neovim header'
      alpha.setup(startify.config)
    end
  },
}
