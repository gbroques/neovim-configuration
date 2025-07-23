return {
  {
    -- Configuration for Neovim's LSP client.
    'neovim/nvim-lspconfig',
    tag = 'v2.3.0',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'williamboman/mason.nvim',
        tag = 'v2.0.0',
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
        tag = 'v2.0.0',
        config = function()
          require('mason-lspconfig').setup({
            ensure_installed = { 'lua_ls' },
          })
        end
      },
      { 'hrsh7th/cmp-nvim-lsp' },
      {
        -- Neovim Plugin Development
        'folke/lazydev.nvim',
        tag = 'v1.9.0',
        ft = 'lua', -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
      {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          table.insert(opts.sources, {
            name = "lazydev",
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
          })
        end,
      },
    },
    config = function()
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
      vim.lsp.config('*', {
        capabilities = capabilities
      })
      -- setup inspired from LunarVim
      -- https://github.com/LunarVim/Launch.nvim/blob/e4d2fb941ecce66cc012ee88ddb997dc9185aedc/lua/user/lspconfig.lua#L51-L116
      local servers = {
        'lua_ls',
        'ts_ls',
        'eslint',
        'jedi_language_server',
        'clangd'
      }
      for _, server in ipairs(servers) do
        local opts = {}
        local require_ok, settings = pcall(require, 'plugins.language-server-settings.' .. server)
        if require_ok then
          opts = vim.tbl_deep_extend('force', settings, opts)
        end

        -- IMPORTANT: setup neodev BEFORE lspconfig.lua_ls
        if server == 'lua_ls' then
          -- require('neodev').setup({})
        end

        vim.lsp.config(server, opts)
        vim.lsp.enable(server)
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
    commit = 'dcc8cd4efdcb29275681a3c95786a816330dbca6',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local null_ls = require('null-ls')

      -- local eslint_config_path = os.getenv('ESLINT_CONFIG_PATH')

      null_ls.setup({
        debug = true,
        sources = {
          -- TODO
          -- https://github.com/nvimtools/none-ls.nvim/issues/58
          -- JavaScript
          -- Pass --debug in extra_args to troubleshoot issues.
          -- use eslint-language-server instead
          -- null_ls.builtins.diagnostics.eslint_d.with({
          --   extra_args = { '--config', eslint_config_path }
          -- }),
          -- null_ls.builtins.formatting.eslint_d.with({
          --   extra_args = { '--config', eslint_config_path }
          -- }),

          -- Python
          -- use ruff / available in none-ls-extras.nvim
          -- https://github.com/astral-sh/ruff-lsp
          -- null_ls.builtins.diagnostics.flake8,  -- linter
          null_ls.builtins.diagnostics.mypy, -- static type checker
          -- TODO: use ruff
          -- null_ls.builtins.formatting.autopep8, -- formatter
          null_ls.builtins.formatting.isort, -- import sorter
        },
      })
    end
  },
}
