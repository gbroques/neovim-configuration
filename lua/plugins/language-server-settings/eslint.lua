return {
  settings = {
    nodePath = os.getenv('ESLINT_NODE_PATH'),
    options = {
      overrideConfigFile = os.getenv('ESLINT_CONFIG_FILE')
    }
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      command = 'EslintFixAll',
    })
  end
}
