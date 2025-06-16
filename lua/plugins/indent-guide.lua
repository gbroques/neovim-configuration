return {
  -- Editor Pane
  {
    'lukas-reineke/indent-blankline.nvim',
    tag = 'v3.9.0',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('ibl').setup {
        exclude = {
          filetypes = {
            'lspinfo',
            'packer',
            'checkhealth',
            'help',
            'gitcommit',
            'TelescopePrompt',
            'TelescopeResults',
            'NvimTree'
          },
          buftypes = {
            'terminal',
            'nofile',
            'quickfix',
            'prompt'
          }
        }
      }
    end
  },
}
