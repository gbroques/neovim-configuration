-- Eclipse Java development tools (JDT) Language Server downloaded from:
-- https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.21.0/jdt-language-server-1.21.0-202303161431.tar.gz
local jdtls = require('jdtls')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Paths
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
local java_path = 'C:/Program Files/Java/jdk-17.0.4.1/bin/java'
local formatter_settings_path = '~/.vscode/formatter.xml'
local jdtls_path = vim.fn.stdpath('data') .. '/language-servers/jdt-language-server'
local java_debug_path = vim.fn.glob(vim.fn.stdpath('data') .. '/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar')
local vscode_java_test_paths = vim.fn.glob(vim.fn.stdpath('data') .. '/vscode-java-test/server/*.jar', true)
local launcher_jar_path = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
-- -----------------------------------------------------------------------------------------------------------------------------------------------------

local bundles = {
  java_debug_path
}
vim.list_extend(bundles, vim.split(vscode_java_test_paths, "\n"))
vim.o.tabstop = 4
vim.o.shiftwidth = 0

-- for completions
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)

local function get_config_dir()
  -- Unlike some other programming languages (e.g. JavaScript)
  -- lua considers 0 truthy!
  if vim.fn.has('linux') == 1 then
    return 'config_linux'
  elseif vim.fn.has('mac') == 1 then
    return 'config_mac'
  else
    return 'config_win'
  end
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
-- https://github.com/microsoft/vscode-java-test/wiki/Run-with-Configuration#property-details
local java_test_config = { vmArgs = { '-XX:+AllowRedefinitionToAddDeleteMethods' } }
local config = {
  capabilities = capabilities,
  cmd = {
    java_path,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1G",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", launcher_jar_path,
    "-configuration", vim.fs.normalize(jdtls_path .. '/' .. get_config_dir()),
    "-data", vim.fn.expand('~/.cache/jdtls-workspace/') .. workspace_dir
  },
  settings = {
    ['java.format.settings.url'] = vim.fn.expand("~/.vscode/formatter.xml"),
  },
  root_dir = vim.fs.dirname(vim.fs.find({ 'pom.xml', '.git' }, { upward = true })[1]),
  init_options = {
    -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Language-Server-Settings-&-Capabilities#extended-client-capabilities
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
    bundles = bundles
  },
  on_attach = function(client, bufnr)
    -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
    -- you make during a debug session immediately.
    -- Remove the option if you do not want that.
    -- You can use the `JdtHotcodeReplace` command to trigger it manually
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })

    -- https://github.com/mfussenegger/dotfiles/blob/833d634251ebf3bf7e9899ed06ac710735d392da/vim/.config/nvim/ftplugin/java.lua#L88-L94
    -- Should these be in keymaps and have desc?
    local opts = { silent = true, buffer = bufnr }
    vim.keymap.set('n', "<leader>lo", jdtls.organize_imports, { desc = 'Organize imports', buffer = bufnr })
    -- Should 'd' be reserved for debug?
    vim.keymap.set('n', "<leader>df", function() jdtls.test_class({ config_overrides = java_test_config }) end, opts)
    vim.keymap.set('n', "<leader>dn", function() jdtls.test_nearest_method({ config_overrides = java_test_config }) end, opts)
    vim.keymap.set('n', '<leader>rv', jdtls.extract_variable_all, { desc = 'Extract variable', buffer = bufnr })
    vim.keymap.set('v', '<leader>rm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], { desc = 'Extract method', buffer = bufnr })
    vim.keymap.set('n', '<leader>rc', jdtls.extract_constant, { desc = 'Extract constant', buffer = bufnr })
  end
}

jdtls.start_or_attach(config)
