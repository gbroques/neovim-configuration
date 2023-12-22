-- Autopairs
return {
  {
    'windwp/nvim-autopairs',
    commit = 'e8f7dd7a72de3e7b6626c050a802000e69d53ff0',
    -- TODO: Consider CmdlineEnter if autopairs ever supports that:
    -- event = { 'InsertEnter', 'CmdlineEnter' },
    -- https://github.com/windwp/nvim-autopairs/issues/309
    event = { 'InsertEnter' },
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
      { 'hrsh7th/nvim-cmp' },
    },
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true, -- treesitter integration
      }

      -- Insert parentheses () after completing function or method.
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done {})
    end,
  },
}
