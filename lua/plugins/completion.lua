return {
  {
    'hrsh7th/nvim-cmp',
    commit = 'e1f1b40790a8cb7e64091fb12cc5ffe350363aa0',
    dependencies = {
      -- Completion sources
      {
        'hrsh7th/cmp-nvim-lsp',
        commit = '44b16d11215dce86f253ce0c30949813c0a90765'
      },
      {
        'hrsh7th/cmp-buffer',
        commit = '3022dbc9166796b644a841a02de8dd1cc1d311fa'
      },
      {
        'hrsh7th/cmp-path',
        commit = '91ff86cd9c29299a64f968ebb45846c485725f23'
      },
      {
        'hrsh7th/cmp-cmdline',
        commit = '8ee981b4a91f536f52add291594e89fb6645e451'
      },
      {
        'dmitmel/cmp-cmdline-history',
        commit = '003573b72d4635ce636234a826fa8c4ba2895ffe'
      },
      {
        'hrsh7th/cmp-nvim-lsp-signature-help',
        commit = '3d8912ebeb56e5ae08ef0906e3a54de1c66b92f1'
      },
      {
        'hrsh7th/cmp-nvim-lsp-document-symbol',
        commit = 'f0f53f704c08ea501f9d222b23491b0d354644b0'
      },

      -- Snippets
      -- snippet engine required for JDTLS completions
      {
        'L3MON4D3/LuaSnip',
        tag = "v1.2.1",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require('luasnip').config.setup {}
          require("luasnip.loaders.from_vscode").lazy_load()
        end
      },
      {
        'saadparwaiz1/cmp_luasnip',
        commit = '18095520391186d634a0045dacaa346291096566'
      },
      {
        'rafamadriz/friendly-snippets',
        commit = '5749f093759c29e3694053d048ceb940fe12c3d3',
      },

      -- Autopairs
      {
        'windwp/nvim-autopairs',
        commit = 'e8f7dd7a72de3e7b6626c050a802000e69d53ff0',
        config = function()
          require('nvim-autopairs').setup {
            check_ts = true, -- treesitter integration
          }

          -- Insert parentheses () after completing function or method.
          local cmp_autopairs = require('nvim-autopairs.completion.cmp')
          local cmp = require('cmp')
          cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done {})
        end
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
        Folder = "",
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
              luasnip = "Snippet",
              buffer = "Buffer",
              path = "Path",
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
  }
}
