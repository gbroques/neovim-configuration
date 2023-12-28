return {
  {
    -- Configuration for Neovim's LSP client.
    'neovim/nvim-lspconfig',
    commit = 'b6b34b9acf84949f0ac1c00747765e62b81fb38d',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'williamboman/mason.nvim',
        commit = '41e75af1f578e55ba050c863587cffde3556ffa6',
        config = function()
          require('mason').setup({
            -- Uncomment for troubleshooting:
            -- log_level = vim.log.levels.DEBUG,
            ui = {
              -- Fullscreen
              height = vim.o.lines - 1,
              width = vim.o.columns
            },
          })
        end
      },
      {
        'williamboman/mason-lspconfig.nvim',
        commit = '56e435e09f8729af2d41973e81a0db440f8fe9c9',
        config = function()
          require('mason-lspconfig').setup({
            ensure_installed = { 'lua_ls' },
          })
        end
      },
      { 'hrsh7th/cmp-nvim-lsp' },
      {
        -- Neovim Plugin Development
        'folke/neodev.nvim',
        tag = 'v2.5.2',
      },
    },
    config = function()
      local lspconfig = require('lspconfig')
      local client_capabilities = vim.lsp.protocol.make_client_capabilities()
      -- turn on `window/workDoneProgress` capability
      local capabilities = require('cmp_nvim_lsp').default_capabilities(client_capabilities)
      -- Folding
      -- Advertise foldingRange client capability to server.
      -- Neovim hasn't added foldingRange to default capabilities.
      -- https://github.com/kevinhwang91/nvim-ufo
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }
      -- setup inspired from LunarVim
      -- https://github.com/LunarVim/Launch.nvim/blob/e4d2fb941ecce66cc012ee88ddb997dc9185aedc/lua/user/lspconfig.lua#L51-L116
      local servers = {
        'lua_ls',
        'tsserver',
        'jedi_language_server'
      }
      for _, server in ipairs(servers) do
        local opts = {
          capabilities = capabilities,
        }

        local require_ok, settings = pcall(require, 'plugins.language-server-settings.' .. server)
        if require_ok then
          opts = vim.tbl_deep_extend('force', settings, opts)
        end

        -- IMPORTANT: setup neodev BEFORE lspconfig.lua_ls
        if server == 'lua_ls' then
          require('neodev').setup({})
        end

        lspconfig[server].setup(opts)
      end
      -- YAML
      -- TODO: Get OpenAPI workflow for Neovim working.
      -- See plugins.lua. Need a swagger ui previewer.
      -- require('lspconfig').yamlls.setup {
      --   capabilities = capabilities,
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "/*.yaml",
      --       },
      --     },
      --   }
      -- }
    end
  },
  {
    -- Adapts linters & formatters to Neovim's LSP client.
    -- Alternatives:
    -- 'stevearc/conform.nvim' - Lightweight yet powerful formatter plugin for Neovim
    -- 'mattn/efm-langserver' - General purpose Language Server that can use specified error message format generated from specified command.
    -- 'iamcco/diagnostic-languageserver' - General purpose Language Server that integrate with linter to support diagnostic features
    -- need to figure out eslint_d alternative
    -- See lsp.lua
    'nvimtools/none-ls.nvim',
    commit = 'bbaf5a96913aa92281f154b08732be2f57021c45',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local null_ls = require('null-ls')

      local eslint_config_path = os.getenv('ESLINT_CONFIG_PATH')

      null_ls.setup({
        debug = true,
        sources = {
          -- JavaScript
          -- Pass --debug in extra_args to troubleshoot issues.
          null_ls.builtins.diagnostics.eslint_d.with({
            extra_args = { '--config', eslint_config_path }
          }),
          null_ls.builtins.formatting.eslint_d.with({
            extra_args = { '--config', eslint_config_path }
          }),

          -- Python
          null_ls.builtins.diagnostics.flake8,  -- linter
          null_ls.builtins.diagnostics.mypy,    -- static type checker
          null_ls.builtins.formatting.autopep8, -- formatter
          null_ls.builtins.formatting.isort,    -- import sorter
        },
      })
    end
  },
}
