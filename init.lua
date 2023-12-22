require('globals')
require('autocmd')
require('plugin-manager')
require('keymaps')
require('options')
require('user.diagnostics')
-- statusline must be required after lsp module
-- since it defines diagnostic signs
require('user.statusline')
require('user.incremental-rename')
require('user.project')
