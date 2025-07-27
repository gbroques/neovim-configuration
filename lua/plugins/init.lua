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
      require('better_escape').setup({ mappings = { i = { d = { h = '<Esc>' } } } })
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
  -- Try echasnovski/mini.surround?
  {
    'kylechui/nvim-surround',
    tag = 'v3.1.2',
    event = 'VeryLazy',
    dependencies = {
      'folke/tokyonight.nvim'
    },
    config = function()
      require('nvim-surround').setup()
      local colors = require('tokyonight.colors').setup()
      -- TODO: Should I contribute this to tokyonight theme?
      -- https://github.com/folke/tokyonight.nvim/blob/v4.11.0/lua/tokyonight/groups/mini_surround.lua#L9
      vim.api.nvim_set_hl(0, 'NvimSurroundHighlight', { bg = colors.orange, fg = colors.black })
    end
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
    -- TODO: this was archived and snacks.nvim was a suggested replacement
    -- See https://github.com/stevearc/dressing.nvim/issues/190
    --     https://github.com/folke/snacks.nvim/blob/main/docs/input.md
    -- For vim.ui.input and LSP renames.
    'stevearc/dressing.nvim',
    commit = '8b7ae53d7f04f33be3439a441db8071c96092d19',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('dressing').setup({
        select = { enabled = false }
      })
    end
  },
  {
    -- TODO: Consider https://github.com/ggandor/flit.nvim for enhanced f and t.
    'ggandor/leap.nvim',
    commit = '68ca052dfdcda5e4e958d1ba0fef35e94a3e02e8',
    config = function()
      -- Map z instead of s in operator pending mode as it conflicts with cs, ds, and ys for surround in normal mode.
      -- https://www.reddit.com/r/neovim/comments/13j3j45/comment/jkcuj2b/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
      -- x is for visual mode, see :help map-modes
      vim.keymap.set({ 'n', 'x' }, 's', '<Plug>(leap-forward)')
      vim.keymap.set({ 'n', 'x' }, 'S', '<Plug>(leap-backward)')
      vim.keymap.set('o', 'z', '<Plug>(leap-forward)')
      vim.keymap.set('o', 'Z', '<Plug>(leap-backward)')
    end
  },
  -- TODO: Plugins under consideration:
  -- { 'andymas/vim-matchup' },
  {
    'sphamba/smear-cursor.nvim',
    opts = {
      -- Smooth cursor without smear
      stiffness = 0.5,
      trailing_stiffness = 0.5,
      damping = 0.67,
      matrix_pixel_threshold = 0.5,
    },
  },
  --
  -- smooth scrolling
  -- { 'karb94/neoscroll.nvim' },
  -- { 'psliwka/vim-smoothie' },
  --
  -- { 'SmiteshP/nvim-navic' },
  -- { 'chentoast/marks.nvim' },
  -- { 'chrisgrieser/nvim-rip-substitute' },
  -- { 'chrisgrieser/nvim-spider' }, -- camel case / snake case motions

  -- TEXT OBJECTS PLUGINS
  -- Read https://thevaluable.dev/vim-create-text-objects/
  -- Similar to subword text object in nvim-various-textobjs, but uses v instead of S.
  -- { 'Julian/vim-textobj-variable-segment' },

  -- text objects of interest are subword, quote, value, key, number, and html attribute
  -- { 'chrisgrieser/nvim-various-textobjs' },

  -- Has special operators to specially handle whitespace (like `I` and `A`)
  -- { 'wellle/targets.vim' },

  -- ciq - change in quotes "" '' or ``
  -- { 'echasnovski/mini.ai' },
  {
    'gbprod/substitute.nvim',
    commit = '9db749a880e3dd3b0eb57f698aa8f1e1630e1f25',
    config = function()
      require('substitute').setup()
      vim.keymap.set('n', 'gs', require('substitute').operator, { noremap = true })
      vim.keymap.set('x', 'gs', require('substitute').visual, { noremap = true })
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
  -- TODO: Consider java.nvim for file renames.
  -- https://github.com/simaxme/java.nvim/tree/main
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
  -- TODO: Look at opening last edited file automatically or automatically saving sessions per project
  -- https://neovimcraft.com/?search=tag%3Asession
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
