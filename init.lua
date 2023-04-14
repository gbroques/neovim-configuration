-- General
-- -------
-- Set hybrid relative line numbers.
vim.wo.number = true
vim.wo.relativenumber = true

-- Highlight cursor line.
vim.o.cursorline = true
vim.g.mapleader = ','

-- Mappings
-- --------
-- Map leader s to save.
vim.keymap.set('n', '<leader>s', ':update<CR>')

-- Plugins
-- -------
require('plugins')

require("better_escape").setup {
    mapping = {"dh"}
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

telescope = require('telescope')
telescope.setup{
  defaults = {
    wrap_results = true,
    file_ignore_patterns = {
      ".git"
    },
    layout_config = {
      width = 0.95,
    },
  }
}
telescope.load_extension("ui-select")
telescope.load_extension("fzf")

require('nvim-autopairs').setup {}

-- Completion
local cmp = require('cmp')
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer', option = { keyword_length = 5 } }, -- increase from default of 3
    { name = 'path' }
  }),
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
})
-- Theme
-- -----
vim.o.background = 'dark'

local c = require('vscode.colors').get_colors()
require('vscode').setup({
    -- Enable transparent background
    transparent = true,
    italic_comments = true,
    disable_nvimtree_bg = true,

})
require('vscode').load()

require('lualine').setup {
    options = {
      theme = 'vscode'
    }
  }

-- Language Server Protocol
-- ------------------------
-- https://github.com/neovim/nvim-lspconfig/blob/master/README.md#suggested-configuration
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<cr>", opts)
vim.keymap.set('n', 'gW', "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts)
vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = true }
end, opts)

