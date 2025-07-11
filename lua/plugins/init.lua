-- TODO: Better organize plugins into groups by concern like LazyVim.
-- See https://www.lazyvim.org/plugins
-- See also https://www.reddit.com/r/neovim/comments/zow2u9/which_structure_of_neovim_config_files_do_you/
-- TODO: See the following link for a reference of how to lazy-load various plugins
-- https://github.com/2KAbhishek/nvim2k/blob/main/lua/plugins/list.lua
return {
  {
    -- Reopen files at last edit position.
    'farmergreg/vim-lastplace',
    commit = 'e58cb0df716d3c88605ae49db5c4741db8b48aa9',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  -- Editing
  {
    'max397574/better-escape.nvim',
    commit = '19a38aab94961016430905ebec30d272a01e9742',
    event = 'InsertEnter',
    config = function()
      -- 'dh' is a convenient escape from Insert mode in Colemak.
      require('better_escape').setup({ mappings = { i = { d = { h = '<Esc>'} } } })
    end
  },
  {
    'chrishrb/gx.nvim',
    commit = '38d776a0b35b9daee5020bf3336564571dc785af',
    event = { 'BufEnter' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true
  },
  -- TODO:
  -- Try a new surround plugin like echasnovski/mini.surround or
  -- kylechui/nvim-surround with dot repeat builtin?
  {
    'tpope/vim-surround',
    tag = 'v2.2',
    keys = { 'cs', 'ds', 'ys' }
  },
  {
    'tpope/vim-repeat',
    tag = 'v1.2'
  },
  {
    'smjonas/live-command.nvim',
    commit = '05b9f886628f3e9e6122e734c1fac4f13dcb64b4',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('live-command').setup {
        commands = {
          Norm = { cmd = 'norm' },
        },
      }
      -- https://vim.fandom.com/wiki/Unused_keys
      vim.keymap.set('v', '<C-N>', ':Norm ', { desc = 'norm (live-preview)' })
    end,
  },
  {
    -- TODO: consider lspsaga instead of dressing.nvim for LSP rename input
    'stevearc/dressing.nvim',
    commit = '8b7ae53d7f04f33be3439a441db8071c96092d19',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('dressing').setup({
        select = { enabled = false }
      })
    end
  },
  -- TODO: Plugins under consideration:
  {
    'ggandor/leap.nvim',
    commit = '68ca052dfdcda5e4e958d1ba0fef35e94a3e02e8',
    config = function()
      vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
      vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
    end
  },
  -- { 'andymas/vim-matchup' },
  --
  -- smooth scrolling
  -- { 'karb94/neoscroll.nvim' },
  -- { 'psliwka/vim-smoothie' },
  --
  -- { 'SmiteshP/nvim-navic' },
  -- { 'chentoast/marks.nvim' },
  -- { 'chrisgrieser/nvim-alt-substitute' },
  -- { 'chrisgrieser/nvim-spider' }, -- camel case / snake case motions
  -- Add custom text objects
  -- Read https://thevaluable.dev/vim-create-text-objects/
  -- { 'Julian/vim-textobj-variable-segment' },
  -- { 'chrisgrieser/nvim-various-textobjs' },
  -- { 'wellle/targets.vim' },
  -- ciq - change in quotes "" '' or ``
  -- { 'echasnovski/mini.ai' },
  {
    'gbprod/substitute.nvim',
    commit = '9db749a880e3dd3b0eb57f698aa8f1e1630e1f25',
    config = function()
      require('substitute').setup()
      vim.keymap.set('n', 'gs', require('substitute').operator, { noremap = true })
    end
  },
  -- gs is taken by vim.lsp.buf.signature_help currently
  -- s will be used for leap
  -- { 'simrat39/symbols-outline.nvim' },
  -- { 'kosayoda/nvim-lightbulb' },

  -- Java
  {
    -- Java Development Tools Language Server
    'mfussenegger/nvim-jdtls',
    commit = '4d77ff02063cf88963d5cf10683ab1fd15d072de',
    ft = { 'java' }
  },
  -- YAML & JSON
  -- TODO:
  -- YAML Language Server doesn't work with openapi 3.0
  -- See: https://github.com/redhat-developer/yaml-language-server/issues/7
  -- swagger-ui-watcher needs to bump swagger-editor-dist to 5.x for openapi 3.1:
  -- See: https://github.com/swagger-api/swagger-editor/releases/tag/v4.10.0
  -- {
  --   'vinnymeller/swagger-preview.nvim',
  --   commit = '4e1db32e7934c57d653846d5d297f7ea9ddb6ee8',
  --   build = 'npm install -g swagger-ui-watcher',
  --   config = function()
  --     require("swagger-preview").setup({
  --       -- The port to run the preview server on
  --       port = 8000,
  --       -- The host to run the preview server on
  --       host = "localhost",
  --     })
  --   end
  -- },

  -- Utility
  {
    'nvim-lua/plenary.nvim',
    commit = '857c5ac632080dba10aae49dba902ce3abf91b35',
    lazy = true
  },
  {
    'nvim-tree/nvim-web-devicons',
    commit = '1fb58cca9aebbc4fd32b086cb413548ce132c127',
    lazy = true
  },
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function()
      vim.g.startuptime_tries = 10
    end,
  }
}
