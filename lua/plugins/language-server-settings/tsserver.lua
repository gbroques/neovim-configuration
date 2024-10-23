-- TODO: Should we replace this with typescript-tools.nvim to support tsserver's off-spec features?
--       https://github.com/pmizio/typescript-tools.nvim
--       https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins
return {
  on_attach = function(client, bufnr)
    if client.name == 'ts_ls' then
      -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
  end
}
