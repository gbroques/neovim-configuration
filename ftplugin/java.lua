-- Eclipse Java development tools (JDT) Language Server downloaded from:
-- https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.21.0/jdt-language-server-1.21.0-202303161431.tar.gz
local jdtls = require('jdtls')
local jdtls_path = '~/jdt-language-server'
local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

vim.o.tabstop = 4
vim.o.shiftwidth = 0

-- for completions
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    capabilities = capabilities,
    cmd = {
        -- java MUST be in PATH and version 17 or greater.
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1G",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-jar", launcher_jar,
        "-configuration", vim.fs.normalize(jdtls_path .. '/config_win'),
        "-data", vim.fn.expand('~/.cache/jdtls-workspace/') .. workspace_dir
    },
    settings = {
        ['java.format.settings.url'] = vim.fn.expand("~/.vscode/formatter.xml")
    },
    root_dir = vim.fs.dirname(vim.fs.find({'pom.xml', '.git'}, { upward = true })[1]),
    init_options = {
        -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Language-Server-Settings-&-Capabilities#extended-client-capabilities
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
    },
    on_attach = function(client, bufnr)
        -- https://github.com/mfussenegger/dotfiles/blob/833d634251ebf3bf7e9899ed06ac710735d392da/vim/.config/nvim/ftplugin/java.lua#L88-L94
        local opts = { silent = true, buffer = bufnr }
        -- Alt + O for organizing imports.
        vim.keymap.set('n', "<A-o>", jdtls.organize_imports, opts)
        vim.keymap.set('n', "<leader>df", jdtls.test_class, opts)
        vim.keymap.set('n', "<leader>dn", jdtls.test_nearest_method, opts)
        -- cr for (c)ode (r)efactor
        vim.keymap.set('n', "crv", jdtls.extract_variable, opts)
        vim.keymap.set('v', 'crm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)
        vim.keymap.set('n', "crc", jdtls.extract_constant, opts)
    end
}

jdtls.start_or_attach(config)
