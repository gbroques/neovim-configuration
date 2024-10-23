return {
  {
    'numToStr/Comment.nvim',
    commit = 'e30b7f2008e52442154b66f7c519bfd2f1e32acb',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      }
    end,
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        commit = '9c74db656c3d0b1c4392fc89a016b1910539e7c0'
      }
    }
  }
}
