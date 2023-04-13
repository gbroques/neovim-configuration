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
    { name = 'buffer', option = { keyword_length = 5 } } -- increase from default of 3
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
local onedark = require('onedark')
onedark.setup  {
    style = 'cool', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = true, -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    code_style = {
        comments = 'none'
    },
    colors = {
        -- Override grey with tint for lighter line numbers.
        -- https://github.com/navarasu/onedark.nvim/blob/932a86846d51f3d39a99f7e4d0c0ec34d4e404d3/lua/onedark/palette.lua#L75
        -- https://www.color-hex.com/color/546178
        grey = "#8790A0",
        -- Override bg1 with shade for darker cursor line.
        -- https://github.com/navarasu/onedark.nvim/blob/932a86846d51f3d39a99f7e4d0c0ec34d4e404d3/lua/onedark/palette.lua#L61
        -- https://www.color-hex.com/color/2d3343
        bg1 = '#242835',
        -- Override foreground with tint.
        -- https://github.com/navarasu/onedark.nvim/blob/932a86846d51f3d39a99f7e4d0c0ec34d4e404d3/lua/onedark/palette.lua#L67
        -- https://www.color-hex.com/color/a5b0c5
        fg = '#b7bfd0'
    }
}
onedark.load()

require('lualine').setup {
    options = {
      theme = 'onedark'
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

