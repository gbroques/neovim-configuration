-- TODO: Consider moving this to config function of nvim-jdtls
-- Eclipse Java development tools (JDT) Language Server downloaded from:
-- https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.24.0/jdt-language-server-1.24.0-202306011728.tar.gz
local jdtls = require('jdtls')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Paths
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
local function join_path(...)
  local segments = { ... }
  -- TODO: Get different path separator by OS.
  local sep = '\\'
  local path = ''
  for i, segment in ipairs(segments) do
    if i == 1 then -- first index starts at 1
      path = segment
    else
      path = path .. sep .. segment
    end
  end
  return path
end
local java_path = join_path('C:', 'Program Files', 'Java', 'jdk-17.0.4.1', 'bin', 'java')
local formatter_settings_path = vim.fn.expand(join_path('~', '.vscode', 'formatter.xml'))
local jdtls_path = join_path(vim.fn.stdpath('data'), 'language-servers', 'jdt-language-server-1.24')
local mason_packages_path = join_path(vim.fn.stdpath('data'), 'mason', 'packages')
local java_debug_path = vim.fn.glob(join_path(mason_packages_path,
  'java-debug-adapter', 'extension', 'server', 'com.microsoft.java.debug.plugin-*.jar'))
local vscode_java_test_paths = vim.fn.glob(join_path(mason_packages_path,
  'java-test', 'extension', 'server', '*.jar'), true)
vscode_java_test_paths = vim.split(vscode_java_test_paths, '\n')
vscode_java_test_paths = vim.tbl_filter(function(path)
  return not vim.endswith(path, 'com.microsoft.java.test.runner-jar-with-dependencies.jar')
end, vscode_java_test_paths)
local launcher_jar_path = vim.fn.glob(join_path(jdtls_path, 'plugins', 'org.eclipse.equinox.launcher_*.jar'))
-- -----------------------------------------------------------------------------------------------------------------------------------------------------

local bundles = {
  java_debug_path
}
vim.list_extend(bundles, vscode_java_test_paths)

-- Neovim tabstop & shiftwidth have higher priority than Java Eclipse formatter settings.
-- https://github.com/mfussenegger/nvim-jdtls#indentation-settings-from-eclipse-formatting-configuration-are-not-recognized
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
local java_test_config = { vmArgs = '-XX:+AllowRedefinitionToAddDeleteMethods', shortenCommandLine = 'jarmanifest' }
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
    "-configuration", join_path(jdtls_path, get_config_dir()),
    -- TODO Should this be in stdpath('data')?
    "-data", vim.fn.expand(join_path('~', '.cache', 'jdtls-workspace', workspace_dir))
  },
  settings = {
    java = {
      format = {
        settings = {
          url = formatter_settings_path
        }
      },
      configuration = {
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- And search for `interface RuntimeOption`
        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
        runtimes = {
          {
            name = 'JavaSE-11',
            path = 'C:\\Program Files\\AdoptOpenJDK\\jdk-11.0.10.9-hotspot',
          },
          {
            name = "JavaSE-17",
            path = 'C:\\Program Files\\Java\\jdk-17.0.4.1',
          },
        }
      },
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.jupiter.api.Assumptions.*",
          "org.junit.jupiter.api.DynamicContainer.*",
          "org.junit.jupiter.api.DynamicTest.*",
          "org.mockito.Mockito.*",
          "org.mockito.ArgumentMatchers.*",
          "org.mockito.Answers.*",
          "org.hamcrest.MatcherAssert.*",
          "org.hamcrest.Matchers.*",
          "org.springframework.test.web.servlet.result.MockMvcResultHandlers.*",
          "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
          "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*"
        },
        importOrder = {
          "java",
          "javax",
          "org",
          "com"
        }
      }
    }
  },
  -- find_root duplicated in keymaps.lua
  root_dir = require('jdtls.setup').find_root({ 'pom.xml', '.git' }),
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
    -- Should these be in keymaps?
    vim.keymap.set('n', '<leader>lo', jdtls.organize_imports, { desc = 'Organize imports', buffer = bufnr })
    -- Should 'd' be reserved for debug?
    vim.keymap.set('n', '<leader>df', function()
      jdtls.test_class({ config_overrides = java_test_config })
    end, { desc = 'Test class (debug full)', buffer = bufnr })
    vim.keymap.set('n', '<leader>dn', function()
      jdtls.test_nearest_method({ config_overrides = java_test_config })
    end, { desc = 'Test method (debug nearest)' })
    vim.keymap.set('n', '<leader>rv', jdtls.extract_variable_all, { desc = 'Extract variable', buffer = bufnr })
    vim.keymap.set('v', '<leader>rm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
      { desc = 'Extract method', buffer = bufnr })
    vim.keymap.set('n', '<leader>rc', jdtls.extract_constant, { desc = 'Extract constant', buffer = bufnr })
  end
}

jdtls.start_or_attach(config)
