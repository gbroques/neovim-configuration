return {
  {
    'numToStr/Comment.nvim',
    tag = 'v0.8.0',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      }
    end,
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        commit = '7f625207f225eea97ef7a6abe7611e556c396d2f'
      }
    }
  }
}
