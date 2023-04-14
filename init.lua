-- General
-- -------
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.fileencoding = "utf-8" -- the encoding written to a file

vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.mouse = 'a' -- allow mouse in neovim

-- Set hybrid relative line numbers.
vim.wo.number = true
vim.wo.relativenumber = true

-- Highlight cursor line.
vim.opt.cursorline = true

-- for bufferline
vim.opt.termguicolors = true

vim.g.mapleader = ' '

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

-- telescope
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

-- Snippet engine required for JDTLS completions
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
vim.cmd("colorscheme darkplus")
local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end
local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end
require("lualine").setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = ""},
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { {
     "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " " },
      colored = true,
      always_visible = true,
    }},
    lualine_x = { {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width,
  }, spaces, "encoding",  {
    "filetype",
    icons_enabled = false,
  }},
    lualine_y = { { "location", padding = 1 } },
    lualine_z = { "progress" },
  },
}
-- https://github.com/LunarVim/darkplus.nvim/blob/master/lua/darkplus/theme.lua#L303
local c = require('darkplus.palette')

-- override italic to false
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = c.info, bg = 'NONE', bold = true, italic = false, })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = c.folder_blue, bg = 'NONE', bold = true, italic = false, })


require('nvim-tree').setup {
  renderer = {
    -- for Java development
    group_empty = true,
  },
}
-- e for explorer
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>', opts)

-- bufferline
require("bufferline").setup{
  options = {
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
  },
  highlights = { buffer_selected = { italic = false } }
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

