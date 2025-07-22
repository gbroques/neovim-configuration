local base_on_attach = vim.lsp.config.eslint.on_attach
return {
  settings = {
    nodePath = os.getenv('ESLINT_NODE_PATH'),
    options = {
      overrideConfigFile = os.getenv('ESLINT_CONFIG_FILE')
    }
  },
  on_attach = function(client, bufnr)
    if not base_on_attach then return end
    base_on_attach(client, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      command = 'LspEslintFixAll',
    })
  end
}
