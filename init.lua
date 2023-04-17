-- Mappings
-- --------
vim.g.mapleader = ' '
-- Map leader s to save.
vim.keymap.set('n', '<leader>s', ':update<CR>')
-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- https://github.com/neovim/nvim-lspconfig/blob/master/README.md#suggested-configuration
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename)
vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<cr>")
vim.keymap.set('n', 'gW', "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
vim.keymap.set('n', '<space>f', function()
  vim.lsp.buf.format { async = true }
end)
-- e for explorer
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>')

require('options')
require('plugins')

-- better-escape
require("better_escape").setup {
  mapping = { "dh" }
}


local telescope = require('telescope')
telescope.setup {
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

-- autopairs
require('nvim-autopairs').setup {}

-- completion
local cmp = require('cmp')

-- snippet engine required for JDTLS completions
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
    { name = 'nvim_lua' },
    { name = 'buffer',  option = { keyword_length = 5 } }, -- increase from default of 3
    { name = 'path' }
  }),
  -- TODO: Should this be in keymaps?
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
})

-- theme
-- -----
vim.cmd("colorscheme darkplus")
-- https://github.com/LunarVim/darkplus.nvim/blob/master/lua/darkplus/theme.lua#L303
local c = require('darkplus.palette')

-- override italic to false
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = c.info, bg = 'NONE', bold = true, italic = false, })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = c.folder_blue, bg = 'NONE', bold = true, italic = false, })

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end
local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

-- lualine
require("lualine").setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
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
    } },
    lualine_x = { {
      "diff",
      colored = false,
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      cond = hide_in_width,
    }, spaces, "encoding", {
      "filetype",
      icons_enabled = false,
    } },
    lualine_y = { { "location", padding = 1 } },
    lualine_z = { "progress" },
  },
}

-- nvim-tree
require('nvim-tree').setup {
  renderer = {
    -- for Java development
    group_empty = true,
  },
}

-- bufferline
require("bufferline").setup {
  options = {
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
  },
  highlights = { buffer_selected = { italic = false } }
}

-- Language Server Protocol
-- ------------------------
require 'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        -- Disable pop-ups about 3rd parties.
        -- https://github.com/LuaLS/lua-language-server/discussions/1688
        checkThirdParty = false
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
