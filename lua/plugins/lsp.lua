return {
  {
    -- Configuration for Neovim's LSP client.
    'neovim/nvim-lspconfig',
    commit = 'b6b34b9acf84949f0ac1c00747765e62b81fb38d',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      -- Lua (Neovim Plugin Development)
      {
        'folke/neodev.nvim',
        tag = 'v2.5.2',
        config = true -- IMPORTANT: setup neodev BEFORE lspconfig.lua_ls
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
      }
      for _, server in pairs(servers) do
        local opts = {
          capabilities = capabilities,
        }

        local require_ok, settings = pcall(require, 'plugins.language-server-settings.' .. server)
        if require_ok then
          opts = vim.tbl_deep_extend('force', settings, opts)
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
    -- TODO: null-ls is archived
    -- none-ls is a drop-in replacement
    -- conform.nvim is also suggested
    -- need to figure out eslint_d alternative
    -- See lsp.lua
    'jose-elias-alvarez/null-ls.nvim',
    commit = 'bbaf5a96913aa92281f154b08732be2f57021c45',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local null_ls = require('null-ls')

      local eslint_config_path = os.getenv('ESLINT_CONFIG_PATH')

      null_ls.setup({
        debug = true,
        sources = {
          -- Pass --debug in extra_args to troubleshoot issues.
          null_ls.builtins.diagnostics.eslint_d.with({
            extra_args = { '--config', eslint_config_path }
          }),
          null_ls.builtins.formatting.eslint_d.with({
            extra_args = { '--config', eslint_config_path }
          }),
        },
      })
    end
  },
}
