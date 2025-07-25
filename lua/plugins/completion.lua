return {
  {
    'hrsh7th/nvim-cmp',
    commit = 'b5311ab3ed9c846b585c0c15b7559be131ec4be9',
    dependencies = {
      -- Completion sources
      {
        'hrsh7th/cmp-nvim-lsp',
        commit = 'a8912b88ce488f411177fc8aed358b04dc246d7b'
      },
      {
        'hrsh7th/cmp-buffer',
        commit = 'b74fab3656eea9de20a9b8116afa3cfc4ec09657'
      },
      {
        -- TODO: checkhealth reports vim.validate is deprecated.
        -- See https://github.com/hrsh7th/cmp-path/issues/81
        'hrsh7th/cmp-path',
        commit = 'e52e640b7befd8113b3350f46e8cfcfe98fcf730'
      },
      {
        'hrsh7th/cmp-cmdline',
        commit = 'd126061b624e0af6c3a556428712dd4d4194ec6d'
      },
      {
        'dmitmel/cmp-cmdline-history',
        commit = '003573b72d4635ce636234a826fa8c4ba2895ffe'
      },
      {
        'hrsh7th/cmp-nvim-lsp-signature-help',
        commit = '031e6ba70b0ad5eee49fd2120ff7a2e325b17fa7'
      },
      {
        'hrsh7th/cmp-nvim-lsp-document-symbol',
        commit = 'f94f7ba948e32cd302caba1c2ca3f7c697fb4fcf'
      },

      -- Snippets
      -- snippet engine required for JDTLS completions
      {
        'L3MON4D3/LuaSnip',
        commit = 'faf3c94a44508cec1b961406d36cc65113ff3b98',
        dependencies = { 'rafamadriz/friendly-snippets' },
        config = function()
          require('luasnip').config.setup {}
          require("luasnip.loaders.from_vscode").lazy_load()
        end
      },
      {
        'saadparwaiz1/cmp_luasnip',
        commit = '98d9cb5c2c38532bd9bdb481067b20fea8f32e90'
      },
      {
        'rafamadriz/friendly-snippets',
        commit = '572f5660cf05f8cd8834e096d7b4c921ba18e175',
      },
    },
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      -- https://github.com/LunarVim/LunarVim/blob/1.2.0/lua/lvim/icons.lua#L2-L37
      local kind_icons = {
        Array = "",
        Boolean = "",
        Class = "",
        Color = "",
        Constant = "",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "",
        File = "",
        Folder = "󰉋",
        Function = "",
        Interface = "",
        Key = "",
        Keyword = "",
        Method = "",
        Module = "",
        Namespace = "",
        Null = "ﳠ",
        Number = "",
        Object = "",
        Operator = "",
        Package = "",
        Property = "",
        Reference = "",
        Snippet = "",
        String = "",
        Struct = "",
        Text = "",
        TypeParameter = "",
        Unit = "",
        Value = "",
        Variable = "",
      }

      cmp.setup({
        view = {
          entries = { name = 'custom', selection_order = 'near_cursor' }
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'nvim_lsp_signature_help' },
          {
            name = 'buffer',
            -- increase from default of 3
            option = { keyword_length = 5 }
          },
          { name = 'path' }
        }),
        -- TODO: Should this be in keymaps?
        mapping = {
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          },
          -- If none selected, `select` first item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          -- "Super tab"
          -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              -- they way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            local max_width = 50
            if max_width ~= 0 and #vim_item.abbr > max_width then
              vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. '…'
            end
            local kind = vim_item.kind
            vim_item.kind = kind_icons[kind]
            vim_item.menu = ({
              nvim_lsp = kind,
              luasnip = 'Snippet',
              buffer = 'Buffer',
              path = 'Path',
              cmdline = 'CMD',
              cmdline_history = 'History'
            })[entry.source.name]
            return vim_item
          end,
        },
        experimental = {
          ghost_text = false
        }
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            -- Need to type '/@' as a trigger character.
            -- https://www.reddit.com/r/neovim/comments/z91dzb/nvim_lsp_document_symbol_doesnt_quite_work/
            { name = 'nvim_lsp_document_symbol' }
          },
          {
            {
              name = 'buffer',
              -- increase from default of 3
              option = { keyword_length = 5 }
            }
          })
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
          },
          {
            {
              name = 'cmdline',
              option = {
                ignore_cmds = { 'Man', '!' }
              },
              priority = 100
            },
            {
              name = 'cmdline_history',
              priority = 90
            }
          }
        ),
        -- https://github.com/hrsh7th/nvim-cmp/wiki/Advanced-techniques#disabling-cmdline-completion-for-certain-commands-such-as-increname
        enabled = function()
          -- Set of commands where cmp will be disabled
          local disabled = {
            IncRename = true
          }
          -- Get first word of cmdline
          local cmd = vim.fn.getcmdline():match("%S+")
          -- Return true if cmd isn't disabled
          -- else call/return cmp.close(), which returns false
          return not disabled[cmd] or cmp.close()
        end
      })
    end
  },
}
