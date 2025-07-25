return {
  {
    -- TODO: Some commenting behavior is built-in to Neovim since 0.10
    -- See https://gpanders.com/blog/whats-new-in-neovim-0.10/#builtin-commenting
    -- See Is this still needed with Neovim 0.10?
    --     https://github.com/numToStr/Comment.nvim/issues/453
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
        commit = '9c74db656c3d0b1c4392fc89a016b1910539e7c0',
        -- TODO: Make this work with Neovim native comments?
        -- See https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#native-commenting-in-neovim-010
        config = function()
          require('ts_context_commentstring').setup {
            enable_autocmd = false
          }
        end
      }
    }
  }
}
