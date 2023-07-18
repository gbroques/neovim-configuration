require('globals')
require('autocmd')
require('plugins')
require('keymaps')
require('options')
require('user.telescope')
require('user.autopairs')
require('user.completion')
require('user.colorscheme')
require('user.explorer')
require('user.lsp')
-- statusline must be required after lsp module
-- since it defines diagnostic signs
require('user.statusline')
require('user.tree-sitter')
require('user.comment')
require('user.git')
require('user.which-key')
require('user.incremental-rename')
require('user.indent-guide')
require('user.illuminate')
require('user.scrollbar')
require('user.project')
require('user.start-screen')
require('user.spectre')
require('user.dap')
require('user.fold')
